#!/bin/bash
# Script para atualizar automaticamente registros específicos no 1Password

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
    exit 1
fi

# Verificar se está logado
if ! op account list &> /dev/null; then
    echo -e "${YELLOW}⚠️  Fazendo login no 1Password...${NC}"
    op signin
fi

echo -e "${GREEN}✅ 1Password CLI configurado${NC}\n"

# Função para atualizar item específico
atualizar_item() {
    local ITEM_ID=$1
    local VAULT=$2
    local FIELD_LABEL=$3
    local FIELD_VALUE=$4

    echo -e "${BLUE}📝 Atualizando: $FIELD_LABEL${NC}"

    # Tentar atualizar campo existente
    op item edit "$ITEM_ID" \
        --vault="$VAULT" \
        --field-label="$FIELD_LABEL" \
        --field-value="$FIELD_VALUE" \
        2>/dev/null && echo -e "${GREEN}   ✅ Atualizado${NC}" || echo -e "${YELLOW}   ⚠️  Campo não encontrado ou erro${NC}"
}

# Buscar itens específicos por título
echo -e "${BLUE}🔍 Buscando itens específicos...${NC}\n"

# 1. Google API Key / Gemini API Key
echo -e "${GREEN}1. Atualizando Google/Gemini API Keys...${NC}"
ITEMS_GOOGLE=$(op item list --format=json 2>/dev/null | jq -r '.[] | select(.title | test("(?i)(google.*api|gemini.*api|GEMINI_API_KEY|GOOGLE_API_KEY|GEMINI|Google.*AI)"; "g")) | "\(.id)|\(.vault)"' 2>/dev/null || echo "")

if [ ! -z "$ITEMS_GOOGLE" ]; then
    echo "$ITEMS_GOOGLE" | while IFS='|' read -r item_id vault; do
        echo -e "   ${BLUE}Item: $item_id (Vault: $vault)${NC}"
        atualizar_item "$item_id" "$vault" "API Key" "$NOVA_GOOGLE_API_KEY"
        atualizar_item "$item_id" "$vault" "credential" "$NOVA_GOOGLE_API_KEY"
        atualizar_item "$item_id" "$vault" "Project ID" "$PROJECT_ID"
        echo ""
    done
else
    echo -e "${YELLOW}   ⚠️  Nenhum item Google/Gemini encontrado${NC}\n"
fi

# 2. GCP Project
echo -e "${GREEN}2. Atualizando GCP Project...${NC}"
ITEMS_GCP=$(op item list --format=json 2>/dev/null | jq -r '.[] | select(.title | test("(?i)(gcp|google.*cloud|gcp-ai-setup)"; "g")) | "\(.id)|\(.vault)"' 2>/dev/null || echo "")

if [ ! -z "$ITEMS_GCP" ]; then
    echo "$ITEMS_GCP" | while IFS='|' read -r item_id vault; do
        echo -e "   ${BLUE}Item: $item_id (Vault: $vault)${NC}"
        atualizar_item "$item_id" "$vault" "API Key" "$NOVA_GOOGLE_API_KEY"
        atualizar_item "$item_id" "$vault" "Project ID" "$PROJECT_ID"
        echo ""
    done
else
    echo -e "${YELLOW}   ⚠️  Nenhum item GCP encontrado${NC}\n"
fi

# 3. VPS / senamfo.com.br
echo -e "${GREEN}3. Atualizando VPS / senamfo.com.br...${NC}"
ITEMS_VPS=$(op item list --vault="1p_vps" --format=json 2>/dev/null | jq -r '.[] | select(.title | test("(?i)(vps|senamfo|147.79)"; "g")) | "\(.id)|\(.vault)"' 2>/dev/null || echo "")

if [ ! -z "$ITEMS_VPS" ]; then
    echo "$ITEMS_VPS" | while IFS='|' read -r item_id vault; do
        echo -e "   ${BLUE}Item: $item_id (Vault: $vault)${NC}"
        atualizar_item "$item_id" "$vault" "Google API Key" "$NOVA_GOOGLE_API_KEY"
        atualizar_item "$item_id" "$vault" "Dashboard URL" "$DASHBOARD_URL"
        echo ""
    done
else
    echo -e "${YELLOW}   ⚠️  Nenhum item VPS encontrado${NC}\n"
fi

# 4. GEM Expert / Uruguai
echo -e "${GREEN}4. Atualizando GEM Expert / Uruguai...${NC}"
ITEMS_GEM=$(op item list --format=json 2>/dev/null | jq -r '.[] | select(.title | test("(?i)(gem.*expert|uruguai|viagem.*uruguai)"; "g")) | "\(.id)|\(.vault)"' 2>/dev/null || echo "")

if [ ! -z "$ITEMS_GEM" ]; then
    echo "$ITEMS_GEM" | while IFS='|' read -r item_id vault; do
        echo -e "   ${BLUE}Item: $item_id (Vault: $vault)${NC}"
        atualizar_item "$item_id" "$vault" "Google API Key" "$NOVA_GOOGLE_API_KEY"
        atualizar_item "$item_id" "$vault" "Dashboard URL" "$DASHBOARD_URL"
        atualizar_item "$item_id" "$vault" "Project ID" "$PROJECT_ID"
        echo ""
    done
else
    echo -e "${YELLOW}   ⚠️  Nenhum item GEM Expert encontrado${NC}\n"
fi

echo -e "${GREEN}✅ Processo concluído!${NC}\n"

echo -e "${BLUE}📋 RESUMO:${NC}"
echo -e "Nova chave: ${GREEN}$NOVA_GOOGLE_API_KEY${NC}"
echo -e "Project ID: ${GREEN}$PROJECT_ID${NC}"
echo -e "Dashboard: ${GREEN}$DASHBOARD_URL${NC}\n"

echo -e "${YELLOW}💡 Dica: Verifique manualmente os itens atualizados no 1Password${NC}\n"

