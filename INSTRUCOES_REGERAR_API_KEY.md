# 🔐 INSTRUÇÕES RÁPIDAS - Regenerar Chave de API do Google

## ⚡ PASSO A PASSO RÁPIDO

### 1️⃣ Acessar Google Cloud Console
👉 https://console.cloud.google.com/apis/credentials?project=gcp-ai-setup-24410

### 2️⃣ Localizar e Regenerar Chave
1. Encontre a chave: `AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs`
2. Clique em **"Editar"** (ícone de lápis)
3. Clique em **"Regenerar chave"**
4. Copie a **nova chave**

### 3️⃣ Atualizar Localmente
```bash
cd /Users/luiz.sena88/gem_viagem_uruguai
nano .env
# Atualizar:
GOOGLE_API_KEY=nova_chave_aqui
GOOGLE_MAPS_API_KEY=nova_chave_aqui
```

### 4️⃣ Atualizar no VPS
```bash
ssh root@147.79.81.59
cd /opt/gem_viagem_uruguai/06_DASHBOARD
nano .env
# Atualizar GOOGLE_API_KEY
systemctl restart gemexpert
```

### 5️⃣ Configurar Restrições (IMPORTANTE!)
Na página de edição da chave:

**Restrições de Aplicativo:**
```
http://senamfo.com.br:8081/*
https://senamfo.com.br/*
localhost:5000/*
127.0.0.1:5000/*
```

**Restrições de API:**
- ✅ Google Maps JavaScript API
- ✅ Google Maps Geocoding API
- ✅ Google Maps Directions API

---

## ✅ PRONTO!

A chave antiga foi removida do repositório. Após regenerar e atualizar, tudo voltará a funcionar normalmente.

