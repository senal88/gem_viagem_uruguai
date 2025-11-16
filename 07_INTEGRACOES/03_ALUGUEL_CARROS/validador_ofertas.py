#!/usr/bin/env python3
"""
Validador de Ofertas Comparativas - Aluguel de Carros
GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025
"""

import re
import json
from datetime import datetime
from urllib.parse import urlparse, parse_qs
from typing import Dict, List, Optional

class ValidadorOfertasCarros:
    """Valida e compara ofertas de aluguel de carros"""

    def __init__(self):
        self.ofertas = []
        self.reserva_atual = {
            'pickup_date': '2025-11-18',
            'pickup_time': '10:00',
            'dropoff_date': '2025-11-25',
            'dropoff_time': '00:00',
            'pickup_location': 'Aeroporto Internacional de Carrasco (MVD)',
            'dropoff_location': 'Aeroporto Internacional de Carrasco (MVD)',
            'driver_age': 30
        }

    def parsear_url_booking(self, url: str) -> Optional[Dict]:
        """Extrai informações de URL do Booking.com"""
        try:
            parsed = urlparse(url)
            params = parse_qs(parsed.query)

            # Extrair datas
            pickup_date = f"{params.get('puYear', ['2025'])[0]}-{params.get('puMonth', ['11'])[0].zfill(2)}-{params.get('puDay', ['18'])[0].zfill(2)}"
            dropoff_date = f"{params.get('doYear', ['2025'])[0]}-{params.get('doMonth', ['11'])[0].zfill(2)}-{params.get('doDay', ['25'])[0].zfill(2)}"

            # Extrair localização
            pickup_location = params.get('locationName', ['Aeroporto Internacional de Carrasco'])[0]
            dropoff_location = params.get('dropLocationName', ['Aeroporto Internacional de Carrasco'])[0]

            # Extrair coordenadas
            coordinates = params.get('coordinates', ['-34.8368,-56.0162'])[0].split(',')

            oferta = {
                'provider': 'Booking.com',
                'url': url,
                'pickup_date': pickup_date,
                'pickup_time': f"{params.get('puHour', ['10'])[0]}:{params.get('puMinute', ['0'])[0]}",
                'dropoff_date': dropoff_date,
                'dropoff_time': f"{params.get('doHour', ['0'])[0]}:{params.get('doMinute', ['0'])[0]}",
                'pickup_location': pickup_location,
                'dropoff_location': dropoff_location,
                'pickup_coordinates': {
                    'lat': float(coordinates[0]),
                    'lng': float(coordinates[1])
                },
                'driver_age': int(params.get('driversAge', ['30'])[0]),
                'currency': params.get('prefcurrency', ['BRL'])[0],
                'language': params.get('preflang', ['br'])[0],
                'parsed_at': datetime.now().isoformat(),
                'status': 'pending_validation'
            }

            return oferta

        except Exception as e:
            print(f"Erro ao parsear URL Booking.com: {e}")
            return None

    def parsear_url_livelo_budget(self, url: str) -> Optional[Dict]:
        """Extrai informações de URL do Livelo/Budget"""
        try:
            # URL do Livelo/Budget geralmente tem estrutura diferente
            # Extrair informações básicas
            oferta = {
                'provider': 'Livelo/Budget',
                'url': url,
                'pickup_date': self.reserva_atual['pickup_date'],
                'pickup_time': self.reserva_atual['pickup_time'],
                'dropoff_date': self.reserva_atual['dropoff_date'],
                'dropoff_time': self.reserva_atual['dropoff_time'],
                'pickup_location': self.reserva_atual['pickup_location'],
                'dropoff_location': self.reserva_atual['dropoff_location'],
                'parsed_at': datetime.now().isoformat(),
                'status': 'pending_validation',
                'note': 'URL do Livelo/Budget - requer validação manual ou scraping'
            }

            return oferta

        except Exception as e:
            print(f"Erro ao parsear URL Livelo/Budget: {e}")
            return None

    def adicionar_oferta(self, url: str) -> bool:
        """Adiciona uma oferta para comparação"""
        oferta = None

        if 'booking.com' in url.lower():
            oferta = self.parsear_url_booking(url)
        elif 'livelo' in url.lower() or 'budget' in url.lower():
            oferta = self.parsear_url_livelo_budget(url)
        else:
            # Tentar detectar automaticamente
            oferta = {
                'provider': 'Desconhecido',
                'url': url,
                'status': 'unknown_provider',
                'parsed_at': datetime.now().isoformat()
            }

        if oferta:
            self.ofertas.append(oferta)
            return True
        return False

    def validar_oferta(self, oferta: Dict) -> Dict:
        """Valida uma oferta contra requisitos"""
        validacao = {
            'valida': True,
            'erros': [],
            'avisos': [],
            'pontos': 0
        }

        # Validar datas
        pickup_date = datetime.strptime(oferta.get('pickup_date', ''), '%Y-%m-%d')
        dropoff_date = datetime.strptime(oferta.get('dropoff_date', ''), '%Y-%m-%d')

        if pickup_date.date() != datetime(2025, 11, 18).date():
            validacao['avisos'].append(f"Data de retirada diferente: {oferta.get('pickup_date')}")

        if dropoff_date.date() != datetime(2025, 11, 25).date():
            validacao['avisos'].append(f"Data de devolução diferente: {oferta.get('dropoff_date')}")

        # Validar localização
        if 'Aeroporto' not in oferta.get('pickup_location', ''):
            validacao['avisos'].append("Localização de retirada pode não ser no aeroporto")

        # Validar idade do motorista
        if oferta.get('driver_age', 0) < 25:
            validacao['erros'].append("Idade do motorista abaixo do mínimo")
            validacao['valida'] = False

        # Pontuação
        if oferta.get('provider') == 'Booking.com':
            validacao['pontos'] += 10
        if 'Aeroporto' in oferta.get('pickup_location', ''):
            validacao['pontos'] += 5
        if oferta.get('currency') == 'BRL':
            validacao['pontos'] += 3

        return validacao

    def comparar_ofertas(self) -> List[Dict]:
        """Compara todas as ofertas"""
        comparacao = []

        for oferta in self.ofertas:
            validacao = self.validar_oferta(oferta)
            comparacao.append({
                **oferta,
                'validacao': validacao,
                'score': validacao['pontos']
            })

        # Ordenar por score
        comparacao.sort(key=lambda x: x['score'], reverse=True)

        return comparacao

    def gerar_relatorio(self) -> str:
        """Gera relatório comparativo"""
        comparacao = self.comparar_ofertas()

        relatorio = "# 📊 Relatório Comparativo - Aluguel de Carros\n\n"
        relatorio += f"**Data**: {datetime.now().strftime('%d/%m/%Y %H:%M')}\n\n"
        relatorio += f"**Total de Ofertas**: {len(comparacao)}\n\n"

        relatorio += "## 🎯 Resumo Executivo\n\n"

        melhor_oferta = comparacao[0] if comparacao else None
        if melhor_oferta:
            relatorio += f"**Melhor Oferta**: {melhor_oferta['provider']}\n"
            relatorio += f"- Score: {melhor_oferta['score']}/18\n"
            relatorio += f"- Status: {'✅ Válida' if melhor_oferta['validacao']['valida'] else '⚠️ Requer atenção'}\n\n"

        relatorio += "## 📋 Detalhamento das Ofertas\n\n"

        for i, oferta in enumerate(comparacao, 1):
            relatorio += f"### {i}. {oferta['provider']}\n\n"
            relatorio += f"- **URL**: {oferta['url']}\n"
            relatorio += f"- **Retirada**: {oferta.get('pickup_date', 'N/A')} às {oferta.get('pickup_time', 'N/A')}\n"
            relatorio += f"- **Devolução**: {oferta.get('dropoff_date', 'N/A')} às {oferta.get('dropoff_time', 'N/A')}\n"
            relatorio += f"- **Localização**: {oferta.get('pickup_location', 'N/A')}\n"
            relatorio += f"- **Score**: {oferta['score']}/18\n"

            if oferta['validacao']['erros']:
                relatorio += f"- **❌ Erros**: {', '.join(oferta['validacao']['erros'])}\n"
            if oferta['validacao']['avisos']:
                relatorio += f"- **⚠️ Avisos**: {', '.join(oferta['validacao']['avisos'])}\n"

            relatorio += "\n"

        return relatorio

def main():
    """Função principal para teste"""
    validador = ValidadorOfertasCarros()

    # Adicionar ofertas do exemplo
    oferta1 = "https://cars.booking.com/search-results?adplat=cross_product_bar&aid=304142&coordinates=-34.83679962158203%2C-56.01620101928711&cor=br&doDay=25&doHour=0&doMinute=0&doMonth=11&doYear=2025&driversAge=30&dropCoordinates=-34.83679962158203%2C-56.01620101928711&dropFtsType=A&dropLocation=null&dropLocationIata=MVD&dropLocationName=Aeroporto%20Internacional%20de%20Carrasco&ftsType=A&label=gen173nr-10CAEoggI46AdILVgEaCCIAQGYATO4ARfIAQzYAQPoAQH4AQGIAgGoAgG4Aqn-48gGwAIB0gIkZDM3MjZlMjEtMTdhYi00YmQ3LWJiOWUtZTQ2NjI1NGY1MzU42AIB4AIB&location=null&locationIata=MVD&locationName=Aeroporto%20Internacional%20de%20Carrasco&prefcurrency=BRL&preflang=br&puDay=18&puHour=10&puMinute=0&puMonth=11&puYear=2025"

    oferta2 = "https://abglac.com/livelo-budget/step2/Budget/B/7F/e11ae9f1-1aa8-4b19-ac5f-9b22ff97fcbb"

    validador.adicionar_oferta(oferta1)
    validador.adicionar_oferta(oferta2)

    # Gerar relatório
    relatorio = validador.gerar_relatorio()
    print(relatorio)

    # Salvar JSON
    comparacao = validador.comparar_ofertas()
    with open('ofertas_comparacao.json', 'w', encoding='utf-8') as f:
        json.dump(comparacao, f, indent=2, ensure_ascii=False)

    print("\n✅ Comparação salva em 'ofertas_comparacao.json'")

if __name__ == '__main__':
    main()

