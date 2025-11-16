#!/bin/bash
# Script para testar se a Google API Key está funcionando

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🧪 Testando Google API Key${NC}\n"

# Carregar .env
ENV_FILE="$HOME/gem_viagem_uruguai/.env"
if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}❌ Arquivo .env não encontrado em $ENV_FILE${NC}"
    exit 1
fi

source "$ENV_FILE"

if [ -z "$GOOGLE_API_KEY" ]; then
    echo -e "${RED}❌ GOOGLE_API_KEY não encontrada no .env${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Chave encontrada: ${GOOGLE_API_KEY:0:10}...${NC}\n"

# Teste 1: Google Maps Geocoding API
echo -e "${BLUE}1. Testando Geocoding API...${NC}"
GEOCODE_RESPONSE=$(curl -s "https://maps.googleapis.com/maps/api/geocode/json?address=Montevideo&key=$GOOGLE_API_KEY")

if echo "$GEOCODE_RESPONSE" | grep -q '"status" : "OK"'; then
    echo -e "${GREEN}   ✅ Geocoding API funcionando${NC}"
else
    ERROR=$(echo "$GEOCODE_RESPONSE" | grep -o '"error_message" : "[^"]*"' | cut -d'"' -f4)
    if [ -z "$ERROR" ]; then
        ERROR=$(echo "$GEOCODE_RESPONSE" | grep -o '"status" : "[^"]*"' | cut -d'"' -f4)
    fi
    echo -e "${RED}   ❌ Erro: $ERROR${NC}"
fi

# Teste 2: Google Generative AI (Gemini)
echo -e "\n${BLUE}2. Testando Google Generative AI (Gemini)...${NC}"
if command -v python3 &> /dev/null; then
    PYTHON_TEST=$(python3 << EOF
import os
import sys
try:
    from dotenv import load_dotenv
    load_dotenv("$ENV_FILE")
    import google.generativeai as genai

    genai.configure(api_key=os.getenv('GOOGLE_API_KEY'))
    model = genai.GenerativeModel('gemini-pro')
    response = model.generate_content("Teste")
    print("OK")
except Exception as e:
    print(f"ERRO: {str(e)}")
    sys.exit(1)
EOF
)

    if [ "$PYTHON_TEST" == "OK" ]; then
        echo -e "${GREEN}   ✅ Gemini API funcionando${NC}"
    else
        echo -e "${RED}   ❌ Erro: $PYTHON_TEST${NC}"
    fi
else
    echo -e "${YELLOW}   ⚠️  Python3 não encontrado - pulando teste Gemini${NC}"
fi

# Teste 3: Verificar no dashboard
echo -e "\n${BLUE}3. Testando no Dashboard...${NC}"
DASHBOARD_URL="http://senamfo.com.br:8081/gem/"
echo -e "   Acesse: ${GREEN}$DASHBOARD_URL${NC}"
echo -e "   Teste o chat selecionando 'Gemini 2.5 Pro'\n"

echo -e "${GREEN}✅ Testes concluídos${NC}\n"

