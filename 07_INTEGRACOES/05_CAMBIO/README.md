# 💱 Integração Câmbio em Tempo Real
## Cotação BRL/UYU e Outras Moedas

---

## 🎯 OBJETIVO

Integrar APIs de câmbio para fornecer cotações atualizadas e recomendações de onde trocar dinheiro.

---

## 📋 FUNCIONALIDADES

### 1. Cotação em Tempo Real
- BRL para UYU (Real para Peso Uruguaio)
- Taxa comercial atualizada
- Histórico de variação

### 2. Recomendações
- Onde trocar dinheiro
- Melhores taxas
- Casas de câmbio próximas

### 3. Calculadora
- Converter valores
- Calcular quanto levar
- Comparar opções

---

## 🔑 PROVEDORES DE API

### 1. ExchangeRate-API (Recomendado)
- **URL**: https://www.exchangerate-api.com/
- **Gratuito**: 1.500 requisições/mês
- **Simples e confiável**

### 2. Fixer.io
- **URL**: https://fixer.io/
- **Gratuito**: Limitado
- **Preciso**

### 3. CurrencyAPI
- **URL**: https://currencyapi.com/
- **Gratuito**: 300 requisições/mês
- **Boa alternativa**

---

## 💻 IMPLEMENTAÇÃO

### ExchangeRate-API

```python
import requests
import os
from dotenv import load_dotenv
from datetime import datetime

load_dotenv()

API_KEY = os.getenv('EXCHANGERATE_API_KEY')
BASE_URL = "https://v6.exchangerate-api.com/v6"

def get_exchange_rate(base="BRL", target="UYU"):
    url = f"{BASE_URL}/{API_KEY}/latest/{base}"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        if data['result'] == 'success':
            rate = data['conversion_rates'].get(target)
            return {
                'rate': rate,
                'base': base,
                'target': target,
                'timestamp': datetime.now().isoformat(),
                'source': 'ExchangeRate-API'
            }
    return None

def convert_amount(amount, base="BRL", target="UYU"):
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
```

### Endpoint Flask

```python
@app.route('/api/exchange/rate')
def exchange_rate():
    base = request.args.get('base', 'BRL')
    target = request.args.get('target', 'UYU')
    rate = get_exchange_rate(base, target)
    if rate:
        return jsonify(rate)
    return jsonify({'error': 'Exchange rate not available'}), 500

@app.route('/api/exchange/convert')
def convert_currency():
    amount = float(request.args.get('amount', 100))
    base = request.args.get('base', 'BRL')
    target = request.args.get('target', 'UYU')
    result = convert_amount(amount, base, target)
    if result:
        return jsonify(result)
    return jsonify({'error': 'Conversion failed'}), 500
```

---

## 🔑 CONFIGURAÇÃO

### 1. Obter API Key

1. Acesse: https://www.exchangerate-api.com/
2. Crie conta gratuita
3. Obtenha API Key
4. Adicione ao .env:

```bash
EXCHANGERATE_API_KEY=sua_chave_aqui
```

### 2. Instalar Dependências

```bash
pip install requests
```

---

## 💡 RECOMENDAÇÕES DE ONDE TROCAR

### Em Montevidéu:
- **Casas de Câmbio**: Melhor taxa geralmente
- **Bancos**: Taxa oficial, mas pode ter taxas
- **Aeroporto**: Conveniente, mas taxa pior

### Em Punta del Este:
- **Casas de Câmbio**: Boa opção
- **Hotéis**: Conveniente, mas taxa pode ser pior

---

## ✅ CHECKLIST

- [ ] API Key obtida
- [ ] Dependências instaladas
- [ ] Funções implementadas
- [ ] Endpoints criados
- [ ] Frontend atualizado
- [ ] Calculadora implementada
- [ ] Testes realizados

---

**Última atualização**: 16 de Novembro de 2025

