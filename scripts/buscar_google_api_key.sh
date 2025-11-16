#!/bin/bash

# Script para Buscar Google API Key
# GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔍 Buscando Google API Key...${NC}\n"

# 1. Verificar no .env local
echo -e "${YELLOW}1. Verificando .env local...${NC}"
if [ -f ".env" ]; then
    KEY=$(grep -i "GOOGLE_API_KEY" .env | cut -d'=' -f2 | tr -d ' ')
    if [ ! -z "$KEY" ]; then
        echo -e "${GREEN}   ✅ Encontrada no .env local${NC}"
        echo -e "   ${KEY:0:15}...${KEY: -5}"
    else
        echo -e "${RED}   ❌ Não encontrada${NC}"
    fi
else
    echo -e "${RED}   ❌ Arquivo .env não existe${NC}"
fi

# 2. Verificar no .env da VPS
echo -e "\n${YELLOW}2. Verificando .env na VPS...${NC}"
KEY_VPS=$(ssh root@147.79.81.59 "cat /opt/gem_viagem_uruguai/06_DASHBOARD/.env 2>/dev/null | grep -i GOOGLE_API_KEY | cut -d'=' -f2 | tr -d ' '" 2>/dev/null)
if [ ! -z "$KEY_VPS" ]; then
    echo -e "${GREEN}   ✅ Encontrada na VPS${NC}"
    echo -e "   ${KEY_VPS:0:15}...${KEY_VPS: -5}"
else
    echo -e "${RED}   ❌ Não encontrada${NC}"
fi

# 3. Instruções
echo -e "\n${BLUE}📝 Como obter Google API Key:${NC}"
echo -e "   1. Acesse: ${GREEN}https://aistudio.google.com/${NC}"
echo -e "   2. Clique em 'Get API Key'"
echo -e "   3. Crie uma nova ou use existente"
echo -e "   4. Copie a chave (formato: AIzaSy...)"
echo -e "\n${BLUE}📝 Como configurar:${NC}"
echo -e "   ${YELLOW}Local:${NC}"
echo -e "   echo 'GOOGLE_API_KEY=sua_chave' >> .env"
echo -e "\n   ${YELLOW}VPS:${NC}"
echo -e "   ssh root@147.79.81.59"
echo -e "   echo 'GOOGLE_API_KEY=sua_chave' >> /opt/gem_viagem_uruguai/06_DASHBOARD/.env"
echo -e "   systemctl restart gemexpert"

