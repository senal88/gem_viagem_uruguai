#!/usr/bin/env python3
"""
ETL Validator - Valida e compara dados extraídos com dados conhecidos
Identifica inconsistências e dados faltantes
"""

import sqlite3
import json
from pathlib import Path
from typing import Dict, List, Tuple
from datetime import datetime


class DataValidator:
    """Valida dados no banco de dados"""
    
    def __init__(self, db_path: str = "viagem_uruguai.db"):
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
        self.issues = []
    
    def validate_completeness(self) -> List[Dict]:
        """Valida completude dos dados"""
        issues = []
        
        # Verificar se há voos cadastrados
        cursor = self.conn.execute("SELECT COUNT(*) as count FROM flights")
        flight_count = cursor.fetchone()["count"]
        if flight_count == 0:
            issues.append({
                "type": "missing_data",
                "table": "flights",
                "severity": "high",
                "message": "Nenhum voo cadastrado. Cartões de embarque não foram processados."
            })
        
        # Verificar se há hotéis pendentes
        cursor = self.conn.execute("""
            SELECT COUNT(*) as count FROM hotels WHERE status = 'pending'
        """)
        pending_hotels = cursor.fetchone()["count"]
        if pending_hotels > 0:
            issues.append({
                "type": "pending_data",
                "table": "hotels",
                "severity": "medium",
                "message": f"{pending_hotels} hotel(is) ainda pendente(s) de confirmação"
            })
        
        # Verificar se há reservas sem confirmação
        cursor = self.conn.execute("""
            SELECT COUNT(*) as count FROM reservations WHERE status = 'pending'
        """)
        pending_reservations = cursor.fetchone()["count"]
        if pending_reservations > 0:
            issues.append({
                "type": "pending_data",
                "table": "reservations",
                "severity": "low",
                "message": f"{pending_reservations} reserva(s) pendente(s)"
            })
        
        # Verificar aluguel de carro
        cursor = self.conn.execute("SELECT COUNT(*) as count FROM car_rentals")
        car_count = cursor.fetchone()["count"]
        if car_count == 0:
            issues.append({
                "type": "missing_data",
                "table": "car_rentals",
                "severity": "high",
                "message": "Aluguel de carro não cadastrado"
            })
        
        return issues
    
    def validate_consistency(self) -> List[Dict]:
        """Valida consistência dos dados"""
        issues = []
        
        # Verificar se datas de check-in/check-out fazem sentido
        cursor = self.conn.execute("""
            SELECT id, name, check_in_date, check_out_date, nights
            FROM hotels
        """)
        for row in cursor.fetchall():
            check_in = datetime.strptime(row["check_in_date"], "%Y-%m-%d")
            check_out = datetime.strptime(row["check_out_date"], "%Y-%m-%d")
            calculated_nights = (check_out - check_in).days
            
            if calculated_nights != row["nights"]:
                issues.append({
                    "type": "inconsistency",
                    "table": "hotels",
                    "record_id": row["id"],
                    "severity": "medium",
                    "message": f"Hotel {row['name']}: noites calculadas ({calculated_nights}) não correspondem ao valor cadastrado ({row['nights']})"
                })
        
        # Verificar se datas de aluguel de carro fazem sentido
        cursor = self.conn.execute("""
            SELECT id, confirmation_number, pickup_date, return_date, days
            FROM car_rentals
        """)
        for row in cursor.fetchall():
            pickup = datetime.strptime(row["pickup_date"], "%Y-%m-%d")
            return_date = datetime.strptime(row["return_date"], "%Y-%m-%d")
            calculated_days = (return_date - pickup).days
            
            if calculated_days != row["days"]:
                issues.append({
                    "type": "inconsistency",
                    "table": "car_rentals",
                    "record_id": row["id"],
                    "severity": "medium",
                    "message": f"Aluguel {row['confirmation_number']}: dias calculados ({calculated_days}) não correspondem ao valor cadastrado ({row['days']})"
                })
        
        return issues
    
    def validate_timeline(self) -> List[Dict]:
        """Valida consistência do itinerário"""
        issues = []
        
        # Verificar se eventos confirmados têm reservas correspondentes
        cursor = self.conn.execute("""
            SELECT i.id, i.title, i.reservation_id, i.status, r.id as res_exists
            FROM itinerary i
            LEFT JOIN reservations r ON i.reservation_id = r.reservation_id
            WHERE i.status = 'confirmed' AND i.reservation_id IS NOT NULL
        """)
        
        for row in cursor.fetchall():
            if row["res_exists"] is None:
                issues.append({
                    "type": "missing_reference",
                    "table": "itinerary",
                    "record_id": row["id"],
                    "severity": "high",
                    "message": f"Evento '{row['title']}' marcado como confirmado mas reserva '{row['reservation_id']}' não encontrada"
                })
        
        return issues
    
    def generate_report(self) -> Dict:
        """Gera relatório completo de validação"""
        completeness_issues = self.validate_completeness()
        consistency_issues = self.validate_consistency()
        timeline_issues = self.validate_timeline()
        
        all_issues = completeness_issues + consistency_issues + timeline_issues
        
        # Estatísticas
        stats = {
            "total_issues": len(all_issues),
            "high_severity": len([i for i in all_issues if i["severity"] == "high"]),
            "medium_severity": len([i for i in all_issues if i["severity"] == "medium"]),
            "low_severity": len([i for i in all_issues if i["severity"] == "low"]),
            "by_type": {}
        }
        
        for issue in all_issues:
            issue_type = issue["type"]
            stats["by_type"][issue_type] = stats["by_type"].get(issue_type, 0) + 1
        
        return {
            "timestamp": datetime.now().isoformat(),
            "statistics": stats,
            "issues": all_issues
        }
    
    def close(self):
        """Fecha conexão"""
        self.conn.close()


def main():
    """Função principal"""
    project_root = Path(__file__).parent.parent
    db_path = project_root / "08_ETL_DATABASE" / "viagem_uruguai.db"
    
    validator = DataValidator(str(db_path))
    
    print("🔍 Validando dados...")
    report = validator.generate_report()
    
    print(f"\n📊 Relatório de Validação:")
    print(f"   Total de problemas: {report['statistics']['total_issues']}")
    print(f"   Alta severidade: {report['statistics']['high_severity']}")
    print(f"   Média severidade: {report['statistics']['medium_severity']}")
    print(f"   Baixa severidade: {report['statistics']['low_severity']}")
    
    if report["issues"]:
        print("\n⚠️  Problemas encontrados:")
        for issue in report["issues"]:
            print(f"   [{issue['severity'].upper()}] {issue['message']}")
    
    # Salvar relatório
    report_path = project_root / "08_ETL_DATABASE" / "validation_report.json"
    with open(report_path, 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2, ensure_ascii=False)
    
    print(f"\n✅ Relatório salvo em: {report_path}")
    
    validator.close()


if __name__ == "__main__":
    main()

