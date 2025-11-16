#!/usr/bin/env python3
"""
ETL Updater - Atualiza documentos Markdown e JSON com dados confirmados do banco
Sincroniza dados estruturados com documentos de conhecimento
"""

import sqlite3
import json
from pathlib import Path
from typing import Dict, List
from datetime import datetime


class DocumentUpdater:
    """Atualiza documentos com dados do banco"""

    def __init__(self, db_path: str = "viagem_uruguai.db"):
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
        self.project_root = Path(__file__).parent.parent

    def update_reservations_json(self):
        """Atualiza arquivo JSON de reservas"""
        json_path = self.project_root / "04_DADOS_ESTRUTURADOS" / "01_reservas_estruturadas.json"

        # Buscar reservas do banco
        cursor = self.conn.execute("""
            SELECT * FROM reservations ORDER BY date, time
        """)
        reservations = []
        for row in cursor.fetchall():
            res = {
                "id": row["reservation_id"],
                "date": row["date"],
                "time": row["time"],
                "name": row["name"],
                "location": row["location"],
                "address": row["address"],
                "type": row["type"],
                "status": row["status"]
            }

            if row["cost_per_person"]:
                res["cost"] = {
                    "per_person": row["cost_per_person"],
                    "total": row["cost_total"],
                    "currency": row["currency"]
                }
            else:
                res["cost"] = {"included": True}

            if row["transfer_included"]:
                res["transfer"] = {
                    "included": True,
                    "pickup_time": row["pickup_time"],
                    "pickup_location": row["pickup_location"],
                    "return_time": row["return_time"]
                }

            if row["dress_code"]:
                res["dress_code"] = row["dress_code"]

            if row["contact_phone"]:
                res["contact"] = row["contact_phone"]

            if row["notes"]:
                res["notes"] = row["notes"]

            reservations.append(res)

        # Buscar hotéis
        cursor = self.conn.execute("SELECT * FROM hotels ORDER BY check_in_date")
        hotel_reservations = []
        for row in cursor.fetchall():
            hotel_reservations.append({
                "id": f"HOTEL{row['id']:03d}",
                "name": row["name"],
                "location": row["location"],
                "check_in": row["check_in_date"],
                "check_out": row["check_out_date"],
                "reservation_number": row["reservation_number"],
                "pin": row["pin"],
                "status": row["status"]
            })

        # Calcular totais
        total_cost = sum(r.get("cost", {}).get("total", 0) for r in reservations if r.get("cost", {}).get("total"))
        confirmed_count = len([r for r in reservations if r["status"] == "confirmed"])

        data = {
            "reservations": reservations,
            "hotel_reservations": hotel_reservations,
            "summary": {
                "total_reservations": len(reservations),
                "total_cost_brl": total_cost,
                "confirmed": confirmed_count,
                "pending": len(reservations) - confirmed_count
            }
        }

        with open(json_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)

        print(f"✅ JSON de reservas atualizado: {json_path}")

    def update_timeline_json(self):
        """Atualiza arquivo JSON de timeline"""
        json_path = self.project_root / "04_DADOS_ESTRUTURADOS" / "03_roteiro_timeline.json"

        # Buscar itinerário do banco
        cursor = self.conn.execute("""
            SELECT * FROM itinerary ORDER BY date, event_time
        """)

        timeline = []
        current_day = None
        current_date = None

        for row in cursor.fetchall():
            if current_date != row["date"]:
                if current_day:
                    timeline.append(current_day)

                current_day = {
                    "day": row["day"],
                    "date": row["date"],
                    "weekday": row["weekday"],
                    "location": row["location"],
                    "events": []
                }
                current_date = row["date"]

            event = {
                "time": row["event_time"],
                "type": row["event_type"],
                "title": row["title"],
                "details": row["details"],
                "status": row["status"]
            }

            if row["reservation_id"]:
                event["reservation_id"] = row["reservation_id"]

            if row["notes"]:
                event["notes"] = row["notes"]

            current_day["events"].append(event)

        if current_day:
            timeline.append(current_day)

        # Buscar dados da viagem
        cursor = self.conn.execute("SELECT name FROM travelers")
        travelers = [row["name"] for row in cursor.fetchall()]

        data = {
            "trip": {
                "travelers": travelers,
                "period": {
                    "start": timeline[0]["date"] if timeline else "2025-11-18",
                    "end": timeline[-1]["date"] if timeline else "2025-11-25",
                    "days": len(timeline)
                },
                "destinations": ["Montevidéu", "Punta del Este"]
            },
            "timeline": timeline,
            "summary": {
                "total_days": len(timeline),
                "confirmed_reservations": len([e for d in timeline for e in d["events"] if e.get("status") == "confirmed"]),
                "pending_items": len([e for d in timeline for e in d["events"] if e.get("status") == "pending"]),
                "suggestions": len([e for d in timeline for e in d["events"] if e.get("status") == "suggestion"])
            }
        }

        with open(json_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)

        print(f"✅ JSON de timeline atualizado: {json_path}")

    def update_hotels_json(self):
        """Atualiza arquivo JSON de hotéis"""
        json_path = self.project_root / "04_DADOS_ESTRUTURADOS" / "04_hoteis_montevideo.json"

        cursor = self.conn.execute("SELECT * FROM hotels ORDER BY check_in_date")

        hotels = []
        confirmed_hotels = []

        for row in cursor.fetchall():
            hotel_data = {
                "id": f"HOTEL_{row['location'].replace(' ', '_').upper()}_{row['id']:03d}",
                "name": row["name"],
                "location": row["location"],
                "period": {
                    "check_in": row["check_in_date"],
                    "check_out": row["check_out_date"],
                    "nights": row["nights"]
                },
                "status": row["status"]
            }

            if row["reservation_number"]:
                hotel_data["reservation_number"] = row["reservation_number"]

            if row["pin"]:
                hotel_data["pin"] = row["pin"]

            if row["address"]:
                hotel_data["address"] = row["address"]

            if row["status"] == "confirmed":
                confirmed_hotels.append(hotel_data)
            else:
                hotels.append(hotel_data)

        # Calcular totais
        total_nights = sum(h["period"]["nights"] for h in confirmed_hotels + hotels)
        montevideo_nights = sum(h["period"]["nights"] for h in confirmed_hotels + hotels if "Montevidéu" in h["location"] or "Montevideo" in h["location"])
        pde_nights = sum(h["period"]["nights"] for h in confirmed_hotels + hotels if "Punta del Este" in h["location"])

        data = {
            "hotels": hotels,
            "confirmed_hotels": confirmed_hotels,
            "summary": {
                "total_nights": total_nights,
                "confirmed": len(confirmed_hotels),
                "pending": len(hotels),
                "locations": {
                    "montevideo": montevideo_nights,
                    "punta_del_este": pde_nights
                }
            }
        }

        with open(json_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)

        print(f"✅ JSON de hotéis atualizado: {json_path}")

    def generate_summary_report(self) -> Dict:
        """Gera relatório resumido dos dados"""
        # Estatísticas gerais
        stats = {}

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM travelers")
        stats["travelers"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM flights")
        stats["flights"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM hotels WHERE status = 'confirmed'")
        stats["confirmed_hotels"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM hotels WHERE status = 'pending'")
        stats["pending_hotels"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM reservations WHERE status = 'confirmed'")
        stats["confirmed_reservations"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM car_rentals WHERE status = 'confirmed'")
        stats["car_rentals"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM processed_documents WHERE extraction_status = 'success'")
        stats["processed_documents"] = cursor.fetchone()["count"]

        return {
            "timestamp": datetime.now().isoformat(),
            "statistics": stats,
            "status": "updated"
        }

    def close(self):
        """Fecha conexão"""
        self.conn.close()


def main():
    """Função principal"""
    project_root = Path(__file__).parent.parent
    db_path = project_root / "08_ETL_DATABASE" / "viagem_uruguai.db"

    updater = DocumentUpdater(str(db_path))

    print("📝 Atualizando documentos...")

    updater.update_reservations_json()
    updater.update_timeline_json()
    updater.update_hotels_json()

    report = updater.generate_summary_report()
    print(f"\n📊 Resumo:")
    for key, value in report["statistics"].items():
        print(f"   {key}: {value}")

    updater.close()
    print("\n✅ Documentos atualizados!")


if __name__ == "__main__":
    main()

