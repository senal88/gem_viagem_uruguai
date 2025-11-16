# 📋 COMANDOS MANUAIS - Atualizar 1Password

## 🔑 COMANDOS EXATOS PARA EXECUTAR

**Nova Chave**: `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0`

---

## ✅ ITENS PARA ATUALIZAR

### 1. GOOGLE_API_KEY (1p_macos)

```bash
op item edit 6xbzl566sj62zphes4b6kodt5e \
  --vault=gkpsbgizlks2zknwzqpppnb2ze \
  --field-label="GOOGLE_API_KEY" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
```

**Estrutura atual**:
- Campo: `GOOGLE_API_KEY`
- Valor atual: `AIzaSyASPYH3BdhF7CBWi7K183hbqaggT0TB4Pg`
- Novo valor: `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0`

---

### 2. Gemini_API_Key_macos (1p_macos)

```bash
op item edit 27ateuu2y37dblvo3lkb4szt6y \
  --vault=gkpsbgizlks2zknwzqpppnb2ze \
  --field-label="credential" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
```

**Estrutura atual**:
- Campo: `credential`
- Valor atual: `AQ.Ab8RN6Lqo6jrKtgINQwQ925S83ceUYisIk1iKSD8ccfnUTmxfA`
- Novo valor: `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0`

---

### 3. GEMINI_API_KEY (1p_vps)

```bash
op item edit pzxuyfevbtwa26fegzd4xsjz64 \
  --vault=oa3tidekmeu26nxiier2qbi7v4 \
  --field-label="credential" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
```

**Estrutura atual**:
- Campo: `credential`
- Valor atual: `AQ.Ab8RN6Lqo6jrKtgINQwQ925S83ceUYisIk1iKSD8ccfnUTmxfA`
- Novo valor: `AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0`

---

### 4. GCP - Gemini Code Assist (1p_vps)

**⚠️ NOTA**: Este item é uma Service Account, não usa API Key tradicional.  
**Não precisa atualizar** - usa autenticação via chave privada.

---

## 🚀 EXECUTAR TODOS DE UMA VEZ

```bash
# Atualizar GOOGLE_API_KEY
op item edit 6xbzl566sj62zphes4b6kodt5e \
  --vault=gkpsbgizlks2zknwzqpppnb2ze \
  --field-label="GOOGLE_API_KEY" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"

# Atualizar Gemini_API_Key_macos
op item edit 27ateuu2y37dblvo3lkb4szt6y \
  --vault=gkpsbgizlks2zknwzqpppnb2ze \
  --field-label="credential" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"

# Atualizar GEMINI_API_KEY
op item edit pzxuyfevbtwa26fegzd4xsjz64 \
  --vault=oa3tidekmeu26nxiier2qbi7v4 \
  --field-label="credential" \
  --field-value="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
```

---

## ✅ VERIFICAR ATUALIZAÇÃO

```bash
# Verificar GOOGLE_API_KEY
op item get 6xbzl566sj62zphes4b6kodt5e --vault=gkpsbgizlks2zknwzqpppnb2ze --format=json | jq -r '.fields[] | select(.label == "GOOGLE_API_KEY") | .value'

# Verificar Gemini_API_Key_macos
op item get 27ateuu2y37dblvo3lkb4szt6y --vault=gkpsbgizlks2zknwzqpppnb2ze --format=json | jq -r '.fields[] | select(.label == "credential") | .value'

# Verificar GEMINI_API_KEY
op item get pzxuyfevbtwa26fegzd4xsjz64 --vault=oa3tidekmeu26nxiier2qbi7v4 --format=json | jq -r '.fields[] | select(.label == "credential") | .value'
```

---

## 📋 RESUMO

| Item | Vault | Campo | Status |
|------|-------|-------|--------|
| GOOGLE_API_KEY | 1p_macos | GOOGLE_API_KEY | ⏳ Pendente |
| Gemini_API_Key_macos | 1p_macos | credential | ⏳ Pendente |
| GEMINI_API_KEY | 1p_vps | credential | ⏳ Pendente |
| GCP - Gemini Code Assist | 1p_vps | N/A | ✅ Não requer |

---

**Status**: Comandos prontos para execução manual

