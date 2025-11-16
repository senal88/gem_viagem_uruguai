# 🔑 Resumo: Google API Key

## ✅ STATUS ATUAL

### Local (Mac)
- ✅ **Configurada**: `AQ.Ab8RN6Lqo6jrKtgINQwQ925S83ceUYisIk1iKSD8ccfnUTmxfA`
- 📍 Arquivo: `~/gem_viagem_uruguai/.env`

### VPS (senamfo.com.br)
- ✅ **Configurada**: Mesma chave sincronizada
- 📍 Arquivo: `/opt/gem_viagem_uruguai/06_DASHBOARD/.env`
- ✅ Serviço reiniciado

---

## 🚀 COMO GERAR NOVA (Se Precisar)

### Método Rápido:

1. **Acesse**: https://aistudio.google.com/
2. **Clique**: "Get API Key"
3. **Crie**: Nova chave em projeto novo ou existente
4. **Copie**: A chave (formato: `AIzaSy...` ou `AQ...`)

### Método Detalhado:

Veja guia completo: `03_WORKFLOWS/18_guia_completo_google_api_key.md`

---

## 🔍 COMO ENCONTRAR EXISTENTE

### Opção 1: Google AI Studio
- https://aistudio.google.com/ → "Get API Key"

### Opção 2: Google Cloud Console
- https://console.cloud.google.com/ → "APIs & Services" → "Credentials"

### Opção 3: Script Automático
```bash
./scripts/buscar_google_api_key.sh
```

---

## ⚙️ CONFIGURAR NO PROJETO

### Local (Mac):
```bash
echo "GOOGLE_API_KEY=sua_chave" >> ~/gem_viagem_uruguai/.env
```

### VPS:
```bash
ssh root@147.79.81.59
echo "GOOGLE_API_KEY=sua_chave" >> /opt/gem_viagem_uruguai/06_DASHBOARD/.env
systemctl restart gemexpert
```

---

## ✅ TESTAR

### Teste Rápido:
```bash
cd ~/gem_viagem_uruguai
source venv/bin/activate
python3 -c "import os; from dotenv import load_dotenv; import google.generativeai as genai; load_dotenv(); genai.configure(api_key=os.getenv('GOOGLE_API_KEY')); print('✅ Funcionando!')"
```

### Teste no Dashboard:
1. Acesse: http://senamfo.com.br:8081/gem/
2. Selecione "Gemini 2.5 Pro" no chat
3. Envie uma mensagem

---

**Última atualização**: 16 de Novembro de 2025

