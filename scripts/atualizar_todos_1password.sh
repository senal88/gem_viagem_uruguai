#!/bin/bash
# Script completo para atualizar TODOS os registros relacionados no 1Password
# Inclui todos os vaults: Personal, 1p_macos, 1p_vps, default importado

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

echo -e "${BLUE}🔐 Atualizando TODOS os Registros no 1Password${NC}\n"

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

# Listar todos os vaults
echo -e "${BLUE}📋 Vaults disponíveis:${NC}"
VAULTS=$(op vault list --format=json | jq -r '.[].id' 2>/dev/null || echo "")
echo "$VAULTS" | while read -r vault_id; do
    vault_name=$(op vault get "$vault_id" --format=json 2>/dev/null | jq -r '.name' || echo "unknown")
    echo -e "   ${GREEN}$vault_id${NC} - $vault_name"
done
echo ""

# Função para atualizar campo em um item
atualizar_campo() {
    local ITEM_ID=$1
    local VAULT_ID=$2
    local FIELD_LABEL=$3
    local FIELD_VALUE=$4
    
    # Tentar diferentes métodos de atualização
    op item edit "$ITEM_ID" \
        --vault="$VAULT_ID" \
        --field-label="$FIELD_LABEL" \
        --field-value="$FIELD_VALUE" \
        2>/dev/null && return 0 || return 1
}

# Função para buscar e atualizar itens em um vault específico
atualizar_vault() {
    local VAULT_ID=$1
    local VAULT_NAME=$2
    local SEARCH_PATTERN=$3
    
    echo -e "${BLUE}🔍 Buscando em: ${GREEN}$VAULT_NAME${NC}"
    
    # Buscar itens no vault
    ITEMS=$(op item list --vault="$VAULT_ID" --format=json 2>/dev/null | \
        jq -r ".[] | select(.title | test(\"(?i)$SEARCH_PATTERN\"; \"g\")) | \"\(.id)|\(.title)\"" 2>/dev/null || echo "")
    
    if [ -z "$ITEMS" ]; then
        echo -e "${YELLOW}   ⚠️  Nenhum item encontrado${NC}\n"
        return
    fi
    
    echo "$ITEMS" | while IFS='|' read -r item_id item_title; do
        echo -e "   ${BLUE}📝 Item: $item_title${NC}"
        
        # Tentar atualizar diferentes campos possíveis
        atualizado=false
        
        # Tentar campo "API Key"
        if atualizar_campo "$item_id" "$VAULT_ID" "API Key" "$NOVA_GOOGLE_API_KEY" 2>/dev/null; then
            echo -e "      ${GREEN}✅ Campo 'API Key' atualizado${NC}"
            atualizado=true
        fi
        
        # Tentar campo "credential"
        if atualizar_campo "$item_id" "$VAULT_ID" "credential" "$NOVA_GOOGLE_API_KEY" 2>/dev/null; then
            echo -e "      ${GREEN}✅ Campo 'credential' atualizado${NC}"
            atualizado=true
        fi
        
        # Tentar campo "api_key"
        if atualizar_campo "$item_id" "$VAULT_ID" "api_key" "$NOVA_GOOGLE_API_KEY" 2>/dev/null; then
            echo -e "      ${GREEN}✅ Campo 'api_key' atualizado${NC}"
            atualizado=true
        fi
        
        # Tentar campo "Google API Key"
        if atualizar_campo "$item_id" "$VAULT_ID" "Google API Key" "$NOVA_GOOGLE_API_KEY" 2>/dev/null; then
            echo -e "      ${GREEN}✅ Campo 'Google API Key' atualizado${NC}"
            atualizado=true
        fi
        
        # Tentar campo "GOOGLE_API_KEY"
        if atualizar_campo "$item_id" "$VAULT_ID" "GOOGLE_API_KEY" "$NOVA_GOOGLE_API_KEY" 2>/dev/null; then
            echo -e "      ${GREEN}✅ Campo 'GOOGLE_API_KEY' atualizado${NC}"
            atualizado=true
        fi
        
        # Tentar campo "GEMINI_API_KEY"
        if atualizar_campo "$item_id" "$VAULT_ID" "GEMINI_API_KEY" "$NOVA_GOOGLE_API_KEY" 2>/dev/null; then
            echo -e "      ${GREEN}✅ Campo 'GEMINI_API_KEY' atualizado${NC}"
            atualizado=true
        fi
        
        # Atualizar Project ID se aplicável
        if atualizar_campo "$item_id" "$VAULT_ID" "Project ID" "$PROJECT_ID" 2>/dev/null; then
            echo -e "      ${GREEN}✅ Campo 'Project ID' atualizado${NC}"
        fi
        
        # Atualizar Dashboard URL se aplicável
        if atualizar_campo "$item_id" "$VAULT_ID" "Dashboard URL" "$DASHBOARD_URL" 2>/dev/null; then
            echo -e "      ${GREEN}✅ Campo 'Dashboard URL' atualizado${NC}"
        fi
        
        if [ "$atualizado" = false ]; then
            echo -e "      ${YELLOW}⚠️  Nenhum campo encontrado - atualizar manualmente${NC}"
            echo -e "         ${BLUE}ID: $item_id${NC}"
            echo -e "         ${BLUE}Vault: $VAULT_ID${NC}"
        fi
        
        echo ""
    done
}

# Processar cada vault
echo -e "${GREEN}🚀 Iniciando atualização em todos os vaults...${NC}\n"

# 1. Personal
VAULT_PERSONAL=$(op vault list --format=json | jq -r '.[] | select(.name == "Personal") | .id' 2>/dev/null || echo "")
if [ ! -z "$VAULT_PERSONAL" ]; then
    atualizar_vault "$VAULT_PERSONAL" "Personal" "(google|gemini|api|gcp|gem.*expert)"
fi

# 2. 1p_macos
VAULT_MACOS=$(op vault list --format=json | jq -r '.[] | select(.name == "1p_macos") | .id' 2>/dev/null || echo "")
if [ ! -z "$VAULT_MACOS" ]; then
    atualizar_vault "$VAULT_MACOS" "1p_macos" "(google|gemini|api|gcp|gem.*expert)"
fi

# 3. 1p_vps
VAULT_VPS=$(op vault list --format=json | jq -r '.[] | select(.name == "1p_vps") | .id' 2>/dev/null || echo "")
if [ ! -z "$VAULT_VPS" ]; then
    atualizar_vault "$VAULT_VPS" "1p_vps" "(google|gemini|api|gcp|vps|senamfo|dashboard)"
fi

# 4. default importado
VAULT_DEFAULT=$(op vault list --format=json | jq -r '.[] | select(.name == "default importado") | .id' 2>/dev/null || echo "")
if [ ! -z "$VAULT_DEFAULT" ]; then
    atualizar_vault "$VAULT_DEFAULT" "default importado" "(google|gemini|api|gcp)"
fi

echo -e "${GREEN}✅ Processo concluído!${NC}\n"

echo -e "${BLUE}📋 RESUMO:${NC}"
echo -e "Nova chave: ${GREEN}$NOVA_GOOGLE_API_KEY${NC}"
echo -e "Project ID: ${GREEN}$PROJECT_ID${NC}"
echo -e "Dashboard: ${GREEN}$DASHBOARD_URL${NC}\n"

echo -e "${YELLOW}💡 Dica: Verifique manualmente os itens atualizados no 1Password${NC}"
echo -e "${BLUE}   Alguns campos podem precisar de atualização manual se os nomes forem diferentes${NC}\n"

