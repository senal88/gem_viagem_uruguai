# ⚡ COMANDOS RÁPIDOS - Atualizar 1Password

## 🚀 ATUALIZAÇÃO RÁPIDA

### Executar Script Automatizado

```bash
cd ~/gem_viagem_uruguai
./scripts/atualizar_1password_automatico.sh
```

---

## 📋 COMANDOS MANUAIS POR ITEM

### 1. Atualizar Google API Key (GEMINI_API_KEY)

```bash
# Buscar item
ITEM_ID=$(op item list --vault="Personal" --format=json | jq -r '.[] | select(.title | test("(?i)gemini.*api"; "g")) | .id')

# Atualizar
op item edit "$ITEM_ID" \
  --vault="Personal" \
  --field-label="credential" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
```

### 2. Atualizar Google API Key (GOOGLE_API_KEY)

```bash
# Buscar item
ITEM_ID=$(op item list --vault="Personal" --format=json | jq -r '.[] | select(.title | test("(?i)google.*api.*key"; "g")) | .id')

# Atualizar
op item edit "$ITEM_ID" \
  --vault="Personal" \
  --field-label="API Key" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
```

### 3. Atualizar GCP Project

```bash
# Buscar item
ITEM_ID=$(op item list --vault="Personal" --format=json | jq -r '.[] | select(.title | test("(?i)gcp.*ai.*setup"; "g")) | .id')

# Atualizar
op item edit "$ITEM_ID" \
  --vault="Personal" \
  --field-label="API Key" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
```

### 4. Atualizar VPS

```bash
# Buscar item no vault 1p_vps
ITEM_ID=$(op item list --vault="1p_vps" --format=json | jq -r '.[] | select(.title | test("(?i)senamfo|147.79"; "g")) | .id')

# Atualizar
op item edit "$ITEM_ID" \
  --vault="1p_vps" \
  --field-label="Google API Key" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
```

---

## 🔍 BUSCAR ITENS ESPECÍFICOS

### Listar Todos os Itens com "Google" ou "API"

```bash
op item list --format=json | jq -r '.[] | select(.title | test("(?i)(google|api|gemini)"; "g")) | "\(.id) - \(.title) - \(.vault)"'
```

### Ver Detalhes de um Item

```bash
# Substituir ITEM_ID pelo ID real
op item get ITEM_ID --format=json | jq .
```

---

## 📝 VALORES PARA ATUALIZAR

**Nova Chave Google API**: `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0`
**Project ID**: `gcp-ai-setup-24410`
**Dashboard URL**: `http://senamfo.com.br:8081/gem/`
**VPS IP**: `147.79.81.59`

---

## ✅ CHECKLIST RÁPIDO

Execute o script automatizado e verifique:

- [ ] GEMINI_API_KEY atualizada
- [ ] GOOGLE_API_KEY atualizada
- [ ] GCP Project atualizado
- [ ] VPS atualizado
- [ ] Dashboard URL adicionada onde necessário

---

**Status**: Script pronto para uso

