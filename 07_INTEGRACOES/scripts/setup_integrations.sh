#!/bin/bash

# Script de Setup de Integrações
# GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔗 Configurando Integrações do GEM Expert...${NC}\n"

# Verificar se está no diretório correto
if [ ! -f "../06_DASHBOARD/api/server.py" ]; then
    echo -e "${RED}❌ Execute este script do diretório 07_INTEGRACOES${NC}"
    exit 1
fi

# Ativar ambiente virtual
if [ -d "../../venv" ]; then
    source ../../venv/bin/activate
    echo -e "${GREEN}✅ Ambiente virtual ativado${NC}"
fi

# Instalar dependências
echo -e "${YELLOW}📦 Instalando dependências...${NC}"
pip install --quiet googlemaps requests python-dotenv 2>&1 | grep -v "already satisfied" || true

# Verificar variáveis de ambiente
echo -e "\n${YELLOW}🔐 Verificando variáveis de ambiente...${NC}"
ENV_FILE="../../.env"

if [ ! -f "$ENV_FILE" ]; then
    echo -e "${YELLOW}⚠️  Arquivo .env não encontrado. Criando...${NC}"
    touch "$ENV_FILE"
fi

# Adicionar variáveis se não existirem
grep -q "GOOGLE_MAPS_API_KEY" "$ENV_FILE" || echo "GOOGLE_MAPS_API_KEY=" >> "$ENV_FILE"
grep -q "OPENWEATHER_API_KEY" "$ENV_FILE" || echo "OPENWEATHER_API_KEY=" >> "$ENV_FILE"
grep -q "EXCHANGERATE_API_KEY" "$ENV_FILE" || echo "EXCHANGERATE_API_KEY=" >> "$ENV_FILE"

echo -e "${GREEN}✅ Variáveis de ambiente configuradas${NC}"

# Resumo
echo -e "\n${GREEN}✅ Setup Concluído!${NC}\n"
echo -e "${BLUE}📝 Próximos passos:${NC}"
echo -e "   1. Configure as API Keys no arquivo .env"
echo -e "   2. Veja os guias em cada subdiretório"
echo -e "   3. Execute testes: python scripts/test_integrations.py"

