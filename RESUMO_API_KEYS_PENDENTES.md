# 🔑 Resumo: API Keys Pendentes
## Status e Como Obter

---

## ✅ JÁ CONFIGURADAS

| API Key | Status | Chave |
|---------|--------|-------|
| **Google AI (Gemini)** | ⚠️ **REQUER REGENERAÇÃO** | Chave exposta - ver `SECURITY_GOOGLE_API_KEY.md` |

---

## ⏳ PENDENTES (Para Funcionalidades Completas)

### 1. 🗺️ Google Maps API Key

**Para que serve**: Mapas interativos, rotas, localização

**Como obter**:
1. Acesse: https://console.cloud.google.com/
2. Crie projeto
3. Ative APIs: Maps JavaScript, Directions, Geocoding
4. Crie chave de API
5. Configure restrições (opcional)

**Tempo**: ~5 minutos
**Custo**: Grátis ($200 créditos/mês)

**Configurar**:
```bash
GOOGLE_MAPS_API_KEY=sua_chave_aqui
```

---

### 2. 🌤️ OpenWeather API Key

**Para que serve**: Clima em tempo real, previsão

**Como obter**:
1. Acesse: https://openweathermap.org/api
2. Crie conta gratuita
3. Confirme email
4. Copie API Key do dashboard

**Tempo**: ~3 minutos
**Custo**: Grátis (60 req/min)

**Configurar**:
```bash
OPENWEATHER_API_KEY=sua_chave_aqui
```

---

### 3. 💱 ExchangeRate API Key

**Para que serve**: Cotação BRL/UYU em tempo real

**Como obter**:
1. Acesse: https://www.exchangerate-api.com/
2. Crie conta gratuita
3. Confirme email
4. Copie API Key do dashboard

**Tempo**: ~2 minutos
**Custo**: Grátis (1.500 req/mês)

**Configurar**:
```bash
EXCHANGERATE_API_KEY=sua_chave_aqui
```

---

### 4. 🧠 OpenAI API Key (Opcional)

**Para que serve**: Chat com GPT-4

**Como obter**:
1. Acesse: https://platform.openai.com/
2. Crie conta
3. Adicione método de pagamento
4. Crie API Key

**Tempo**: ~5 minutos
**Custo**: Pago

**Configurar**:
```bash
OPENAI_API_KEY=sk-proj-...
```

---

### 5. 🤖 Anthropic API Key (Opcional)

**Para que serve**: Chat com Claude

**Como obter**:
1. Acesse: https://console.anthropic.com/
2. Crie conta
3. Adicione créditos
4. Crie API Key

**Tempo**: ~5 minutos
**Custo**: Pago

**Configurar**:
```bash
ANTHROPIC_API_KEY=sk-ant-api03-...
```

---

## ⚡ OBTER RÁPIDO

### Script Automático

```bash
./scripts/obter_todas_api_keys.sh
```

Este script:
- Mostra todos os links
- Abre automaticamente no navegador
- Fornece instruções rápidas

### Guia Completo

Veja: `07_INTEGRACOES/GUIA_COMPLETO_API_KEYS.md`

---

## 📊 PRIORIDADE

### Alta Prioridade (Para Funcionalidades Básicas)

1. ✅ **Google AI (Gemini)** - Já configurada
2. ⏳ **Google Maps** - Para mapas e rotas
3. ⏳ **OpenWeather** - Para clima
4. ⏳ **ExchangeRate** - Para câmbio

### Baixa Prioridade (Opcional)

5. ⏳ **OpenAI** - Se quiser usar GPT-4
6. ⏳ **Anthropic** - Se quiser usar Claude

---

## 🔧 CONFIGURAR TODAS

### No Mac (Local):

```bash
cd ~/gem_viagem_uruguai
nano .env
```

Adicione:
```bash
GOOGLE_MAPS_API_KEY=sua_chave
OPENWEATHER_API_KEY=sua_chave
EXCHANGERATE_API_KEY=sua_chave
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

## ✅ TESTAR

```bash
cd ~/gem_viagem_uruguai
source venv/bin/activate
python3 scripts/test_integrations.py
```

---

**Última atualização**: 16 de Novembro de 2025

