#!/usr/bin/env python3
"""
API Endpoints para Validador de Ofertas
Integração com Flask Dashboard
"""

from flask import Blueprint, request, jsonify
from validador_ofertas import ValidadorOfertasCarros
import json

bp = Blueprint('car_rental', __name__, url_prefix='/api/car-rental')

validador = ValidadorOfertasCarros()

@bp.route('/ofertas', methods=['POST'])
def adicionar_oferta():
    """Adiciona uma nova oferta para comparação"""
    try:
        data = request.json
        url = data.get('url')
        
        if not url:
            return jsonify({'error': 'URL é obrigatória'}), 400
        
        sucesso = validador.adicionar_oferta(url)
        
        if sucesso:
            return jsonify({
                'success': True,
                'message': 'Oferta adicionada com sucesso',
                'total_ofertas': len(validador.ofertas)
            }), 201
        else:
            return jsonify({'error': 'Erro ao processar oferta'}), 400
            
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/ofertas', methods=['GET'])
def listar_ofertas():
    """Lista todas as ofertas"""
    try:
        comparacao = validador.comparar_ofertas()
        return jsonify({
            'total': len(comparacao),
            'ofertas': comparacao
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/comparar', methods=['GET'])
def comparar():
    """Retorna comparação completa das ofertas"""
    try:
        comparacao = validador.comparar_ofertas()
        
        melhor_oferta = comparacao[0] if comparacao else None
        
        return jsonify({
            'total': len(comparacao),
            'melhor_oferta': melhor_oferta,
            'todas_ofertas': comparacao,
            'resumo': {
                'melhor_provider': melhor_oferta['provider'] if melhor_oferta else None,
                'melhor_score': melhor_oferta['score'] if melhor_oferta else 0,
                'ofertas_validas': sum(1 for o in comparacao if o['validacao']['valida'])
            }
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/relatorio', methods=['GET'])
def gerar_relatorio():
    """Gera relatório em texto"""
    try:
        relatorio = validador.gerar_relatorio()
        return jsonify({
            'relatorio': relatorio,
            'formato': 'markdown'
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/validar', methods=['POST'])
def validar_oferta():
    """Valida uma oferta específica"""
    try:
        data = request.json
        url = data.get('url')
        
        if not url:
            return jsonify({'error': 'URL é obrigatória'}), 400
        
        oferta = None
        if 'booking.com' in url.lower():
            oferta = validador.parsear_url_booking(url)
        elif 'livelo' in url.lower() or 'budget' in url.lower():
            oferta = validador.parsear_url_livelo_budget(url)
        
        if not oferta:
            return jsonify({'error': 'Não foi possível processar a URL'}), 400
        
        validacao = validador.validar_oferta(oferta)
        
        return jsonify({
            'oferta': oferta,
            'validacao': validacao
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

