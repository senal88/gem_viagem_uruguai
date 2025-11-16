#!/usr/bin/env python3
"""
API Endpoints para Validador de Ofertas e Analisador Comparativo
Integração com Flask Dashboard
"""

from flask import Blueprint, request, jsonify
from validador_ofertas import ValidadorOfertasCarros
from analisador_comparativo import AnalisadorComparativo, OfertaCarro, asdict
import json
import os

bp = Blueprint('car_rental', __name__, url_prefix='/api/car-rental')

validador = ValidadorOfertasCarros()

# Inicializar analisador comparativo
analisador_path = os.path.dirname(os.path.abspath(__file__))
analisador = AnalisadorComparativo(
    arquivo_dados=os.path.join(analisador_path, 'ofertas_comparacao.json')
)

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

# ===== NOVOS ENDPOINTS PARA ANÁLISE COMPARATIVA =====

@bp.route('/analise-completa', methods=['GET'])
def analise_completa():
    """Gera análise completa comparando Kwid vs Onix"""
    try:
        relatorio = analisador.gerar_relatorio_comparativo()
        return jsonify(relatorio), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/adicionar-oferta-detalhada', methods=['POST'])
def adicionar_oferta_detalhada():
    """Adiciona uma oferta detalhada com todos os campos"""
    try:
        dados = request.json

        # Validar campos obrigatórios
        campos_obrigatorios = ['plataforma', 'veiculo', 'preco_diaria', 'preco_total',
                               'seguro_basico', 'combustivel', 'cancelamento', 'limite_km']
        for campo in campos_obrigatorios:
            if campo not in dados:
                return jsonify({'error': f'Campo obrigatório ausente: {campo}'}), 400

        # Criar oferta
        oferta = OfertaCarro(
            plataforma=dados['plataforma'],
            veiculo=dados['veiculo'],
            preco_diaria=float(dados['preco_diaria']),
            preco_total=float(dados['preco_total']),
            seguro_basico=dados['seguro_basico'],
            seguro_full=dados.get('seguro_full'),
            combustivel=dados['combustivel'],
            cancelamento=dados['cancelamento'],
            limite_km=dados['limite_km'],
            taxa_aeroporto=dados.get('taxa_aeroporto', False),
            taxa_limpeza=dados.get('taxa_limpeza', False),
            gps_wifi=dados.get('gps_wifi'),
            motorista_adicional=dados.get('motorista_adicional'),
            observacoes=dados.get('observacoes'),
            link_reserva=dados.get('link_reserva')
        )

        analisador.adicionar_oferta(oferta)

        return jsonify({
            'success': True,
            'message': 'Oferta adicionada com sucesso',
            'oferta': {
                'plataforma': oferta.plataforma,
                'veiculo': oferta.veiculo,
                'preco_total': oferta.preco_total
            }
        }), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/melhor-oferta/<veiculo>', methods=['GET'])
def melhor_oferta(veiculo):
    """Retorna a melhor oferta para um veículo específico"""
    try:
        melhor = analisador.melhor_oferta_por_veiculo(veiculo)
        if melhor:
            return jsonify(asdict(melhor)), 200
        else:
            return jsonify({'error': f'Nenhuma oferta encontrada para {veiculo}'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/relatorio-markdown', methods=['GET'])
def relatorio_markdown():
    """Gera relatório em formato Markdown"""
    try:
        md = analisador.gerar_markdown_analise()
        return jsonify({'markdown': md}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
