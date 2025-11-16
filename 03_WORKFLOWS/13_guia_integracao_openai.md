# 🤖 Guia de Integração: OpenAI
## Configuração Completa do GEM Expert para OpenAI

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | WORKFLOW |
| **Prioridade** | IMPORTANTE |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | OpenAI API Key |

---

## 🎯 OBJETIVO

Este guia fornece instruções completas para integrar o GEM Expert com OpenAI (GPT-4, GPT-4 Turbo), incluindo configuração, instruções e exemplos de uso.

---

## 🚀 PROCESSO DE INTEGRAÇÃO

### FASE 1: Obter API Key da OpenAI

#### 1.1. Criar Conta OpenAI

1. Acesse: https://platform.openai.com/
2. Crie uma conta ou faça login
3. Navegue para API Keys: https://platform.openai.com/api-keys

#### 1.2. Gerar API Key

1. Clique em "Create new secret key"
2. Dê um nome descritivo: "GEM Expert - Viagem Uruguai"
3. Copie a API key (ela só aparece uma vez!)
4. Salve em local seguro

#### 1.3. Configurar Créditos

1. Navegue para Billing: https://platform.openai.com/account/billing
2. Adicione método de pagamento
3. Configure limites de uso (recomendado)

---

### FASE 2: Configurar Variáveis de Ambiente

#### 2.1. Adicionar ao .env

```bash
# OpenAI
OPENAI_API_KEY=sk-proj-sua_api_key_aqui
OPENAI_MODEL=gpt-4-turbo-preview
OPENAI_MAX_TOKENS=4000
OPENAI_TEMPERATURE=0.7
```

#### 2.2. Verificar Configuração

```bash
# Testar configuração
python3 -c "import os; from dotenv import load_dotenv; load_dotenv(); print('OK' if os.getenv('OPENAI_API_KEY') else 'ERRO')"
```

---

### FASE 3: Instalar SDK Python

```bash
pip3 install openai python-dotenv
```

---

### FASE 4: Criar Script de Teste

Crie `scripts/test_openai.py`:

```python
#!/usr/bin/env python3
import os
from dotenv import load_dotenv
from openai import OpenAI

# Carregar variáveis de ambiente
load_dotenv()

# Inicializar cliente OpenAI
client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))

# Teste simples
response = client.chat.completions.create(
    model=os.getenv('OPENAI_MODEL', 'gpt-4-turbo-preview'),
    messages=[
        {"role": "system", "content": "Você é um assistente útil."},
        {"role": "user", "content": "Olá! Você está funcionando?"}
    ],
    max_tokens=100,
    temperature=0.7
)

print("✅ OpenAI configurado corretamente!")
print(f"Resposta: {response.choices[0].message.content}")
```

---

### FASE 5: Instruções para OpenAI

Crie `03_WORKFLOWS/14_instrucoes_openai_completas.md` com instruções formatadas.

---

## 📝 INSTRUÇÕES FORMATADAS PARA OPENAI

### System Prompt Completo

```markdown
# Identidade: Concierge de Viagem Elite para Aline e Luiz Fernando

Você é o concierge de viagem pessoal e de elite para **Aline Torres e Luiz Fernando Sena** durante sua viagem específica ao Uruguai, de 18 a 25 de novembro de 2025.

Sua missão não é *criar* um roteiro (ele já está definido), mas sim *executá-lo* com perfeição, fornecendo suporte dinâmico, proativo e em tempo real.

## Base de Conhecimento

Você possui acesso à base de conhecimento completa sobre a viagem. Sempre consulte essas informações antes de responder.

### Informações Críticas:
- **Viajantes**: Aline Torres + Luiz Fernando Sena (Casal)
- **Período**: 18 a 25 de novembro de 2025 (8 dias)
- **Destinos**: Montevidéu (MVD) → Punta del Este (PDE) → Montevidéu (MVD)
- **Hotel PDE**: Barradas Parque Hotel & Spa (Reserva #6417055860)

### Reservas Confirmadas:
- **19/11 09:30**: Pizzorno Tour (Montevidéu)
- **20/11 18:30**: Pré-Wedding L'Incanto (PDE)
- **22/11 16:30**: Casamento Fasano Las Piedras (PDE)
- **23/11 20:30**: Primuseum (Montevidéu)
- **24/11 10:30**: Bouza Tour (Montevidéu)

## Protocolo de Atuação

### Princípios:
1. **Personalização Genuína**: Todas as respostas consideram contexto do Dossiê
2. **Viabilidade Logística**: Use busca web para validar informações dinâmicas
3. **Flexibilidade**: Esteja pronto para oferecer alternativas (Plano B)
4. **Conhecimento Aprofundado**: Use busca para enriquecer o plano
5. **Adaptação ao Ritmo**: Respeite equilíbrio entre eventos e dias livres

### Gatilhos para Busca Web:

**SEMPRE buscar quando:**
- Clima/Previsão do tempo
- Trânsito/Deslocamento em tempo real
- Horários de funcionamento
- Câmbio/Cotação atual
- Disponibilidade de restaurantes
- Informações práticas não no Dossiê

**NÃO buscar quando:**
- Eventos já confirmados/reservados
- Datas/horários fixos do itinerário
- Informações que estão no Dossiê

### Formato de Resposta:
1. Acuse contexto (onde estão, que dia é)
2. Consulte conhecimento estático
3. Busque validação (se necessário)
4. Forneça informação concreta
5. Contextualize com evento/itinerário
6. Sugira próxima ação logística

## Regras Críticas de Condução

**SEMPRE relembrar quando assunto for transporte:**
1. ⚠️ Faróis obrigatórios ligados 24/7
2. ⚠️ Tolerância ZERO para álcool
3. ⚠️ Pedágios via tag Telepeaje

## Tom e Estilo

- Responda em **português**
- Tom **sofisticado, prestativo e de alta classe** (concierge de elite)
- Seja **proativo** mas não intrusivo
- Forneça **informações precisas e validadas**
```

---

## 🔧 CONFIGURAÇÃO DE FUNCTIONS/TOOLS

### Configuração de Funções para Busca Web

```python
functions = [
    {
        "type": "function",
        "function": {
            "name": "search_web",
            "description": "Busca informações na web em tempo real (clima, trânsito, horários, disponibilidade)",
            "parameters": {
                "type": "object",
                "properties": {
                    "query": {
                        "type": "string",
                        "description": "Query de busca na web"
                    },
                    "category": {
                        "type": "string",
                        "enum": ["clima", "transito", "horarios", "cambio", "disponibilidade", "pratico"],
                        "description": "Categoria da busca"
                    }
                },
                "required": ["query", "category"]
            }
        }
    }
]
```

---

## 📊 EXEMPLOS DE USO

### Exemplo 1: Consulta sobre Clima

```python
response = client.chat.completions.create(
    model="gpt-4-turbo-preview",
    messages=[
        {"role": "system", "content": system_prompt},
        {"role": "user", "content": "Qual a previsão do tempo para o casamento no Fasano hoje?"}
    ],
    functions=functions,
    function_call="auto"
)
```

### Exemplo 2: Consulta sobre Itinerário

```python
response = client.chat.completions.create(
    model="gpt-4-turbo-preview",
    messages=[
        {"role": "system", "content": system_prompt},
        {"role": "user", "content": "Que horas é o casamento no Fasano?"}
    ]
)
```

---

## ✅ CHECKLIST DE INTEGRAÇÃO

### Configuração

- [ ] Conta OpenAI criada
- [ ] API Key gerada e salva
- [ ] Créditos configurados
- [ ] Variáveis de ambiente configuradas
- [ ] SDK Python instalado
- [ ] Script de teste executado com sucesso

### Validação

- [ ] Teste básico funcionando
- [ ] Teste com busca web funcionando
- [ ] Respostas contextuais verificadas
- [ ] Formato de resposta correto

---

## 🔗 REFERÊNCIAS

- **OpenAI Platform**: https://platform.openai.com/
- **OpenAI API Docs**: https://platform.openai.com/docs
- **OpenAI Python SDK**: https://github.com/openai/openai-python

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ GUIA COMPLETO PARA OPENAI

