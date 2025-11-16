#!/usr/bin/env python3
"""
ETL Loader V2 - Carrega dados extraídos para o banco de dados estruturado
Atualizado para novo padrão de nomenclatura (schema v2.0.0)
"""

import sqlite3
import json
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Any


class DataLoaderV2:
    """Carrega dados estruturados no banco de dados (Schema V2)"""
    
    def __init__(self, db_path: str = "viagem_uruguai.db"):
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
    
    def _init_schema_v2(self):
        """Inicializa schema V2 se não existir"""
        schema_path = Path(__file__).parent / "schema.sql"
        if schema_path.exists():
            with open(schema_path, 'r', encoding='utf-8') as f:
                schema = f.read()
            self.conn.executescript(schema)
            self.conn.commit()
    
    def load_travelers(self):
        """Carrega dados dos viajantes (novo schema)"""
        travelers = [
            {
                "doc_nome_completo": "Aline Torres",
                "doc_nome_primeiro": "Aline",
                "doc_nome_sobrenome": "Torres",
                "meta_status": "ativo"
            },
            {
                "doc_nome_completo": "Luiz Fernando Sena",
                "doc_nome_primeiro": "Luiz Fernando",
                "doc_nome_sobrenome": "MOREIRA SENA",
                "doc_cpf": "124259377-22",
                "doc_passaporte_numero": "GM519922",
                "doc_passaporte_pais_emissor": "BRA",
                "doc_passaporte_data_expedicao": "2025-09-22",
                "doc_passaporte_data_validade": "2035-09-21",
                "doc_data_nascimento": "1988-12-13",
                "doc_sexo": "M",
                "doc_naturalidade_cidade": "VITORIA",
                "doc_naturalidade_estado": "ES",
                "doc_nacionalidade": "BRASILEIRO(A)",
                "doc_filiacao_mae": "MARIA PENHA SENA DA SILVA",
                "doc_filiacao_pai": "LUIZ ANTONIO MOREIRA DA SILVA",
                "meta_status": "ativo"
            }
        ]
        
        for traveler in travelers:
            cursor = self.conn.execute(
                "SELECT pk_viajante_id FROM tbl_core_viajantes WHERE doc_nome_completo = ?",
                (traveler["doc_nome_completo"],)
            )
            if not cursor.fetchone():
                keys = list(traveler.keys())
                placeholders = ', '.join(['?' for _ in keys])
                self.conn.execute(f"""
                    INSERT INTO tbl_core_viajantes ({', '.join(keys)})
                    VALUES ({placeholders})
                """, list(traveler.values()))
        self.conn.commit()
    
    def load_car_rental(self, data: Dict[str, Any]):
        """Carrega dados de aluguel de carro confirmado (novo schema)"""
        car_data = {
            "doc_locadora": "Budget",
            "doc_numero_confirmacao": "35328815BR4",
            "data_retirada": "2025-11-18",
            "hora_retirada": "11:00",
            "loc_retirada": "Aeroporto Internacional de Carrasco (MVD)",
            "loc_retirada_endereco": "Aeroporto Carrasco, Montevidéu",
            "data_devolucao": "2025-11-25",
            "hora_devolucao": "00:30",
            "loc_devolucao": "Aeroporto Internacional de Carrasco (MVD)",
            "loc_devolucao_endereco": "Aeroporto Carrasco, Montevidéu",
            "num_dias": 7,
            "meta_status": "confirmado",
            "meta_observacoes": "Verificar na retirada: tag Telepeaje, política de combustível, seguro incluído"
        }
        
        cursor = self.conn.execute(
            "SELECT pk_aluguel_id FROM tbl_core_alugueis_carros WHERE doc_numero_confirmacao = ?",
            (car_data["doc_numero_confirmacao"],)
        )
        existing = cursor.fetchone()
        
        if existing:
            update_fields = []
            values = []
            for key, value in car_data.items():
                update_fields.append(f"{key} = ?")
                values.append(value)
            values.append(car_data["doc_numero_confirmacao"])
            
            self.conn.execute(f"""
                UPDATE tbl_core_alugueis_carros SET
                    {', '.join(update_fields)},
                    meta_atualizado_em = CURRENT_TIMESTAMP
                WHERE doc_numero_confirmacao = ?
            """, values)
        else:
            keys = list(car_data.keys())
            placeholders = ', '.join(['?' for _ in keys])
            self.conn.execute(f"""
                INSERT INTO tbl_core_alugueis_carros ({', '.join(keys)})
                VALUES ({placeholders})
            """, list(car_data.values()))
        self.conn.commit()
    
    def load_hotels(self):
        """Carrega dados de hotéis confirmados (novo schema)"""
        hotels = [
            {
                "doc_nome_hotel": "Barradas Parque Hotel & Spa",
                "loc_cidade": "Punta del Este",
                "data_checkin": "2025-11-20",
                "data_checkout": "2025-11-23",
                "num_noites": 3,
                "doc_numero_reserva": "6417055860",
                "doc_codigo_pin": "2921",
                "meta_status": "confirmado"
            }
        ]
        
        for hotel in hotels:
            cursor = self.conn.execute(
                "SELECT pk_hotel_id FROM tbl_core_hoteis WHERE doc_numero_reserva = ?",
                (hotel["doc_numero_reserva"],)
            )
            if not cursor.fetchone():
                keys = list(hotel.keys())
                placeholders = ', '.join(['?' for _ in keys])
                self.conn.execute(f"""
                    INSERT INTO tbl_core_hoteis ({', '.join(keys)})
                    VALUES ({placeholders})
                """, list(hotel.values()))
        self.conn.commit()
    
    def load_reservations(self):
        """Carrega reservas confirmadas (novo schema)"""
        reservations = [
            {
                "doc_codigo_reserva": "RES001",
                "doc_nome_atividade": "Pizzorno Tour",
                "cat_tipo": "tour",
                "data_evento": "2025-11-19",
                "hora_evento": "09:30",
                "loc_cidade": "Montevidéu",
                "loc_endereco": "Vinícola Pizzorno, 20 km ao norte de Montevidéu",
                "num_valor_pessoa": 697.00,
                "num_valor_total": 1394.00,
                "moeda_codigo": "BRL",
                "meta_status": "confirmado",
                "flag_transfer_incluido": True,
                "hora_transfer_saida": "09:30",
                "loc_transfer_saida": "Hotel em Punta Carretas/Pocitos",
                "hora_transfer_retorno": "14:30"
            },
            {
                "doc_codigo_reserva": "RES002",
                "doc_nome_atividade": "Pré-Wedding L'Incanto",
                "cat_tipo": "evento",
                "data_evento": "2025-11-20",
                "hora_evento": "18:30",
                "loc_cidade": "Punta del Este",
                "loc_endereco": "Porto de Punta, rua 21, Punta del Este",
                "meta_status": "confirmado",
                "doc_dress_code": "Casual Chique"
            },
            {
                "doc_codigo_reserva": "RES003",
                "doc_nome_atividade": "Casamento Fasano",
                "cat_tipo": "evento",
                "data_evento": "2025-11-22",
                "hora_evento": "16:30",
                "loc_cidade": "Punta del Este",
                "loc_endereco": "Hotel Fasano Las Piedras, Região Las Piedras",
                "meta_status": "confirmado",
                "doc_dress_code": "Esporte Fino"
            },
            {
                "doc_codigo_reserva": "RES004",
                "doc_nome_atividade": "Primuseum",
                "cat_tipo": "evento",
                "data_evento": "2025-11-23",
                "hora_evento": "20:30",
                "loc_cidade": "Montevidéu",
                "loc_endereco": "Primuseum, Cidade Velha, Montevidéu",
                "num_valor_pessoa": 380.00,
                "num_valor_total": 760.00,
                "moeda_codigo": "BRL",
                "meta_status": "confirmado",
                "contato_telefone": "+598 99 2176 45",
                "flag_transfer_incluido": True
            },
            {
                "doc_codigo_reserva": "RES005",
                "doc_nome_atividade": "Bouza Tour",
                "cat_tipo": "tour",
                "data_evento": "2025-11-24",
                "hora_evento": "10:30",
                "loc_cidade": "Montevidéu",
                "loc_endereco": "Bodega Bouza, Melilla (15-20 min de Montevidéu)",
                "num_valor_pessoa": 990.00,
                "num_valor_total": 1980.00,
                "moeda_codigo": "BRL",
                "meta_status": "confirmado",
                "flag_transfer_incluido": True,
                "hora_transfer_saida": "10:30",
                "hora_transfer_retorno": "15:00"
            }
        ]
        
        for res in reservations:
            cursor = self.conn.execute(
                "SELECT pk_reserva_id FROM tbl_core_reservas WHERE doc_codigo_reserva = ?",
                (res["doc_codigo_reserva"],)
            )
            if cursor.fetchone():
                update_fields = []
                values = []
                for key, value in res.items():
                    if key != "doc_codigo_reserva":
                        update_fields.append(f"{key} = ?")
                        values.append(value)
                values.append(res["doc_codigo_reserva"])
                
                self.conn.execute(f"""
                    UPDATE tbl_core_reservas SET
                        {', '.join(update_fields)},
                        meta_atualizado_em = CURRENT_TIMESTAMP
                    WHERE doc_codigo_reserva = ?
                """, values)
            else:
                keys = list(res.keys())
                placeholders = ', '.join(['?' for _ in keys])
                self.conn.execute(f"""
                    INSERT INTO tbl_core_reservas ({', '.join(keys)})
                    VALUES ({placeholders})
                """, list(res.values()))
        self.conn.commit()
    
    def _map_event_type(self, event_type: str) -> str:
        """Mapeia tipo de evento do JSON para schema"""
        mapping = {
            "arrival": "chegada",
            "departure": "partida",
            "reservation": "reserva",
            "activity": "atividade",
            "meal": "refeicao",
            "logistics": "logistica",
            "free": "livre",
            "checkin": "logistica",
            "checkout": "logistica",
            "travel": "logistica"
        }
        return mapping.get(event_type, "atividade")
    
    def load_itinerary(self):
        """Carrega itinerário detalhado (novo schema)"""
        itinerary_json_path = Path(__file__).parent.parent / "04_DADOS_ESTRUTURADOS" / "03_roteiro_timeline.json"
        
        if itinerary_json_path.exists():
            with open(itinerary_json_path, 'r', encoding='utf-8') as f:
                itinerary_data = json.load(f)
            
            # Limpar itinerário existente
            self.conn.execute("DELETE FROM tbl_meta_itinerario")
            
            for day_data in itinerary_data.get("timeline", []):
                for event in day_data.get("events", []):
                    event_type = self._map_event_type(event.get("type", "atividade"))
                    self.conn.execute("""
                        INSERT INTO tbl_meta_itinerario (
                            num_dia, data_evento, doc_dia_semana, loc_cidade, hora_evento,
                            cat_tipo_evento, doc_titulo, doc_detalhes, meta_status, fk_reserva_id, meta_observacoes
                        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, (
                        day_data["day"],
                        day_data["date"],
                        day_data["weekday"],
                        day_data["location"],
                        event.get("time"),
                        event_type,
                        event.get("title"),
                        event.get("details"),
                        event.get("status", "pendente"),
                        event.get("reservation_id"),
                        event.get("notes")
                    ))
            self.conn.commit()
    
    def update_itinerary_with_confirmed_data(self):
        """Atualiza itinerário com dados confirmados (novo schema)"""
        # Atualizar retirada de carro
        self.conn.execute("""
            UPDATE tbl_meta_itinerario SET
                meta_status = 'confirmado',
                doc_detalhes = 'Budget - Conf: 35328815BR4',
                meta_observacoes = 'Retirada confirmada às 11:00 AM'
            WHERE doc_titulo LIKE '%Retirada%Carro%' AND data_evento = '2025-11-18'
        """)
        
        # Atualizar devolução de carro
        self.conn.execute("""
            UPDATE tbl_meta_itinerario SET
                meta_status = 'confirmado',
                doc_detalhes = 'Budget - Conf: 35328815BR4',
                meta_observacoes = 'Devolução confirmada às 00:30'
            WHERE doc_titulo LIKE '%Devolução%Carro%' AND data_evento = '2025-11-25'
        """)
        
        self.conn.commit()
    
    def close(self):
        """Fecha conexão"""
        self.conn.close()


def main():
    """Função principal"""
    project_root = Path(__file__).parent.parent
    db_path = project_root / "08_ETL_DATABASE" / "viagem_uruguai.db"
    
    loader = DataLoaderV2(str(db_path))
    
    print("📊 Inicializando schema V2...")
    loader._init_schema_v2()
    
    print("📊 Carregando dados no banco (Schema V2)...")
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
    print("\n✅ Todos os dados foram carregados (Schema V2)!")


if __name__ == "__main__":
    main()

