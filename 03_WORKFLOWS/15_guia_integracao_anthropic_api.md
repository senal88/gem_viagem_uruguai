# 🤖 Guia de Integração: Anthropic API (Claude)
## Configuração Completa do GEM Expert para Anthropic Claude API

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | WORKFLOW |
| **Prioridade** | IMPORTANTE |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | Anthropic API Key |

---

## 🎯 OBJETIVO

Este guia fornece instruções completas para integrar o GEM Expert com Anthropic Claude API, incluindo configuração, instruções e exemplos de uso.

---

## 🚀 PROCESSO DE INTEGRAÇÃO

### FASE 1: Obter API Key da Anthropic

#### 1.1. Criar Conta Anthropic

1. Acesse: https://console.anthropic.com/
2. Crie uma conta ou faça login
3. Navegue para API Keys: https://console.anthropic.com/settings/keys

#### 1.2. Gerar API Key

1. Clique em "Create Key"
2. Dê um nome descritivo: "GEM Expert - Viagem Uruguai"
3. Copie a API key (ela só aparece uma vez!)
4. Salve em local seguro

#### 1.3. Configurar Créditos

1. Navegue para Billing: https://console.anthropic.com/settings/billing
2. Adicione método de pagamento
3. Configure limites de uso (recomendado)

---

### FASE 2: Configurar Variáveis de Ambiente

#### 2.1. Adicionar ao .env

```bash
# Anthropic (Claude)
ANTHROPIC_API_KEY=sua_anthropic_api_key_aqui
ANTHROPIC_MODEL=claude-3-5-sonnet-20241022
ANTHROPIC_MAX_TOKENS=4000
ANTHROPIC_TEMPERATURE=0.7
```

#### 2.2. Verificar Configuração

```bash
# Testar configuração
python3 -c "import os; from dotenv import load_dotenv; load_dotenv(); print('OK' if os.getenv('ANTHROPIC_API_KEY') else 'ERRO')"
```

---

### FASE 3: Instalar SDK Python

```bash
pip3 install --user anthropic python-dotenv
# ou em ambiente virtual:
pip install anthropic python-dotenv
```

---

### FASE 4: Criar Script de Teste

Crie `scripts/test_anthropic.py`:

```python
#!/usr/bin/env python3
import os
from dotenv import load_dotenv
import anthropic

# Carregar variáveis de ambiente
load_dotenv()

# Inicializar cliente Anthropic
client = anthropic.Anthropic(api_key=os.getenv('ANTHROPIC_API_KEY'))

# Teste simples
message = client.messages.create(
    model=os.getenv('ANTHROPIC_MODEL', 'claude-3-5-sonnet-20241022'),
    max_tokens=100,
    messages=[
        {"role": "user", "content": "Olá! Você está funcionando?"}
    ]
)

print("✅ Anthropic configurado corretamente!")
print(f"Resposta: {message.content[0].text}")
```

---

### FASE 5: Instruções para Anthropic

Crie `03_WORKFLOWS/16_instrucoes_anthropic_completas.md` com instruções formatadas.

---

## 📝 CONFIGURAÇÃO DE SYSTEM PROMPT

### System Prompt Completo

O system prompt deve ser passado como parte da mensagem inicial ou configurado no cliente.

**Formato:**
```python
system_prompt = """
# Identidade: Concierge de Viagem Elite para Aline e Luiz Fernando

Você é o concierge de viagem pessoal e de elite para **Aline Torres e Luiz Fernando Sena** durante sua viagem específica ao Uruguai, de 18 a 25 de novembro de 2025.

[Conteúdo completo das instruções]
"""
```

---

## 🔧 CONFIGURAÇÃO DE PARÂMETROS

### Parâmetros Recomendados

```python
{
    "model": "claude-3-5-sonnet-20241022",
    "max_tokens": 4000,
    "temperature": 0.7,
    "system": system_prompt
}
```

### Explicação dos Parâmetros

- **model**: Modelo Claude a usar (claude-3-5-sonnet-20241022 recomendado)
- **max_tokens**: Máximo de tokens na resposta (4000 para respostas detalhadas)
- **temperature**: Criatividade (0.7 = balanceado)
- **system**: System prompt com instruções completas

---

## 📊 EXEMPLOS DE USO

### Exemplo 1: Consulta sobre Clima

```python
from anthropic import Anthropic
import os
from dotenv import load_dotenv

load_dotenv()
client = Anthropic(api_key=os.getenv('ANTHROPIC_API_KEY'))

message = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=4000,
    system=system_prompt,
    messages=[
        {
            "role": "user",
            "content": "Qual a previsão do tempo para o casamento no Fasano hoje?"
        }
    ]
)

print(message.content[0].text)
```

### Exemplo 2: Consulta sobre Itinerário

```python
message = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=4000,
    system=system_prompt,
    messages=[
        {
            "role": "user",
            "content": "Que horas é o casamento no Fasano?"
        }
    ]
)

print(message.content[0].text)
```

---

## ✅ CHECKLIST DE INTEGRAÇÃO

### Configuração

- [ ] Conta Anthropic criada
- [ ] API Key gerada e salva
- [ ] Créditos configurados
- [ ] Variáveis de ambiente configuradas
- [ ] SDK Python instalado
- [ ] Script de teste executado com sucesso

### Validação

- [ ] Teste básico funcionando
- [ ] Teste com system prompt funcionando
- [ ] Respostas contextuais verificadas
- [ ] Formato de resposta correto

---

## 🔗 REFERÊNCIAS

- **Anthropic Console**: https://console.anthropic.com/
- **Anthropic API Docs**: https://docs.anthropic.com/
- **Anthropic Python SDK**: https://github.com/anthropics/anthropic-sdk-python

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0  
**Status**: ✅ GUIA COMPLETO PARA ANTHROPIC API

