# 🌤️ Integração Clima em Tempo Real
## Previsão do Tempo e Alertas Meteorológicos

---

## 🎯 OBJETIVO

Integrar APIs de clima para fornecer previsões precisas, condições atuais e alertas meteorológicos.

---

## 📋 FUNCIONALIDADES

### 1. Previsão Detalhada
- Previsão para hoje e próximos dias
- Temperatura máxima/mínima
- Condições do tempo
- Probabilidade de chuva

### 2. Condições Atuais
- Temperatura atual
- Umidade
- Velocidade do vento
- Índice UV
- Visibilidade

### 3. Alertas Meteorológicos
- Avisos de chuva
- Alertas de vento forte
- Recomendações de vestuário

---

## 🔑 PROVEDORES DE API

### 1. OpenWeatherMap (Recomendado)
- **URL**: https://openweathermap.org/api
- **Gratuito**: 60 chamadas/minuto
- **Preciso e confiável**

### 2. WeatherAPI
- **URL**: https://www.weatherapi.com/
- **Gratuito**: 1 milhão de chamadas/mês
- **Boa alternativa**

### 3. AccuWeather
- **URL**: https://developer.accuweather.com/
- **Limitado no plano gratuito**
- **Muito preciso**

---

## 💻 IMPLEMENTAÇÃO

### OpenWeatherMap

```python
import requests
import os
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv('OPENWEATHER_API_KEY')
BASE_URL = "http://api.openweathermap.org/data/2.5"

def get_current_weather(city="Montevideo, UY"):
    url = f"{BASE_URL}/weather"
    params = {
        'q': city,
        'appid': API_KEY,
        'units': 'metric',
        'lang': 'pt'
    }
    response = requests.get(url, params=params)
    if response.status_code == 200:
        data = response.json()
        return {
            'temp': data['main']['temp'],
            'feels_like': data['main']['feels_like'],
            'description': data['weather'][0]['description'],
            'humidity': data['main']['humidity'],
            'wind': data['wind']['speed'],
            'uv': None  # Requer API paga
        }
    return None

def get_forecast(city="Montevideo, UY", days=5):
    url = f"{BASE_URL}/forecast"
    params = {
        'q': city,
        'appid': API_KEY,
        'units': 'metric',
        'lang': 'pt',
        'cnt': days * 8  # 8 previsões por dia
    }
    response = requests.get(url, params=params)
    if response.status_code == 200:
        return response.json()
    return None
```

### Endpoint Flask

```python
@app.route('/api/weather/current')
def current_weather():
    city = request.args.get('city', 'Montevideo, UY')
    weather = get_current_weather(city)
    if weather:
        return jsonify(weather)
    return jsonify({'error': 'Weather data not available'}), 500

@app.route('/api/weather/forecast')
def weather_forecast():
    city = request.args.get('city', 'Montevideo, UY')
    days = int(request.args.get('days', 5))
    forecast = get_forecast(city, days)
    if forecast:
        return jsonify(forecast)
    return jsonify({'error': 'Forecast not available'}), 500
```

---

## 🔑 CONFIGURAÇÃO

### 1. Obter API Key

1. Acesse: https://openweathermap.org/api
2. Crie conta gratuita
3. Obtenha API Key
4. Adicione ao .env:

```bash
OPENWEATHER_API_KEY=sua_chave_aqui
```

### 2. Instalar Dependências

```bash
pip install requests
```

---

## ✅ CHECKLIST

- [ ] API Key obtida
- [ ] Dependências instaladas
- [ ] Funções implementadas
- [ ] Endpoints criados
- [ ] Frontend atualizado
- [ ] Testes realizados

---

**Última atualização**: 16 de Novembro de 2025

