# 🔑 Guia Completo: Como Obter Todas as API Keys
## Passo a Passo Detalhado para Cada Serviço

---

## 📋 ÍNDICE

1. [Google Maps API Key](#google-maps)
2. [OpenWeather API Key](#openweather)
3. [ExchangeRate API Key](#exchangerate)
4. [Google AI Studio (Gemini)](#google-ai-studio)
5. [OpenAI API Key](#openai)
6. [Anthropic API Key](#anthropic)

---

## 🗺️ GOOGLE MAPS API KEY

### Passo 1: Acessar Google Cloud Console

1. Acesse: **https://console.cloud.google.com/**
2. Faça login com sua conta Google
3. Se não tiver projeto, clique em **"Criar Projeto"**
   - Nome: `gem-expert-uruguai` (ou outro nome)
   - Clique em **"Criar"**

### Passo 2: Ativar APIs Necessárias

1. No menu lateral, vá em **"APIs e Serviços"** → **"Biblioteca"**
2. Procure e ative as seguintes APIs:
   - ✅ **Maps JavaScript API**
   - ✅ **Directions API**
   - ✅ **Geocoding API**
   - ✅ **Places API** (opcional)

### Passo 3: Criar API Key

1. Vá em **"APIs e Serviços"** → **"Credenciais"**
2. Clique em **"+ Criar Credenciais"** → **"Chave de API"**
3. Copie a chave imediatamente (aparece apenas uma vez)
4. Formato: `AIzaSy...` (39 caracteres)

### Passo 4: Configurar Restrições (Recomendado)

1. Clique na chave criada para editar
2. **Restrições de aplicativo**:
   - Selecione **"Endereços IP"**
   - Adicione: `147.79.81.59` (IP da VPS)
   - Ou selecione **"Nenhuma"** para desenvolvimento
3. **Restrições de API**:
   - Selecione **"Restringir chave"**
   - Marque apenas as APIs que você ativou
4. Clique em **"Salvar"**

### Passo 5: Configurar no Projeto

```bash
# Adicionar ao .env
GOOGLE_MAPS_API_KEY=AIzaSy...
```

**Custo**: $200 créditos grátis/mês (suficiente para uso normal)

---

## 🌤️ OPENWEATHER API KEY

### Passo 1: Criar Conta

1. Acesse: **https://openweathermap.org/api**
2. Clique em **"Sign Up"** ou **"Cadastrar"**
3. Preencha o formulário:
   - Nome de usuário
   - Email
   - Senha
   - Aceite os termos
4. Clique em **"Create Account"**

### Passo 2: Confirmar Email

1. Verifique sua caixa de entrada
2. Clique no link de confirmação
3. Faça login na conta

### Passo 3: Obter API Key

1. Após login, você será redirecionado para o dashboard
2. Vá em **"API keys"** no menu
3. Você verá sua **API Key** (chave padrão)
4. Formato: `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` (32 caracteres)
5. Copie a chave

### Passo 4: Configurar no Projeto

```bash
# Adicionar ao .env
OPENWEATHER_API_KEY=sua_chave_aqui
```

**Limite Gratuito**: 60 chamadas/minuto, 1 milhão/mês

---

## 💱 EXCHANGERATE API KEY

### Passo 1: Criar Conta

1. Acesse: **https://www.exchangerate-api.com/**
2. Clique em **"Get Free API Key"** ou **"Sign Up"**
3. Preencha:
   - Email
   - Senha
   - Confirme senha
4. Clique em **"Get Started"**

### Passo 2: Confirmar Email

1. Verifique sua caixa de entrada
2. Clique no link de confirmação
3. Faça login

### Passo 3: Obter API Key

1. Após login, você verá sua **API Key** no dashboard
2. Formato: `xxxxxxxxxxxxxxxxxxxxxxxx` (variável)
3. Copie a chave

### Passo 4: Configurar no Projeto

```bash
# Adicionar ao .env
EXCHANGERATE_API_KEY=sua_chave_aqui
```

**Limite Gratuito**: 1.500 requisições/mês

---

## 🤖 GOOGLE AI STUDIO (GEMINI) API KEY

### Passo 1: Acessar Google AI Studio

1. Acesse: **https://aistudio.google.com/**
2. Faça login com sua conta Google

### Passo 2: Criar API Key

1. No menu lateral, clique em **"Get API Key"**
2. Selecione um projeto existente ou:
   - Clique em **"Create API Key in New Project"**
   - Digite nome do projeto: `gem-expert-uruguai`
   - Clique em **"Create"**
3. **IMPORTANTE**: Copie a chave imediatamente!
4. Formato: `AIzaSy...` ou `AQ...`

### Passo 3: Configurar no Projeto

```bash
# Adicionar ao .env
GOOGLE_API_KEY=sua_chave_aqui
```

**Nota**: Esta chave já está configurada no projeto!

---

## 🧠 OPENAI API KEY

### Passo 1: Acessar OpenAI Platform

1. Acesse: **https://platform.openai.com/**
2. Faça login ou crie conta
3. Se criar conta, confirme email

### Passo 2: Adicionar Método de Pagamento

1. Vá em **"Settings"** → **"Billing"**
2. Clique em **"Add payment method"**
3. Adicione cartão de crédito
4. Configure limite de uso (recomendado)

### Passo 3: Criar API Key

1. Vá em **"API keys"** no menu lateral
2. Clique em **"+ Create new secret key"**
3. Dê um nome: `gem-expert-uruguai`
4. Clique em **"Create secret key"**
5. **IMPORTANTE**: Copie a chave imediatamente!
6. Formato: `sk-proj-...` (longa)

### Passo 4: Configurar no Projeto

```bash
# Adicionar ao .env
OPENAI_API_KEY=sk-proj-...
```

**Custo**: Pago por uso (verifique preços no site)

---

## 🤖 ANTHROPIC API KEY

### Passo 1: Acessar Anthropic Console

1. Acesse: **https://console.anthropic.com/**
2. Faça login ou crie conta
3. Se criar conta, confirme email

### Passo 2: Adicionar Créditos

1. Vá em **"Billing"** ou **"Plans & Billing"**
2. Adicione créditos (mínimo geralmente $5)
3. Configure método de pagamento

### Passo 3: Criar API Key

1. Vá em **"API Keys"** no menu
2. Clique em **"Create Key"**
3. Dê um nome: `gem-expert-uruguai`
4. Clique em **"Create Key"**
5. **IMPORTANTE**: Copie a chave imediatamente!
6. Formato: `sk-ant-api03-...` (longa)

### Passo 4: Configurar no Projeto

```bash
# Adicionar ao .env
ANTHROPIC_API_KEY=sk-ant-api03-...
```

**Custo**: Pago por uso (verifique preços no site)

---

## 📝 RESUMO RÁPIDO

### API Keys Necessárias

| Serviço | URL | Tempo | Custo |
|---------|-----|-------|-------|
| **Google Maps** | console.cloud.google.com | 5 min | Grátis ($200 créditos/mês) |
| **OpenWeather** | openweathermap.org/api | 3 min | Grátis (60 req/min) |
| **ExchangeRate** | exchangerate-api.com | 2 min | Grátis (1.500 req/mês) |
| **Google AI** | aistudio.google.com | 2 min | Grátis |
| **OpenAI** | platform.openai.com | 5 min | Pago |
| **Anthropic** | console.anthropic.com | 5 min | Pago |

---

## ⚡ SCRIPT AUTOMÁTICO DE VERIFICAÇÃO

```bash
# Verificar quais API Keys estão configuradas
cd ~/gem_viagem_uruguai
cat .env | grep -E "API_KEY|_KEY" | grep -v "^#"
```

---

## 🔐 CONFIGURAR TODAS DE UMA VEZ

### No Mac (Local):

```bash
cd ~/gem_viagem_uruguai
nano .env
```

Adicione todas as chaves:
```bash
# Google Maps
GOOGLE_MAPS_API_KEY=sua_chave_aqui

# OpenWeather
OPENWEATHER_API_KEY=sua_chave_aqui

# ExchangeRate
EXCHANGERATE_API_KEY=sua_chave_aqui

# Google AI (Gemini) - Já configurada
GOOGLE_API_KEY=AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs

# OpenAI
OPENAI_API_KEY=sua_chave_aqui

# Anthropic
ANTHROPIC_API_KEY=sua_chave_aqui
```

### Na VPS:

```bash
ssh root@147.79.81.59
nano /opt/gem_viagem_uruguai/06_DASHBOARD/.env
```

Adicione as mesmas chaves e reinicie:
```bash
systemctl restart gemexpert
```

---

## ✅ CHECKLIST DE API KEYS

### Obrigatórias para Funcionalidades Básicas

- [ ] **Google Maps**: Para mapas e rotas
- [ ] **OpenWeather**: Para clima em tempo real
- [ ] **ExchangeRate**: Para câmbio em tempo real

### Já Configuradas

- [x] **Google AI (Gemini)**: ✅ Configurada
- [ ] **OpenAI**: Opcional (para chat)
- [ ] **Anthropic**: Opcional (para chat)

---

## 🧪 TESTAR API KEYS

### Teste Individual

```bash
cd ~/gem_viagem_uruguai
source venv/bin/activate

# Testar Google Maps
python3 -c "import googlemaps; import os; from dotenv import load_dotenv; load_dotenv(); gmaps = googlemaps.Client(key=os.getenv('GOOGLE_MAPS_API_KEY')); print('✅ Google Maps OK' if gmaps else '❌ Erro')"

# Testar OpenWeather
python3 -c "import requests; import os; from dotenv import load_dotenv; load_dotenv(); r = requests.get(f'http://api.openweathermap.org/data/2.5/weather?q=Montevideo&appid={os.getenv(\"OPENWEATHER_API_KEY\")}'); print('✅ OpenWeather OK' if r.status_code == 200 else '❌ Erro')"

# Testar ExchangeRate
python3 -c "import requests; import os; from dotenv import load_dotenv; load_dotenv(); r = requests.get(f'https://v6.exchangerate-api.com/v6/{os.getenv(\"EXCHANGERATE_API_KEY\")}/latest/BRL'); print('✅ ExchangeRate OK' if r.status_code == 200 else '❌ Erro')"
```

### Teste Completo

```bash
cd ~/gem_viagem_uruguai
source venv/bin/activate
python3 scripts/test_integrations.py
```

---

## 🔗 LINKS DIRETOS

### Criar Contas

- **Google Cloud**: https://console.cloud.google.com/
- **OpenWeather**: https://openweathermap.org/api
- **ExchangeRate**: https://www.exchangerate-api.com/
- **Google AI Studio**: https://aistudio.google.com/
- **OpenAI**: https://platform.openai.com/
- **Anthropic**: https://console.anthropic.com/

### Documentação

- **Google Maps**: https://developers.google.com/maps/documentation
- **OpenWeather**: https://openweathermap.org/api
- **ExchangeRate**: https://www.exchangerate-api.com/docs
- **Google AI**: https://ai.google.dev/docs
- **OpenAI**: https://platform.openai.com/docs
- **Anthropic**: https://docs.anthropic.com/

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0

