# 🔐 ATUALIZAÇÕES NO 1PASSWORD

## 📋 REGISTROS PARA ATUALIZAR

**Data**: 16 de Novembro de 2025  
**Nova Chave Google API**: `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0`

---

## 🔑 REGISTRO 1: Google API Key (GEM Expert)

### Vault: `Personal` ou `1p_macos`

**Campos para Atualizar/Criar:**

| Campo | Valor |
|-------|-------|
| **Título** | GEM Expert - Google API Key |
| **Tipo** | API Credential |
| **API Key** | `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0` |
| **Project ID** | `gcp-ai-setup-24410` |
| **Dashboard URL** | `http://senamfo.com.br:8081/gem/` |
| **VPS IP** | `147.79.81.59` |
| **VPS Domain** | `senamfo.com.br` |
| **Data Criação** | 16/11/2025 |

**Seção: Restrições**
- **APIs Permitidas**: Generative Language API, Maps Backend API, Geocoding API, Directions API, Places API
- **HTTP Referrers**: `http://senamfo.com.br:8081/*`, `https://senamfo.com.br/*`, `localhost:5000/*`, `127.0.0.1:5000/*`

---

## 🖥️ REGISTRO 2: VPS - senamfo.com.br

### Vault: `1p_vps`

**Campos para Atualizar:**

| Campo | Valor |
|-------|-------|
| **Google API Key** | `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0` |
| **Dashboard URL** | `http://senamfo.com.br:8081/gem/` |
| **Projeto GCP** | `gcp-ai-setup-24410` |

---

## ☁️ REGISTRO 3: Google Cloud Platform

### Vault: `Personal`

**Campos para Atualizar:**

| Campo | Valor |
|-------|-------|
| **Project ID** | `gcp-ai-setup-24410` |
| **Google API Key (Web)** | `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0` |
| **Chave UID** | `bb0e282c-4d0f-4033-901a-e9232567d5e2` |
| **Console URL** | `https://console.cloud.google.com/?project=gcp-ai-setup-24410` |
| **Credentials URL** | `https://console.cloud.google.com/apis/credentials?project=gcp-ai-setup-24410` |

---

## 📝 COMANDOS 1PASSWORD CLI

### Listar Itens Relacionados

```bash
# Buscar por "google" ou "api"
op item list | grep -i "google\|api\|gemini"

# Buscar em vault específico
op item list --vault="Personal" | grep -i "google"
```

### Atualizar Item Existente

```bash
# Obter ID do item
ITEM_ID=$(op item list --vault="Personal" --format=json | jq -r '.[] | select(.title | test("(?i)google.*api"; "g")) | .id')

# Atualizar campo API Key
op item edit "$ITEM_ID" \
  --field-label="API Key" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0" \
  --vault="Personal"
```

### Criar Novo Item

```bash
# Criar item de API Credential
op item create \
  --template="API Credential" \
  --title="GEM Expert - Google API Key" \
  --vault="Personal" \
  --field-label="API Key" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0" \
  --field-label="Project ID" \
  --field-value="gcp-ai-setup-24410" \
  --field-label="Dashboard URL" \
  --field-value="http://senamfo.com.br:8081/gem/"
```

---

## 🔍 BUSCAR ITENS EXISTENTES

### Vault: Personal

```bash
op item list --vault="Personal" --format=json | jq -r '.[] | select(.title | test("(?i)(google|gemini|gcp|api)"; "g")) | "\(.id) - \(.title)"'
```

### Vault: 1p_vps

```bash
op item list --vault="1p_vps" --format=json | jq -r '.[] | select(.title | test("(?i)(vps|senamfo|dashboard)"; "g")) | "\(.id) - \(.title)"'
```

---

## ✅ CHECKLIST DE ATUALIZAÇÃO

- [ ] **Google API Key** atualizada no vault `Personal`
- [ ] **VPS** atualizado no vault `1p_vps` com nova chave
- [ ] **GCP Project** atualizado no vault `Personal`
- [ ] **Dashboard URL** adicionada em todos os registros relevantes
- [ ] **Restrições** documentadas nos campos de notas

---

## 📋 TEMPLATE COMPLETO PARA NOVO ITEM

**Título**: GEM Expert - Google API Key  
**Tipo**: API Credential  
**Vault**: Personal

**Campos Principais**:
```
API Key: AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0
Project ID: gcp-ai-setup-24410
Dashboard URL: http://senamfo.com.br:8081/gem/
VPS IP: 147.79.81.59
VPS Domain: senamfo.com.br
UID: bb0e282c-4d0f-4033-901a-e9232567d5e2
```

**Notas**:
```
Restrições Configuradas:
- APIs: Generative Language API, Maps Backend API, Geocoding API, Directions API, Places API
- HTTP Referrers: http://senamfo.com.br:8081/*, https://senamfo.com.br/*, localhost:5000/*, 127.0.0.1:5000/*

Criada: 16/11/2025
Status: Ativa e configurada
```

---

## 🚀 SCRIPT AUTOMATIZADO

Execute para gerar instruções:
```bash
./scripts/atualizar_1password.sh
```

---

**Última atualização**: 16 de Novembro de 2025  
**Status**: Pronto para atualização manual no 1Password

