#!/usr/bin/env python3
"""
Teste de Integrações do GEM Expert
"""

import os
import sys
from dotenv import load_dotenv

# Adicionar diretório raiz ao path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../..'))

load_dotenv()

def test_google_maps():
    """Testar Google Maps API"""
    print("🗺️  Testando Google Maps...")
    api_key = os.getenv('GOOGLE_MAPS_API_KEY')
    if not api_key:
        print("   ⚠️  GOOGLE_MAPS_API_KEY não configurada")
        return False
    
    try:
        import googlemaps
        gmaps = googlemaps.Client(key=api_key)
        result = gmaps.geocode("Montevideo, Uruguay")
        if result:
            print(f"   ✅ Google Maps funcionando")
            return True
    except Exception as e:
        print(f"   ❌ Erro: {e}")
    return False

def test_openweather():
    """Testar OpenWeather API"""
    print("🌤️  Testando OpenWeather...")
    api_key = os.getenv('OPENWEATHER_API_KEY')
    if not api_key:
        print("   ⚠️  OPENWEATHER_API_KEY não configurada")
        return False
    
    try:
        import requests
        url = "http://api.openweathermap.org/data/2.5/weather"
        params = {
            'q': 'Montevideo,UY',
            'appid': api_key,
            'units': 'metric'
        }
        response = requests.get(url, params=params, timeout=5)
        if response.status_code == 200:
            print(f"   ✅ OpenWeather funcionando")
            return True
        else:
            print(f"   ❌ Erro HTTP {response.status_code}")
    except Exception as e:
        print(f"   ❌ Erro: {e}")
    return False

def test_exchangerate():
    """Testar ExchangeRate API"""
    print("💱 Testando ExchangeRate...")
    api_key = os.getenv('EXCHANGERATE_API_KEY')
    if not api_key:
        print("   ⚠️  EXCHANGERATE_API_KEY não configurada")
        return False
    
    try:
        import requests
        url = f"https://v6.exchangerate-api.com/v6/{api_key}/latest/BRL"
        response = requests.get(url, timeout=5)
        if response.status_code == 200:
            data = response.json()
            if data.get('result') == 'success':
                print(f"   ✅ ExchangeRate funcionando")
                return True
    except Exception as e:
        print(f"   ❌ Erro: {e}")
    return False

def main():
    print("🧪 Testando Integrações do GEM Expert\n")
    print("=" * 50)
    
    results = {
        'Google Maps': test_google_maps(),
        'OpenWeather': test_openweather(),
        'ExchangeRate': test_exchangerate()
    }
    
    print("\n" + "=" * 50)
    print("\n📊 Resumo dos Testes:\n")
    
    for name, result in results.items():
        status = "✅" if result else "❌"
        print(f"{status} {name}")
    
    total = sum(results.values())
    print(f"\nTotal: {total}/{len(results)} funcionando")

if __name__ == '__main__':
    main()

