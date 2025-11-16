#!/usr/bin/env python3
"""
Atualiza documentos Markdown com dados confirmados do banco de dados
Sincroniza 01_BASE_CONHECIMENTO com dados reais extraídos
"""

import sqlite3
from pathlib import Path
from datetime import datetime
from typing import Dict, List


class MarkdownUpdater:
    """Atualiza documentos Markdown com dados confirmados"""

    def __init__(self, db_path: str = "viagem_uruguai.db"):
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
        self.project_root = Path(__file__).parent.parent

    def get_confirmed_flights(self) -> List[Dict]:
        """Busca voos confirmados"""
        cursor = self.conn.execute("""
            SELECT * FROM flights ORDER BY departure_date, departure_time
        """)
        return [dict(row) for row in cursor.fetchall()]

    def get_confirmed_hotels(self) -> List[Dict]:
        """Busca hotéis confirmados"""
        cursor = self.conn.execute("""
            SELECT * FROM hotels WHERE status = 'confirmed' ORDER BY check_in_date
        """)
        return [dict(row) for row in cursor.fetchall()]

    def get_confirmed_car_rental(self) -> Dict:
        """Busca aluguel de carro confirmado"""
        cursor = self.conn.execute("""
            SELECT * FROM car_rentals WHERE status = 'confirmed' LIMIT 1
        """)
        row = cursor.fetchone()
        return dict(row) if row else None

    def get_confirmed_reservations(self) -> List[Dict]:
        """Busca reservas confirmadas"""
        cursor = self.conn.execute("""
            SELECT * FROM reservations WHERE status = 'confirmed' ORDER BY date, time
        """)
        return [dict(row) for row in cursor.fetchall()]

    def generate_flights_summary(self) -> str:
        """Gera resumo de voos para inserir em documentos"""
        flights = self.get_confirmed_flights()
        if not flights:
            return "⚠️ Nenhum voo confirmado encontrado no banco de dados."

        summary = "## ✈️ VOOS CONFIRMADOS\n\n"
        for flight in flights:
            summary += f"### Voo {flight['flight_number']}\n\n"
            summary += f"| Campo | Valor |\n"
            summary += f"|-------|-------|\n"
            summary += f"| **Companhia** | {flight['airline']} |\n"
            summary += f"| **Data Partida** | {flight['departure_date']} |\n"
            summary += f"| **Hora Partida** | {flight['departure_time']} |\n"
            summary += f"| **Aeroporto Origem** | {flight['departure_airport']} ({flight['departure_city']}) |\n"
            summary += f"| **Data Chegada** | {flight['arrival_date']} |\n"
            summary += f"| **Hora Chegada** | {flight['arrival_time']} |\n"
            summary += f"| **Aeroporto Destino** | {flight['arrival_airport']} ({flight['arrival_city']}) |\n"
            if flight.get('booking_reference'):
                summary += f"| **Referência** | {flight['booking_reference']} |\n"
            if flight.get('seat'):
                summary += f"| **Assento** | {flight['seat']} |\n"
            summary += f"| **Status** | ✅ Confirmado |\n\n"

        return summary

    def generate_car_rental_summary(self) -> str:
        """Gera resumo de aluguel de carro"""
        car = self.get_confirmed_car_rental()
        if not car:
            return ""

        summary = "## 🚙 ALUGUEL DE CARRO CONFIRMADO\n\n"
        summary += f"| Campo | Valor |\n"
        summary += f"|-------|-------|\n"
        summary += f"| **Locadora** | {car['rental_company']} |\n"
        summary += f"| **Número de Confirmação** | {car['confirmation_number']} |\n"
        summary += f"| **Período** | {car['pickup_date']} a {car['return_date']} ({car['days']} dias) |\n"
        summary += f"| **Retirada** | {car['pickup_date']} às {car['pickup_time']} |\n"
        summary += f"| **Local Retirada** | {car['pickup_location']} |\n"
        summary += f"| **Devolução** | {car['return_date']} às {car['return_time']} |\n"
        summary += f"| **Local Devolução** | {car['return_location']} |\n"
        summary += f"| **Status** | ✅ Confirmado |\n\n"

        if car.get('notes'):
            summary += f"**Observações:**\n{car['notes']}\n\n"

        return summary

    def generate_status_report(self) -> str:
        """Gera relatório de status geral"""
        stats = {}

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM flights")
        stats["flights"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM hotels WHERE status = 'confirmed'")
        stats["hotels"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM reservations WHERE status = 'confirmed'")
        stats["reservations"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM car_rentals WHERE status = 'confirmed'")
        stats["car_rentals"] = cursor.fetchone()["count"]

        cursor = self.conn.execute("SELECT COUNT(*) as count FROM processed_documents WHERE extraction_status = 'success'")
        stats["documents"] = cursor.fetchone()["count"]

        report = "## 📊 STATUS GERAL DOS DADOS\n\n"
        report += f"**Última atualização:** {datetime.now().strftime('%d/%m/%Y %H:%M')}\n\n"
        report += f"| Item | Quantidade |\n"
        report += f"|------|------------|\n"
        report += f"| ✈️ Voos | {stats['flights']} |\n"
        report += f"| 🏨 Hotéis Confirmados | {stats['hotels']} |\n"
        report += f"| 📅 Reservas Confirmadas | {stats['reservations']} |\n"
        report += f"| 🚙 Aluguel de Carro | {stats['car_rentals']} |\n"
        report += f"| 📄 Documentos Processados | {stats['documents']} |\n\n"

        return report

    def close(self):
        """Fecha conexão"""
        self.conn.close()


def main():
    """Função principal"""
    project_root = Path(__file__).parent.parent
    db_path = project_root / "08_ETL_DATABASE" / "viagem_uruguai.db"

    if not db_path.exists():
        print("⚠️  Banco de dados não encontrado. Execute run_etl.py primeiro.")
        return

    updater = MarkdownUpdater(str(db_path))

    print("📝 Gerando resumos para documentos Markdown...")

    flights_summary = updater.generate_flights_summary()
    car_summary = updater.generate_car_rental_summary()
    status_report = updater.generate_status_report()

    # Salvar em arquivo temporário para revisão
    output_path = project_root / "08_ETL_DATABASE" / "markdown_updates.md"
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("# Atualizações para Documentos Markdown\n\n")
        f.write(status_report)
        f.write("\n")
        f.write(flights_summary)
        f.write("\n")
        f.write(car_summary)

    print(f"✅ Resumos gerados em: {output_path}")
    print("\n💡 Revise o arquivo e atualize manualmente os documentos Markdown conforme necessário.")

    updater.close()


if __name__ == "__main__":
    main()

