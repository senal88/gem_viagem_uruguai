#!/bin/bash
# Script inteligente que inspeciona a estrutura dos itens antes de atualizar

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

NOVA_GOOGLE_API_KEY="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"
PROJECT_ID="gcp-ai-setup-24410"
DASHBOARD_URL="http://senamfo.com.br:8081/gem/"

echo -e "${BLUE}🔐 Atualização Inteligente - 1Password${NC}\n"

if ! command -v op &> /dev/null; then
    echo -e "${RED}❌ 1Password CLI não encontrado${NC}"
    exit 1
fi

if ! op account list &> /dev/null; then
    op signin
fi

# IDs específicos encontrados
ITEMS_GOOGLE=(
    "6xbzl566sj62zphes4b6kodt5e|gkpsbgizlks2zknwzqpppnb2ze|GOOGLE_API_KEY | 22-10-25 | aistudio.google.com"
    "27ateuu2y37dblvo3lkb4szt6y|gkpsbgizlks2zknwzqpppnb2ze|Gemini_API_Key_macos"
    "6zhhvw43e4cprsqgtzmqxuqysa|oa3tidekmeu26nxiier2qbi7v4|GCP - Gemini Code Assist"
    "pzxuyfevbtwa26fegzd4xsjz64|oa3tidekmeu26nxiier2qbi7v4|GEMINI_API_KEY"
)

echo -e "${GREEN}📋 Atualizando itens específicos encontrados...${NC}\n"

for item_info in "${ITEMS_GOOGLE[@]}"; do
    IFS='|' read -r item_id vault_id item_title <<< "$item_info"
    vault_name=$(op vault get "$vault_id" --format=json 2>/dev/null | jq -r '.name' || echo "unknown")

    echo -e "${BLUE}📝 Item: $item_title${NC}"
    echo -e "   ${BLUE}Vault: $vault_name${NC}"

    # Obter estrutura do item
    item_json=$(op item get "$item_id" --vault="$vault_id" --format=json 2>/dev/null || echo "{}")

    # Tentar encontrar campo de API Key
    field_label=$(echo "$item_json" | jq -r '.fields[]? | select(.label | test("(?i)(api.*key|credential|key)"; "g")) | .label' 2>/dev/null | head -1)

    if [ ! -z "$field_label" ] && [ "$field_label" != "null" ]; then
        echo -e "   ${GREEN}✅ Campo encontrado: '$field_label'${NC}"

        # Atualizar campo encontrado
        if op item edit "$item_id" \
            --vault="$vault_id" \
            --field-label="$field_label" \
            --field-value="$NOVA_GOOGLE_API_KEY" \
            2>/dev/null; then
            echo -e "   ${GREEN}✅ Atualizado com sucesso!${NC}"
        else
            echo -e "   ${YELLOW}⚠️  Erro ao atualizar${NC}"
        fi
    else
        # Tentar atualizar campos comuns
        campos_tentados=("credential" "API Key" "api_key" "GOOGLE_API_KEY" "GEMINI_API_KEY")
        atualizado=false

        for campo in "${campos_tentados[@]}"; do
            if op item edit "$item_id" \
                --vault="$vault_id" \
                --field-label="$campo" \
                --field-value="$NOVA_GOOGLE_API_KEY" \
                2>/dev/null; then
                echo -e "   ${GREEN}✅ Campo '$campo' atualizado!${NC}"
                atualizado=true
                break
            fi
        done

        if [ "$atualizado" = false ]; then
            echo -e "   ${YELLOW}⚠️  Nenhum campo encontrado - atualizar manualmente${NC}"
            echo -e "   ${BLUE}   Ver estrutura: op item get $item_id --vault=$vault_id${NC}"
        fi
    fi

    echo ""
done

echo -e "${GREEN}✅ Processo concluído!${NC}\n"
echo -e "${BLUE}📋 Nova chave: ${GREEN}$NOVA_GOOGLE_API_KEY${NC}\n"

