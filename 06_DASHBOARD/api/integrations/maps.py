#!/usr/bin/env python3
"""
Integração Google Maps - Geocoding e Rotas
"""

import os
from dotenv import load_dotenv
from flask import Blueprint, jsonify, request

load_dotenv()

bp = Blueprint('maps', __name__, url_prefix='/api/maps')

API_KEY = os.getenv('GOOGLE_MAPS_API_KEY')

def geocode_address(address):
    """Geocodificar endereço"""
    if not API_KEY:
        return None
    
    try:
        import googlemaps
        gmaps = googlemaps.Client(key=API_KEY)
        geocode_result = gmaps.geocode(address)
        if geocode_result:
            location = geocode_result[0]['geometry']['location']
            return {
                'lat': location['lat'],
                'lng': location['lng'],
                'formatted_address': geocode_result[0]['formatted_address']
            }
    except Exception as e:
        print(f"Erro ao geocodificar: {e}")
    return None

def get_route(origin, destination, mode="driving"):
    """Calcular rota"""
    if not API_KEY:
        return None
    
    try:
        import googlemaps
        gmaps = googlemaps.Client(key=API_KEY)
        directions_result = gmaps.directions(origin, destination, mode=mode)
        if directions_result:
            route = directions_result[0]
            leg = route['legs'][0]
            return {
                'distance': leg['distance']['text'],
                'duration': leg['duration']['text'],
                'distance_value': leg['distance']['value'],  # metros
                'duration_value': leg['duration']['value'],  # segundos
                'steps': [
                    {
                        'instruction': step['html_instructions'],
                        'distance': step['distance']['text'],
                        'duration': step['duration']['text']
                    }
                    for step in leg['steps']
                ]
            }
    except Exception as e:
        print(f"Erro ao calcular rota: {e}")
    return None

@bp.route('/geocode')
@bp.route('/geocode/')
def geocode():
    """Endpoint para geocodificação"""
    address = request.args.get('address')
    if not address:
        return jsonify({'error': 'Address is required'}), 400
    
    result = geocode_address(address)
    if result:
        return jsonify(result)
    
    return jsonify({'error': 'Geocoding failed'}), 500

@bp.route('/route')
@bp.route('/route/')
def route():
    """Endpoint para calcular rota"""
    origin = request.args.get('origin')
    destination = request.args.get('destination')
    mode = request.args.get('mode', 'driving')
    
    if not origin or not destination:
        return jsonify({'error': 'Origin and destination are required'}), 400
    
    result = get_route(origin, destination, mode)
    if result:
        return jsonify(result)
    
    return jsonify({'error': 'Route calculation failed'}), 500

