#!/bin/bash
# Script para atualizar registros no 1Password com novas informações do projeto

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Nova chave de API do Google
NOVA_GOOGLE_API_KEY="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
PROJECT_ID="gcp-ai-setup-24410"
VPS_IP="147.79.81.59"
VPS_DOMAIN="senamfo.com.br"
DASHBOARD_URL="http://senamfo.com.br:8081/gem/"

echo -e "${BLUE}🔐 Atualizando Registros no 1Password${NC}\n"

# Verificar se op CLI está instalado
if ! command -v op &> /dev/null; then
    echo -e "${RED}❌ 1Password CLI não encontrado${NC}"
    echo -e "${YELLOW}Instale: https://developer.1password.com/docs/cli/get-started${NC}\n"
    exit 1
fi

# Verificar se está logado
if ! op account list &> /dev/null; then
    echo -e "${YELLOW}⚠️  Não está logado no 1Password${NC}"
    echo -e "${BLUE}Fazendo login...${NC}"
    op signin
fi

echo -e "${GREEN}✅ 1Password CLI configurado${NC}\n"

# Listar vaults disponíveis
echo -e "${BLUE}📋 Vaults disponíveis:${NC}"
op vault list

echo -e "\n${BLUE}🔍 Buscando itens relacionados ao projeto...${NC}"

# Buscar itens relacionados
ITEMS=$(op item list --format=json 2>/dev/null | jq -r '.[] | select(.title | test("(?i)(google|gemini|gcp|api|gem expert|uruguai)"; "g")) | .id' 2>/dev/null || echo "")

if [ -z "$ITEMS" ]; then
    echo -e "${YELLOW}⚠️  Nenhum item encontrado automaticamente${NC}"
    echo -e "${BLUE}Vamos criar/atualizar manualmente...${NC}\n"
    
    # Criar/atualizar item principal
    echo -e "${BLUE}📝 Criando/Atualizando item 'GEM Expert - Google API Key'...${NC}"
    
    # Template JSON para criar item
    ITEM_JSON=$(cat <<EOF
{
  "title": "GEM Expert - Google API Key",
  "category": "API_CREDENTIAL",
  "fields": [
    {
      "id": "credential",
      "type": "CONCEALED",
      "label": "API Key",
      "value": "$NOVA_GOOGLE_API_KEY"
    },
    {
      "id": "project_id",
      "type": "STRING",
      "label": "Project ID",
      "value": "$PROJECT_ID"
    },
    {
      "id": "vps_ip",
      "type": "STRING",
      "label": "VPS IP",
      "value": "$VPS_IP"
    },
    {
      "id": "dashboard_url",
      "type": "URL",
      "label": "Dashboard URL",
      "value": "$DASHBOARD_URL"
    },
    {
      "id": "created_date",
      "type": "DATE",
      "label": "Created",
      "value": "2025-11-16"
    }
  ],
  "sections": [
    {
      "id": "restrictions",
      "label": "Restrições",
      "fields": [
        {
          "id": "apis",
          "type": "STRING",
          "label": "APIs Permitidas",
          "value": "Generative Language API, Maps Backend API, Geocoding API, Directions API, Places API"
        },
        {
          "id": "referrers",
          "type": "STRING",
          "label": "HTTP Referrers",
          "value": "http://senamfo.com.br:8081/*, https://senamfo.com.br/*, localhost:5000/*, 127.0.0.1:5000/*"
        }
      ]
    }
  ]
}
EOF
)
    
    echo -e "${GREEN}✅ Item preparado${NC}"
    echo -e "${YELLOW}⚠️  Para criar via CLI, use:${NC}"
    echo -e "${BLUE}op item create --template='API Credential' --title='GEM Expert - Google API Key' --vault='Personal'${NC}\n"
    
else
    echo -e "${GREEN}✅ Encontrados itens relacionados${NC}"
    echo "$ITEMS" | while read -r item_id; do
        echo -e "${BLUE}Atualizando item: $item_id${NC}"
        # Atualizar item (requer estrutura específica)
    done
fi

echo -e "\n${BLUE}📋 INSTRUÇÕES MANUAIS:${NC}\n"

echo -e "${GREEN}1. Google API Key (GEM Expert)${NC}"
echo -e "   Vault: Personal"
echo -e "   Campo 'API Key': ${NOVA_GOOGLE_API_KEY}"
echo -e "   Campo 'Project ID': ${PROJECT_ID}"
echo -e "   Campo 'Dashboard URL': ${DASHBOARD_URL}\n"

echo -e "${GREEN}2. VPS - senamfo.com.br${NC}"
echo -e "   Vault: 1p_vps"
echo -e "   Campo 'Dashboard URL': ${DASHBOARD_URL}"
echo -e "   Campo 'Google API Key': ${NOVA_GOOGLE_API_KEY}\n"

echo -e "${GREEN}3. GCP - gcp-ai-setup-24410${NC}"
echo -e "   Vault: Personal"
echo -e "   Campo 'API Key': ${NOVA_GOOGLE_API_KEY}"
echo -e "   Campo 'Project ID': ${PROJECT_ID}\n"

echo -e "${BLUE}📝 Para atualizar via CLI:${NC}"
echo -e "op item edit ITEM_ID --field-label='API Key' --field-value='${NOVA_GOOGLE_API_KEY}'\n"

echo -e "${GREEN}✅ Instruções geradas${NC}\n"

