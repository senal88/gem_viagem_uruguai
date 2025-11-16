#!/usr/bin/env python3
"""
Servidor Flask para Dashboard GEM Expert
API para chat e dados da viagem
"""

import os
import json
from datetime import datetime
from flask import Flask, render_template, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv

# Carregar variáveis de ambiente
load_dotenv()

app = Flask(__name__,
            template_folder='../templates',
            static_folder='../static')
CORS(app)

# Configurações
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'dev-secret-key-change-in-production')

# Dados da viagem (carregar do arquivo JSON quando disponível)
TRIP_DATA = {
    'reservations': [
        {
            'date': '2025-11-19',
            'time': '09:30',
            'name': 'Pizzorno Tour',
            'location': 'Montevidéu',
            'type': 'tour'
        },
        {
            'date': '2025-11-20',
            'time': '18:30',
            'name': 'Pré-Wedding L\'Incanto',
            'location': 'Punta del Este',
            'type': 'event'
        },
        {
            'date': '2025-11-22',
            'time': '16:30',
            'name': 'Casamento Fasano',
            'location': 'Punta del Este',
            'type': 'event'
        },
        {
            'date': '2025-11-23',
            'time': '20:30',
            'name': 'Primuseum',
            'location': 'Montevidéu',
            'type': 'event'
        },
        {
            'date': '2025-11-24',
            'time': '10:30',
            'name': 'Bouza Tour',
            'location': 'Montevidéu',
            'type': 'tour'
        }
    ]
}

# System prompt para o GEM Expert
SYSTEM_PROMPT = """Você é o concierge de viagem pessoal e de elite para Aline Torres e Luiz Fernando Sena durante sua viagem específica ao Uruguai, de 18 a 25 de novembro de 2025.

Sua missão não é criar um roteiro (ele já está definido), mas sim executá-lo com perfeição, fornecendo suporte dinâmico, proativo e em tempo real.

INFORMAÇÕES DA VIAGEM:
- Viajantes: Aline Torres + Luiz Fernando Sena (Casal)
- Período: 18 a 25 de novembro de 2025 (8 dias)
- Destinos: Montevidéu (MVD) → Punta del Este (PDE) → Montevidéu (MVD)
- Hotel PDE: Barradas Parque Hotel & Spa (Reserva #6417055860)

RESERVAS CONFIRMADAS:
- 19/11 09:30: Pizzorno Tour (Montevidéu)
- 20/11 18:30: Pré-Wedding L'Incanto (PDE)
- 22/11 16:30: Casamento Fasano Las Piedras (PDE)
- 23/11 20:30: Primuseum (Montevidéu)
- 24/11 10:30: Bouza Tour (Montevidéu)

REGRAS CRÍTICAS DE CONDUÇÃO:
1. ⚠️ Faróis obrigatórios ligados 24/7
2. ⚠️ Tolerância ZERO para álcool
3. ⚠️ Pedágios via tag Telepeaje

Responda em português, com tom sofisticado e prestativo (concierge de elite)."""

@app.route('/')
def index():
    """Página principal do dashboard"""
    return render_template('index.html')

@app.route('/api/chat', methods=['POST'])
def chat():
    """Endpoint para chat com GEM Expert"""
    try:
        data = request.json
        message = data.get('message', '')
        provider = data.get('provider', 'openai')
        history = data.get('history', [])

        if not message:
            return jsonify({'error': 'Mensagem vazia'}), 400

        # Processar mensagem com o provider selecionado
        response = process_chat(message, provider, history)

        return jsonify({
            'response': response,
            'provider': provider,
            'timestamp': datetime.now().isoformat()
        })

    except Exception as e:
        print(f"Erro no chat: {str(e)}")
        return jsonify({'error': str(e)}), 500

def process_chat(message, provider, history):
    """Processar mensagem com o provider selecionado"""

    if provider == 'openai':
        return chat_openai(message, history)
    elif provider == 'anthropic':
        return chat_anthropic(message, history)
    elif provider == 'gemini':
        return chat_gemini(message, history)
    else:
        return "Provider não suportado"

def chat_openai(message, history):
    """Chat com OpenAI"""
    try:
        from openai import OpenAI

        client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))

        messages = [{"role": "system", "content": SYSTEM_PROMPT}]

        # Adicionar histórico
        for h in history:
            messages.append({"role": h['role'], "content": h['content']})

        # Adicionar mensagem atual
        messages.append({"role": "user", "content": message})

        response = client.chat.completions.create(
            model=os.getenv('OPENAI_MODEL', 'gpt-4-turbo-preview'),
            messages=messages,
            max_tokens=2000,
            temperature=0.7
        )

        return response.choices[0].message.content

    except ImportError:
        return "OpenAI SDK não instalado. Execute: pip install openai"
    except Exception as e:
        return f"Erro ao processar com OpenAI: {str(e)}"

def chat_anthropic(message, history):
    """Chat com Anthropic"""
    try:
        import anthropic

        client = anthropic.Anthropic(api_key=os.getenv('ANTHROPIC_API_KEY'))

        # Construir mensagens
        messages = []
        for h in history:
            if h['role'] != 'system':
                messages.append({"role": h['role'], "content": h['content']})

        messages.append({"role": "user", "content": message})

        response = client.messages.create(
            model=os.getenv('ANTHROPIC_MODEL', 'claude-3-5-sonnet-20241022'),
            max_tokens=2000,
            system=SYSTEM_PROMPT,
            messages=messages
        )

        return response.content[0].text

    except ImportError:
        return "Anthropic SDK não instalado. Execute: pip install anthropic"
    except Exception as e:
        return f"Erro ao processar com Anthropic: {str(e)}"

def chat_gemini(message, history):
    """Chat com Gemini"""
    try:
        import google.generativeai as genai

        genai.configure(api_key=os.getenv('GOOGLE_API_KEY'))

        model = genai.GenerativeModel(
            model_name=os.getenv('GOOGLE_MODEL', 'gemini-2.5-pro'),
            system_instruction=SYSTEM_PROMPT
        )

        # Construir contexto do histórico
        context = "\n".join([
            f"{'Usuário' if h['role'] == 'user' else 'Assistente'}: {h['content']}"
            for h in history[-5:]  # Últimas 5 mensagens
        ])

        full_message = f"{context}\n\nUsuário: {message}" if context else message

        response = model.generate_content(full_message)

        return response.text

    except ImportError:
        return "Google Generative AI SDK não instalado. Execute: pip install google-generativeai"
    except Exception as e:
        return f"Erro ao processar com Gemini: {str(e)}"

@app.route('/api/weather', methods=['GET'])
def weather():
    """Endpoint para dados do clima"""
    # TODO: Integrar com API de clima real
    return jsonify({
        'temp': 22,
        'description': 'Parcialmente nublado',
        'wind': 15,
        'humidity': 65,
        'uv': 'Moderado'
    })

@app.route('/api/exchange', methods=['GET'])
def exchange():
    """Endpoint para câmbio"""
    # TODO: Integrar com API de câmbio real
    return jsonify({
        'rate': 7.45,
        'currency': 'UYU',
        'base': 'BRL'
    })

@app.route('/api/reservations', methods=['GET'])
def reservations():
    """Endpoint para reservas"""
    return jsonify(TRIP_DATA['reservations'])

@app.route('/api/next-event', methods=['GET'])
def next_event():
    """Endpoint para próximo evento"""
    today = datetime.now().date().isoformat()

    upcoming = [
        r for r in TRIP_DATA['reservations']
        if r['date'] >= today
    ]

    if upcoming:
        upcoming.sort(key=lambda x: (x['date'], x['time']))
        return jsonify(upcoming[0])

    return jsonify({'message': 'Nenhum evento próximo'})

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    debug = os.getenv('FLASK_DEBUG', 'False').lower() == 'true'
    env = os.getenv('FLASK_ENV', 'development')
    
    if env == 'production':
        # Produção: apenas escutar localhost (nginx faz proxy)
        host = '127.0.0.1'
        print(f"🚀 Servidor iniciando em modo PRODUÇÃO")
        print(f"📱 Acesse via: http://senamfo.com.br/gem")
    else:
        # Desenvolvimento: escutar todas as interfaces
        host = '0.0.0.0'
        print(f"🚀 Servidor iniciando na porta {port}")
        print(f"📱 Acesse no iPhone: http://[SEU_IP_LOCAL]:{port}")
    
    app.run(host=host, port=port, debug=debug)

