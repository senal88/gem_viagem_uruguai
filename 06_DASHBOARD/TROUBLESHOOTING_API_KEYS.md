# 🔧 Troubleshooting: Erros de API Keys
## Solução de Problemas Comuns

---

## ❌ ERRO: OpenAI API Key Não Fornecida

### Erro:
```
Error code: 401 - You didn't provide an API key
```

### Solução:

#### Passo 1: Verificar se está no .env

```bash
# Local
cat ~/gem_viagem_uruguai/.env | grep OPENAI_API_KEY

# VPS
ssh root@147.79.81.59
cat /opt/gem_viagem_uruguai/06_DASHBOARD/.env | grep OPENAI_API_KEY
```

#### Passo 2: Adicionar se não existir

**Local (Mac):**
```bash
cd ~/gem_viagem_uruguai
echo "OPENAI_API_KEY=sua_chave_aqui" >> .env
```

**VPS:**
```bash
ssh root@147.79.81.59
echo "OPENAI_API_KEY=sua_chave_aqui" >> /opt/gem_viagem_uruguai/06_DASHBOARD/.env
systemctl restart gemexpert
```

#### Passo 3: Verificar formato

A chave deve começar com `sk-proj-` ou `sk-` e não ter espaços:
```bash
# Correto
OPENAI_API_KEY=sk-proj-xxxxxxxxxxxxxxxxxxxxx

# Incorreto (com espaços)
OPENAI_API_KEY= sk-proj-xxxxxxxxxxxxxxxxxxxxx
```

#### Passo 4: Obter Nova API Key

Se não tiver a chave:
1. Acesse: https://platform.openai.com/api-keys
2. Clique em "Create new secret key"
3. Copie a chave
4. Adicione ao .env

---

## ❌ ERRO: Anthropic API Key Não Configurada

### Erro:
```
Your credit balance is too low
```

### Solução:

#### Passo 1: Verificar API Key

```bash
cat .env | grep ANTHROPIC_API_KEY
```

#### Passo 2: Adicionar Créditos

1. Acesse: https://console.anthropic.com/settings/billing
2. Adicione créditos (mínimo geralmente $5)
3. Configure método de pagamento

#### Passo 3: Verificar API Key

1. Acesse: https://console.anthropic.com/settings/keys
2. Verifique se a chave está ativa
3. Se necessário, crie uma nova

---

## ❌ ERRO: Google API Key Inválida

### Erro:
```
401 API keys are not supported
```

### Solução:

#### Passo 1: Verificar Tipo de Chave

Use a chave do **Google AI Studio**, não do Google Cloud:
- ✅ Correto: https://aistudio.google.com/
- ❌ Incorreto: Google Cloud Console (para Maps)

#### Passo 2: Obter Chave Correta

1. Acesse: https://aistudio.google.com/
2. Clique em "Get API Key"
3. Crie em projeto novo ou existente
4. Copie a chave (formato: `AIzaSy...` ou `AQ...`)

#### Passo 3: Configurar

```bash
GOOGLE_API_KEY=AIzaSy...  # Para Gemini
GOOGLE_MAPS_API_KEY=AIzaSy...  # Para Maps (diferente)
```

---

## ✅ VERIFICAÇÃO RÁPIDA

### Script de Verificação

```bash
cd ~/gem_viagem_uruguai
source venv/bin/activate
python3 << 'EOF'
import os
from dotenv import load_dotenv

load_dotenv()

keys = {
    'OPENAI_API_KEY': os.getenv('OPENAI_API_KEY'),
    'ANTHROPIC_API_KEY': os.getenv('ANTHROPIC_API_KEY'),
    'GOOGLE_API_KEY': os.getenv('GOOGLE_API_KEY'),
    'GOOGLE_MAPS_API_KEY': os.getenv('GOOGLE_MAPS_API_KEY'),
    'OPENWEATHER_API_KEY': os.getenv('OPENWEATHER_API_KEY'),
    'EXCHANGERATE_API_KEY': os.getenv('EXCHANGERATE_API_KEY')
}

print("🔑 Status das API Keys:\n")
for key, value in keys.items():
    if value and value.strip():
        masked = value[:10] + '...' + value[-5:] if len(value) > 15 else '***'
        print(f"✅ {key}: {masked}")
    else:
        print(f"❌ {key}: Não configurada")
EOF
```

---

## 🔧 CORRIGIR PROBLEMAS COMUNS

### Problema 1: Chave com Espaços

```bash
# Remover espaços
sed -i '' 's/OPENAI_API_KEY= *\(.*\)/OPENAI_API_KEY=\1/' .env
```

### Problema 2: Chave Vazia

```bash
# Verificar se está vazia
grep "OPENAI_API_KEY=$" .env

# Se estiver vazia, adicionar
echo "OPENAI_API_KEY=sua_chave" >> .env
```

### Problema 3: Arquivo .env Não Carregado

```python
# No código Python, garantir que está carregando
from dotenv import load_dotenv
import os

# Carregar explicitamente
load_dotenv('/caminho/completo/para/.env')

# Ou garantir que está no diretório correto
os.chdir('/caminho/do/projeto')
load_dotenv()
```

---

## 📝 CHECKLIST DE CORREÇÃO

- [ ] API Key está no arquivo .env?
- [ ] Sem espaços antes/depois da chave?
- [ ] Chave completa (não truncada)?
- [ ] Formato correto (prefixo esperado)?
- [ ] Arquivo .env está sendo carregado?
- [ ] Servidor reiniciado após mudanças?
- [ ] Chave está ativa no provedor?

---

## 🚀 CORREÇÃO RÁPIDA

### Para OpenAI:

```bash
# 1. Obter chave em: https://platform.openai.com/api-keys
# 2. Adicionar ao .env
echo "OPENAI_API_KEY=sua_chave_aqui" >> ~/gem_viagem_uruguai/.env

# 3. Na VPS também
ssh root@147.79.81.59
echo "OPENAI_API_KEY=sua_chave_aqui" >> /opt/gem_viagem_uruguai/06_DASHBOARD/.env
systemctl restart gemexpert
```

---

**Última atualização**: 16 de Novembro de 2025

