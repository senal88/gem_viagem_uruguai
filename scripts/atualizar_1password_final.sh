#!/bin/bash
# Script final para atualizar itens específicos com estrutura conhecida

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

NOVA_GOOGLE_API_KEY="AIzaSyDpBm7CuSoB_zofE9-ySiSRiAs4iIk6fq0"

echo -e "${BLUE}🔐 Atualização Final - 1Password${NC}\n"

# Item 1: GOOGLE_API_KEY no 1p_macos (campo "credential")
echo -e "${GREEN}1. Atualizando GOOGLE_API_KEY (1p_macos)...${NC}"
if op item edit "6xbzl566sj62zphes4b6kodt5e" \
    --vault="gkpsbgizlks2zknwzqpppnb2ze" \
    --field-label="credential" \
    --field-value="$NOVA_GOOGLE_API_KEY" \
    2>/dev/null; then
    echo -e "   ${GREEN}✅ Atualizado!${NC}\n"
else
    echo -e "   ${YELLOW}⚠️  Erro ou campo não encontrado${NC}\n"
fi

# Item 2: Gemini_API_Key_macos (campo "credential")
echo -e "${GREEN}2. Atualizando Gemini_API_Key_macos (1p_macos)...${NC}"
if op item edit "27ateuu2y37dblvo3lkb4szt6y" \
    --vault="gkpsbgizlks2zknwzqpppnb2ze" \
    --field-label="credential" \
    --field-value="$NOVA_GOOGLE_API_KEY" \
    2>/dev/null; then
    echo -e "   ${GREEN}✅ Atualizado!${NC}\n"
else
    echo -e "   ${YELLOW}⚠️  Erro ou campo não encontrado${NC}\n"
fi

# Item 3: GCP - Gemini Code Assist (1p_vps) - campo "password" ou "credential"
echo -e "${GREEN}3. Atualizando GCP - Gemini Code Assist (1p_vps)...${NC}"
if op item edit "6zhhvw43e4cprsqgtzmqxuqysa" \
    --vault="oa3tidekmeu26nxiier2qbi7v4" \
    --field-label="password" \
    --field-value="$NOVA_GOOGLE_API_KEY" \
    2>/dev/null; then
    echo -e "   ${GREEN}✅ Campo 'password' atualizado!${NC}\n"
elif op item edit "6zhhvw43e4cprsqgtzmqxuqysa" \
    --vault="oa3tidekmeu26nxiier2qbi7v4" \
    --field-label="credential" \
    --field-value="$NOVA_GOOGLE_API_KEY" \
    2>/dev/null; then
    echo -e "   ${GREEN}✅ Campo 'credential' atualizado!${NC}\n"
else
    echo -e "   ${YELLOW}⚠️  Erro ou campo não encontrado${NC}\n"
fi

# Item 4: GEMINI_API_KEY (1p_vps) - campo "credential"
echo -e "${GREEN}4. Atualizando GEMINI_API_KEY (1p_vps)...${NC}"
if op item edit "pzxuyfevbtwa26fegzd4xsjz64" \
    --vault="oa3tidekmeu26nxiier2qbi7v4" \
    --field-label="credential" \
    --field-value="$NOVA_GOOGLE_API_KEY" \
    2>/dev/null; then
    echo -e "   ${GREEN}✅ Atualizado!${NC}\n"
else
    echo -e "   ${YELLOW}⚠️  Erro ou campo não encontrado${NC}\n"
fi

echo -e "${GREEN}✅ Atualização concluída!${NC}\n"
echo -e "${BLUE}📋 Nova chave: ${GREEN}$NOVA_GOOGLE_API_KEY${NC}\n"
echo -e "${YELLOW}💡 Verifique manualmente no 1Password para confirmar${NC}\n"

