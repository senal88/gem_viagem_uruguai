# 🔧 COMANDOS GCLOUD CLI - Regenerar API Key

## ⚡ COMANDOS DIRETOS PARA EXECUTAR

---

## 📋 PRÉ-REQUISITOS

```bash
# Verificar se gcloud está instalado
gcloud --version

# Fazer login
gcloud auth login

# Configurar projeto
gcloud config set project gcp-ai-setup-24410
```

---

## 🔍 PASSO 1: IDENTIFICAR A CHAVE COMPROMETIDA

```bash
# Listar todas as chaves de API
gcloud services api-keys list --project=gcp-ai-setup-24410 --format="table(name,displayName,createTime,restrictions.apiTargets[].service)"

# Listar com mais detalhes (incluindo chave atual - se visível)
gcloud services api-keys list --project=gcp-ai-setup-24410 --format=json

# Buscar chave específica pelo nome
gcloud services api-keys list --project=gcp-ai-setup-24410 --filter="displayName:GOOGLE_API_KEY"
```

---

## 🔄 PASSO 2: REGENERAR A CHAVE

### Método 1: Via Console (Recomendado)

1. Acesse: https://console.cloud.google.com/apis/credentials?project=gcp-ai-setup-24410
2. Localize a chave "GOOGLE_API_KEY" (criada em 22 de out. de 2025)
3. Clique em "Editar"
4. Clique em "Regenerar chave"
5. Copie a nova chave

### Método 2: Via gcloud CLI

```bash
# Primeiro, obter o ID da chave
KEY_ID=$(gcloud services api-keys list --project=gcp-ai-setup-24410 --filter="displayName:GOOGLE_API_KEY" --format="value(name)" | cut -d'/' -f6)

# Regenerar a chave
gcloud services api-keys update $KEY_ID \
  --regenerate-key \
  --project=gcp-ai-setup-24410

# Obter a nova chave
gcloud services api-keys get-key-string $KEY_ID \
  --project=gcp-ai-setup-24410
```

---

## 🔐 PASSO 3: CONFIGURAR RESTRIÇÕES

### Restrições de API

```bash
# Atualizar restrições de API
gcloud services api-keys update $KEY_ID \
  --api-targets=generativelanguage.googleapis.com \
  --api-targets=maps-backend.googleapis.com \
  --api-targets=geocoding-backend.googleapis.com \
  --api-targets=directions-backend.googleapis.com \
  --project=gcp-ai-setup-24410
```

### Restrições de HTTP Referrers

```bash
# Atualizar com restrições de HTTP referrers
gcloud services api-keys update $KEY_ID \
  --allowed-referrers="http://senamfo.com.br:8081/*" \
  --allowed-referrers="https://senamfo.com.br/*" \
  --allowed-referrers="http://localhost:5000/*" \
  --allowed-referrers="http://127.0.0.1:5000/*" \
  --project=gcp-ai-setup-24410
```

### Restrições de IP

```bash
# Atualizar com restrições de IP
gcloud services api-keys update $KEY_ID \
  --allowed-ips="147.79.81.59/32" \
  --project=gcp-ai-setup-24410
```

---

## 🧪 PASSO 4: VALIDAR A NOVA CHAVE

```bash
# Testar Generative Language API
curl "https://generativelanguage.googleapis.com/v1beta/models?key=NOVA_CHAVE_AQUI"

# Testar Geocoding API
curl "https://maps.googleapis.com/maps/api/geocode/json?address=Montevideo&key=NOVA_CHAVE_AQUI"
```

---

## 📝 SCRIPT COMPLETO AUTOMATIZADO

```bash
#!/bin/bash
# Script completo para regenerar e configurar Google API Key

set -e

PROJECT_ID="gcp-ai-setup-24410"
KEY_NAME="GOOGLE_API_KEY"

echo "🔍 Identificando chave..."

# Obter ID da chave
KEY_ID=$(gcloud services api-keys list \
  --project=$PROJECT_ID \
  --filter="displayName:$KEY_NAME" \
  --format="value(name)" | cut -d'/' -f6)

if [ -z "$KEY_ID" ]; then
    echo "❌ Chave não encontrada!"
    exit 1
fi

echo "✅ Chave encontrada: $KEY_ID"
echo "🔄 Regenerando chave..."

# Regenerar chave
gcloud services api-keys update $KEY_ID \
  --regenerate-key \
  --project=$PROJECT_ID

# Obter nova chave
echo "📋 Obtendo nova chave..."
NEW_KEY=$(gcloud services api-keys get-key-string $KEY_ID \
  --project=$PROJECT_ID \
  --format="value(keyString)")

echo "✅ Nova chave gerada!"
echo "🔑 Chave: ${NEW_KEY:0:20}..."

# Configurar restrições
echo "🔐 Configurando restrições..."

gcloud services api-keys update $KEY_ID \
  --api-targets=generativelanguage.googleapis.com \
  --api-targets=maps-backend.googleapis.com \
  --api-targets=geocoding-backend.googleapis.com \
  --api-targets=directions-backend.googleapis.com \
  --allowed-referrers="http://senamfo.com.br:8081/*" \
  --allowed-referrers="https://senamfo.com.br/*" \
  --allowed-referrers="http://localhost:5000/*" \
  --project=$PROJECT_ID

echo "✅ Restrições configuradas!"
echo ""
echo "📋 PRÓXIMOS PASSOS:"
echo "1. Copie a nova chave acima"
echo "2. Execute: ./scripts/regenerar_google_api_key.sh $NEW_KEY"
echo "3. Teste: ./scripts/testar_google_api_key.sh"
```

---

## 🚨 IMPORTANTE

### Verificar Uso Anormal da Chave Antiga

```bash
# Ver logs de uso da API
gcloud logging read "resource.type=api AND protoPayload.serviceName=generativelanguage.googleapis.com" \
  --project=gcp-ai-setup-24410 \
  --limit=50 \
  --format=json

# Verificar faturamento
gcloud billing accounts list
gcloud billing projects describe gcp-ai-setup-24410
```

### Desabilitar Chave Antiga (Após Regenerar)

```bash
# Desabilitar chave antiga (se ainda existir)
gcloud services api-keys update $KEY_ID \
  --disable \
  --project=gcp-ai-setup-24410
```

---

## 📚 REFERÊNCIAS

- **Documentação gcloud**: https://cloud.google.com/sdk/gcloud/reference/services/api-keys
- **Console**: https://console.cloud.google.com/apis/credentials?project=gcp-ai-setup-24410
- **Logs**: https://console.cloud.google.com/logs?project=gcp-ai-setup-24410

---

**Última atualização**: 16 de Novembro de 2025

