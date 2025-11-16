#!/usr/bin/env python3
"""
Script principal para executar o pipeline ETL completo
"""

import sys
from pathlib import Path

# Adicionar diretório ao path
sys.path.insert(0, str(Path(__file__).parent))

from etl_extractor import DocumentExtractor
from etl_loader import DataLoader
from etl_validator import DataValidator
from etl_updater import DocumentUpdater


def main():
    """Executa pipeline ETL completo"""
    project_root = Path(__file__).parent.parent
    db_path = project_root / "08_ETL_DATABASE" / "viagem_uruguai.db"
    
    print("🚀 Iniciando pipeline ETL completo...\n")
    
    # 1. Extrair dados de documentos
    print("=" * 60)
    print("ETAPA 1: Extração de Dados")
    print("=" * 60)
    extractor = DocumentExtractor(str(db_path))
    extractor.process_all_documents(str(project_root))
    extractor.close()
    print()
    
    # 2. Carregar dados estruturados
    print("=" * 60)
    print("ETAPA 2: Carregamento de Dados")
    print("=" * 60)
    loader = DataLoader(str(db_path))
    loader.load_travelers()
    loader.load_car_rental({})
    loader.load_hotels()
    loader.load_reservations()
    loader.load_itinerary()
    loader.update_itinerary_with_confirmed_data()
    loader.close()
    print()
    
    # 3. Validar dados
    print("=" * 60)
    print("ETAPA 3: Validação de Dados")
    print("=" * 60)
    validator = DataValidator(str(db_path))
    report = validator.generate_report()
    
    print(f"Total de problemas: {report['statistics']['total_issues']}")
    if report['statistics']['total_issues'] > 0:
        print("\n⚠️  Problemas encontrados:")
        for issue in report['issues'][:10]:  # Mostrar primeiros 10
            print(f"   [{issue['severity'].upper()}] {issue['message']}")
        if len(report['issues']) > 10:
            print(f"   ... e mais {len(report['issues']) - 10} problemas")
    
    validator.close()
    print()
    
    # 4. Atualizar documentos
    print("=" * 60)
    print("ETAPA 4: Atualização de Documentos")
    print("=" * 60)
    updater = DocumentUpdater(str(db_path))
    updater.update_reservations_json()
    updater.update_timeline_json()
    updater.update_hotels_json()
    
    summary = updater.generate_summary_report()
    print(f"\n📊 Estatísticas Finais:")
    for key, value in summary["statistics"].items():
        print(f"   {key}: {value}")
    
    updater.close()
    print()
    
    print("=" * 60)
    print("✅ Pipeline ETL concluído com sucesso!")
    print("=" * 60)


if __name__ == "__main__":
    main()

