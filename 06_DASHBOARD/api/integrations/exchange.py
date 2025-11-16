#!/usr/bin/env python3
"""
Integração Câmbio em Tempo Real - ExchangeRate API
"""

import os
import requests
from dotenv import load_dotenv
from flask import Blueprint, jsonify, request
from datetime import datetime

load_dotenv()

bp = Blueprint('exchange', __name__, url_prefix='/api/exchange')

API_KEY = os.getenv('EXCHANGERATE_API_KEY')
BASE_URL = "https://v6.exchangerate-api.com/v6"

def get_exchange_rate(base="BRL", target="UYU"):
    """Obter cotação"""
    if not API_KEY:
        return None

    try:
        url = f"{BASE_URL}/{API_KEY}/latest/{base}"
        response = requests.get(url, timeout=5)
        if response.status_code == 200:
            data = response.json()
            if data.get('result') == 'success':
                rate = data['conversion_rates'].get(target)
                return {
                    'rate': round(rate, 2),
                    'base': base,
                    'target': target,
                    'timestamp': datetime.now().isoformat(),
                    'source': 'ExchangeRate-API'
                }
    except Exception as e:
        print(f"Erro ao obter câmbio: {e}")
    return None

def convert_amount(amount, base="BRL", target="UYU"):
    """Converter valor"""
    rate_data = get_exchange_rate(base, target)
    if rate_data:
        converted = amount * rate_data['rate']
        return {
            'original_amount': amount,
            'original_currency': base,
            'converted_amount': round(converted, 2),
            'target_currency': target,
            'rate': rate_data['rate'],
            'timestamp': rate_data['timestamp']
        }
    return None

@bp.route('/rate')
@bp.route('/rate/')
def rate():
    """Endpoint para cotação"""
    base = request.args.get('base', 'BRL')
    target = request.args.get('target', 'UYU')
    rate_data = get_exchange_rate(base, target)

    if rate_data:
        return jsonify(rate_data)

    # Fallback se API não disponível
    return jsonify({
        'rate': 7.45,
        'base': base,
        'target': target,
        'timestamp': datetime.now().isoformat(),
        'note': 'Dados simulados - Configure EXCHANGERATE_API_KEY para dados reais'
    })

@bp.route('/convert')
@bp.route('/convert/')
def convert():
    """Endpoint para conversão"""
    amount = float(request.args.get('amount', 100))
    base = request.args.get('base', 'BRL')
    target = request.args.get('target', 'UYU')
    result = convert_amount(amount, base, target)

    if result:
        return jsonify(result)

    # Fallback
    return jsonify({
        'original_amount': amount,
        'original_currency': base,
        'converted_amount': round(amount * 7.45, 2),
        'target_currency': target,
        'rate': 7.45,
        'note': 'Dados simulados'
    })

