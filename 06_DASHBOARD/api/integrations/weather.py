#!/usr/bin/env python3
"""
Integração Clima em Tempo Real - OpenWeather
"""

import os
import requests
from dotenv import load_dotenv
from flask import Blueprint, jsonify, request

load_dotenv()

bp = Blueprint('weather', __name__, url_prefix='/api/weather')

API_KEY = os.getenv('OPENWEATHER_API_KEY')
BASE_URL = "http://api.openweathermap.org/data/2.5"

def get_current_weather(city="Montevideo, UY"):
    """Obter clima atual"""
    if not API_KEY:
        return None
    
    try:
        url = f"{BASE_URL}/weather"
        params = {
            'q': city,
            'appid': API_KEY,
            'units': 'metric',
            'lang': 'pt'
        }
        response = requests.get(url, params=params, timeout=5)
        if response.status_code == 200:
            data = response.json()
            return {
                'temp': round(data['main']['temp']),
                'feels_like': round(data['main']['feels_like']),
                'description': data['weather'][0]['description'].title(),
                'humidity': data['main']['humidity'],
                'wind': round(data['wind']['speed'] * 3.6, 1),  # m/s para km/h
                'icon': data['weather'][0]['icon'],
                'city': data['name'],
                'country': data['sys']['country']
            }
    except Exception as e:
        print(f"Erro ao obter clima: {e}")
    return None

def get_forecast(city="Montevideo, UY", days=5):
    """Obter previsão"""
    if not API_KEY:
        return None
    
    try:
        url = f"{BASE_URL}/forecast"
        params = {
            'q': city,
            'appid': API_KEY,
            'units': 'metric',
            'lang': 'pt',
            'cnt': days * 8
        }
        response = requests.get(url, params=params, timeout=5)
        if response.status_code == 200:
            return response.json()
    except Exception as e:
        print(f"Erro ao obter previsão: {e}")
    return None

@bp.route('/current')
@bp.route('/current/')
def current():
    """Endpoint para clima atual"""
    city = request.args.get('city', 'Montevideo, UY')
    weather = get_current_weather(city)
    
    if weather:
        return jsonify(weather)
    
    # Fallback se API não disponível
    return jsonify({
        'temp': 22,
        'feels_like': 22,
        'description': 'Parcialmente nublado',
        'humidity': 65,
        'wind': 15,
        'city': 'Montevidéu',
        'note': 'Dados simulados - Configure OPENWEATHER_API_KEY para dados reais'
    })

@bp.route('/forecast')
@bp.route('/forecast/')
def forecast():
    """Endpoint para previsão"""
    city = request.args.get('city', 'Montevideo, UY')
    days = int(request.args.get('days', 5))
    forecast_data = get_forecast(city, days)
    
    if forecast_data:
        return jsonify(forecast_data)
    
    return jsonify({'error': 'Forecast not available'}), 500

