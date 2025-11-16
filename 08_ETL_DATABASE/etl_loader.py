#!/usr/bin/env python3
"""
ETL Loader - Carrega dados extraídos para o banco de dados estruturado
Atualiza tabelas com dados confirmados dos documentos
"""

import sqlite3
import json
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Any


class DataLoader:
    """Carrega dados estruturados no banco de dados"""
    
    def __init__(self, db_path: str = "viagem_uruguai.db"):
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
    
    def load_travelers(self):
        """Carrega dados dos viajantes"""
        travelers = [
            {"name": "Aline Torres", "document": None, "email": None, "phone": None},
            {"name": "Luiz Fernando Sena", "document": None, "email": None, "phone": None}
        ]
        
        for traveler in travelers:
            cursor = self.conn.execute(
                "SELECT id FROM travelers WHERE name = ?",
                (traveler["name"],)
            )
            if not cursor.fetchone():
                self.conn.execute("""
                    INSERT INTO travelers (name, document, email, phone)
                    VALUES (?, ?, ?, ?)
                """, (
                    traveler["name"],
                    traveler.get("document"),
                    traveler.get("email"),
                    traveler.get("phone")
                ))
        self.conn.commit()
    
    def load_car_rental(self, data: Dict[str, Any]):
        """Carrega dados de aluguel de carro confirmado"""
        # Dados confirmados do aluguel de carro
        car_data = {
            "rental_company": "Budget",
            "confirmation_number": "35328815BR4",
            "pickup_date": "2025-11-18",
            "pickup_time": "11:00",
            "pickup_location": "Aeroporto Internacional de Carrasco (MVD)",
            "pickup_address": "Aeroporto Carrasco, Montevidéu",
            "return_date": "2025-11-25",
            "return_time": "00:30",
            "return_location": "Aeroporto Internacional de Carrasco (MVD)",
            "return_address": "Aeroporto Carrasco, Montevidéu",
            "days": 7,
            "status": "confirmed",
            "notes": "Verificar na retirada: tag Telepeaje, política de combustível, seguro incluído"
        }
        
        # Atualizar ou inserir
        cursor = self.conn.execute(
            "SELECT id FROM car_rentals WHERE confirmation_number = ?",
            (car_data["confirmation_number"],)
        )
        existing = cursor.fetchone()
        
        if existing:
            # Atualizar
            self.conn.execute("""
                UPDATE car_rentals SET
                    rental_company = ?,
                    pickup_date = ?,
                    pickup_time = ?,
                    pickup_location = ?,
                    pickup_address = ?,
                    return_date = ?,
                    return_time = ?,
                    return_location = ?,
                    return_address = ?,
                    days = ?,
                    status = ?,
                    notes = ?,
                    updated_at = CURRENT_TIMESTAMP
                WHERE confirmation_number = ?
            """, (
                car_data["rental_company"],
                car_data["pickup_date"],
                car_data["pickup_time"],
                car_data["pickup_location"],
                car_data["pickup_address"],
                car_data["return_date"],
                car_data["return_time"],
                car_data["return_location"],
                car_data["return_address"],
                car_data["days"],
                car_data["status"],
                car_data["notes"],
                car_data["confirmation_number"]
            ))
        else:
            # Inserir
            self.conn.execute("""
                INSERT INTO car_rentals (
                    rental_company, confirmation_number, pickup_date, pickup_time,
                    pickup_location, pickup_address, return_date, return_time,
                    return_location, return_address, days, status, notes
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                car_data["rental_company"],
                car_data["confirmation_number"],
                car_data["pickup_date"],
                car_data["pickup_time"],
                car_data["pickup_location"],
                car_data["pickup_address"],
                car_data["return_date"],
                car_data["return_time"],
                car_data["return_location"],
                car_data["return_address"],
                car_data["days"],
                car_data["status"],
                car_data["notes"]
            ))
        self.conn.commit()
    
    def load_hotels(self):
        """Carrega dados de hotéis confirmados"""
        hotels = [
            {
                "name": "Barradas Parque Hotel & Spa",
                "location": "Punta del Este",
                "check_in_date": "2025-11-20",
                "check_out_date": "2025-11-23",
                "nights": 3,
                "reservation_number": "6417055860",
                "pin": "2921",
                "status": "confirmed"
            }
        ]
        
        for hotel in hotels:
            cursor = self.conn.execute(
                "SELECT id FROM hotels WHERE reservation_number = ?",
                (hotel["reservation_number"],)
            )
            if not cursor.fetchone():
                self.conn.execute("""
                    INSERT INTO hotels (
                        name, location, check_in_date, check_out_date,
                        nights, reservation_number, pin, status
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """, (
                    hotel["name"],
                    hotel["location"],
                    hotel["check_in_date"],
                    hotel["check_out_date"],
                    hotel["nights"],
                    hotel["reservation_number"],
                    hotel["pin"],
                    hotel["status"]
                ))
        self.conn.commit()
    
    def load_reservations(self):
        """Carrega reservas confirmadas"""
        reservations = [
            {
                "reservation_id": "RES001",
                "name": "Pizzorno Tour",
                "type": "tour",
                "date": "2025-11-19",
                "time": "09:30",
                "location": "Montevidéu",
                "address": "Vinícola Pizzorno, 20 km ao norte de Montevidéu",
                "cost_per_person": 697.00,
                "cost_total": 1394.00,
                "currency": "BRL",
                "status": "confirmed",
                "transfer_included": True,
                "pickup_time": "09:30",
                "pickup_location": "Hotel em Punta Carretas/Pocitos",
                "return_time": "14:30"
            },
            {
                "reservation_id": "RES002",
                "name": "Pré-Wedding L'Incanto",
                "type": "event",
                "date": "2025-11-20",
                "time": "18:30",
                "location": "Punta del Este",
                "address": "Porto de Punta, rua 21, Punta del Este",
                "status": "confirmed",
                "dress_code": "Casual Chique"
            },
            {
                "reservation_id": "RES003",
                "name": "Casamento Fasano",
                "type": "event",
                "date": "2025-11-22",
                "time": "16:30",
                "location": "Punta del Este",
                "address": "Hotel Fasano Las Piedras, Região Las Piedras",
                "status": "confirmed",
                "dress_code": "Esporte Fino"
            },
            {
                "reservation_id": "RES004",
                "name": "Primuseum",
                "type": "event",
                "date": "2025-11-23",
                "time": "20:30",
                "location": "Montevidéu",
                "address": "Primuseum, Cidade Velha, Montevidéu",
                "cost_per_person": 380.00,
                "cost_total": 760.00,
                "currency": "BRL",
                "status": "confirmed",
                "contact_phone": "+598 99 2176 45",
                "transfer_included": True
            },
            {
                "reservation_id": "RES005",
                "name": "Bouza Tour",
                "type": "tour",
                "date": "2025-11-24",
                "time": "10:30",
                "location": "Montevidéu",
                "address": "Bodega Bouza, Melilla (15-20 min de Montevidéu)",
                "cost_per_person": 990.00,
                "cost_total": 1980.00,
                "currency": "BRL",
                "status": "confirmed",
                "transfer_included": True,
                "pickup_time": "10:30",
                "return_time": "15:00"
            }
        ]
        
        for res in reservations:
            cursor = self.conn.execute(
                "SELECT id FROM reservations WHERE reservation_id = ?",
                (res["reservation_id"],)
            )
            if cursor.fetchone():
                # Atualizar campos
                update_fields = []
                values = []
                for key, value in res.items():
                    if key != "reservation_id":
                        update_fields.append(f"{key} = ?")
                        values.append(value)
                values.append(res["reservation_id"])
                
                self.conn.execute(f"""
                    UPDATE reservations SET
                        {', '.join(update_fields)},
                        updated_at = CURRENT_TIMESTAMP
                    WHERE reservation_id = ?
                """, values)
            else:
                # Inserir
                keys = list(res.keys())
                placeholders = ', '.join(['?' for _ in keys])
                self.conn.execute(f"""
                    INSERT INTO reservations ({', '.join(keys)})
                    VALUES ({placeholders})
                """, list(res.values()))
        self.conn.commit()
    
    def load_itinerary(self):
        """Carrega itinerário detalhado"""
        # Dados do itinerário serão carregados do JSON existente
        itinerary_json_path = Path(__file__).parent.parent / "04_DADOS_ESTRUTURADOS" / "03_roteiro_timeline.json"
        
        if itinerary_json_path.exists():
            with open(itinerary_json_path, 'r', encoding='utf-8') as f:
                itinerary_data = json.load(f)
            
            # Limpar itinerário existente
            self.conn.execute("DELETE FROM itinerary")
            
            for day_data in itinerary_data.get("timeline", []):
                for event in day_data.get("events", []):
                    self.conn.execute("""
                        INSERT INTO itinerary (
                            day, date, weekday, location, event_time,
                            event_type, title, details, status, reservation_id, notes
                        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, (
                        day_data["day"],
                        day_data["date"],
                        day_data["weekday"],
                        day_data["location"],
                        event.get("time"),
                        event.get("type"),
                        event.get("title"),
                        event.get("details"),
                        event.get("status", "pending"),
                        event.get("reservation_id"),
                        event.get("notes")
                    ))
            self.conn.commit()
    
    def update_itinerary_with_confirmed_data(self):
        """Atualiza itinerário com dados confirmados do banco"""
        # Atualizar retirada de carro
        self.conn.execute("""
            UPDATE itinerary SET
                status = 'confirmed',
                details = 'Budget - Conf: 35328815BR4',
                notes = 'Retirada confirmada às 11:00 AM'
            WHERE title LIKE '%Retirada%Carro%' AND date = '2025-11-18'
        """)
        
        # Atualizar devolução de carro
        self.conn.execute("""
            UPDATE itinerary SET
                status = 'confirmed',
                details = 'Budget - Conf: 35328815BR4',
                notes = 'Devolução confirmada às 00:30'
            WHERE title LIKE '%Devolução%Carro%' AND date = '2025-11-25'
        """)
        
        self.conn.commit()
    
    def close(self):
        """Fecha conexão"""
        self.conn.close()


def main():
    """Função principal"""
    project_root = Path(__file__).parent.parent
    db_path = project_root / "08_ETL_DATABASE" / "viagem_uruguai.db"
    
    loader = DataLoader(str(db_path))
    
    print("📊 Carregando dados no banco...")
    loader.load_travelers()
    print("✅ Viajantes carregados")
    
    loader.load_car_rental({})
    print("✅ Aluguel de carro carregado")
    
    loader.load_hotels()
    print("✅ Hotéis carregados")
    
    loader.load_reservations()
    print("✅ Reservas carregadas")
    
    loader.load_itinerary()
    print("✅ Itinerário carregado")
    
    loader.update_itinerary_with_confirmed_data()
    print("✅ Itinerário atualizado com dados confirmados")
    
    loader.close()
    print("\n✅ Todos os dados foram carregados!")


if __name__ == "__main__":
    main()

