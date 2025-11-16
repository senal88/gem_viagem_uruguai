#!/bin/bash
# Script com estrutura correta dos campos baseado na inspeção

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

NOVA_GOOGLE_API_KEY="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"

echo -e "${BLUE}🔐 Atualização Correta - 1Password${NC}\n"

# Item 1: GOOGLE_API_KEY no 1p_macos - campo "GOOGLE_API_KEY"
echo -e "${GREEN}1. Atualizando GOOGLE_API_KEY (1p_macos)...${NC}"
if op item edit "6xbzl566sj62zphes4b6kodt5e" \
    --vault="gkpsbgizlks2zknwzqpppnb2ze" \
    --field-label="GOOGLE_API_KEY" \
    --field-value="$NOVA_GOOGLE_API_KEY" \
    2>&1 | grep -q "Updated"; then
    echo -e "   ${GREEN}✅ Atualizado com sucesso!${NC}\n"
else
    # Tentar método alternativo
    op item edit "6xbzl566sj62zphes4b6kodt5e" \
        --vault="gkpsbgizlks2zknwzqpppnb2ze" \
        --field="GOOGLE_API_KEY"="$NOVA_GOOGLE_API_KEY" \
        2>/dev/null && echo -e "   ${GREEN}✅ Atualizado!${NC}\n" || echo -e "   ${YELLOW}⚠️  Atualizar manualmente${NC}\n"
fi

# Item 2: Gemini_API_Key_macos - campo "credential"
echo -e "${GREEN}2. Atualizando Gemini_API_Key_macos (1p_macos)...${NC}"
if op item edit "27ateuu2y37dblvo3lkb4szt6y" \
    --vault="gkpsbgizlks2zknwzqpppnb2ze" \
    --field-label="credential" \
    --field-value="$NOVA_GOOGLE_API_KEY" \
    2>&1 | grep -q "Updated"; then
    echo -e "   ${GREEN}✅ Atualizado com sucesso!${NC}\n"
else
    op item edit "27ateuu2y37dblvo3lkb4szt6y" \
        --vault="gkpsbgizlks2zknwzqpppnb2ze" \
        --field="credential"="$NOVA_GOOGLE_API_KEY" \
        2>/dev/null && echo -e "   ${GREEN}✅ Atualizado!${NC}\n" || echo -e "   ${YELLOW}⚠️  Atualizar manualmente${NC}\n"
fi

# Item 3: GEMINI_API_KEY (1p_vps) - campo "credential"
echo -e "${GREEN}3. Atualizando GEMINI_API_KEY (1p_vps)...${NC}"
if op item edit "pzxuyfevbtwa26fegzd4xsjz64" \
    --vault="oa3tidekmeu26nxiier2qbi7v4" \
    --field-label="credential" \
    --field-value="$NOVA_GOOGLE_API_KEY" \
    2>&1 | grep -q "Updated"; then
    echo -e "   ${GREEN}✅ Atualizado com sucesso!${NC}\n"
else
    op item edit "pzxuyfevbtwa26fegzd4xsjz64" \
        --vault="oa3tidekmeu26nxiier2qbi7v4" \
        --field="credential"="$NOVA_GOOGLE_API_KEY" \
        2>/dev/null && echo -e "   ${GREEN}✅ Atualizado!${NC}\n" || echo -e "   ${YELLOW}⚠️  Atualizar manualmente${NC}\n"
fi

echo -e "${GREEN}✅ Processo concluído!${NC}\n"
echo -e "${BLUE}📋 Nova chave: ${GREEN}$NOVA_GOOGLE_API_KEY${NC}\n"

# Criar resumo de atualização manual se necessário
echo -e "${YELLOW}📝 Se algum item não foi atualizado, use os comandos abaixo:${NC}\n"

echo -e "${BLUE}GOOGLE_API_KEY (1p_macos):${NC}"
echo -e "op item edit 6xbzl566sj62zphes4b6kodt5e --vault=gkpsbgizlks2zknwzqpppnb2ze --field-label='GOOGLE_API_KEY' --field-value='$NOVA_GOOGLE_API_KEY'\n"

echo -e "${BLUE}Gemini_API_Key_macos (1p_macos):${NC}"
echo -e "op item edit 27ateuu2y37dblvo3lkb4szt6y --vault=gkpsbgizlks2zknwzqpppnb2ze --field-label='credential' --field-value='$NOVA_GOOGLE_API_KEY'\n"

echo -e "${BLUE}GEMINI_API_KEY (1p_vps):${NC}"
echo -e "op item edit pzxuyfevbtwa26fegzd4xsjz64 --vault=oa3tidekmeu26nxiier2qbi7v4 --field-label='credential' --field-value='$NOVA_GOOGLE_API_KEY'\n"

