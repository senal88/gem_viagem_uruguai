#!/bin/bash

# Script de Inicialização Rápida do Dashboard
# GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Iniciando Dashboard GEM Expert...${NC}\n"

# Verificar se estamos no diretório correto
if [ ! -f "api/server.py" ]; then
    echo -e "${YELLOW}⚠️  Execute este script do diretório 06_DASHBOARD${NC}"
    exit 1
fi

# Verificar Python
if ! command -v python3 &> /dev/null; then
    echo -e "${YELLOW}❌ Python3 não encontrado${NC}"
    exit 1
fi

# Verificar dependências
echo -e "${YELLOW}📦 Verificando dependências...${NC}"
python3 -c "import flask" 2>/dev/null || {
    echo -e "${YELLOW}Instalando dependências...${NC}"
    pip3 install --user flask flask-cors python-dotenv openai anthropic google-generativeai
}

# Obter IP local
IP=$(ipconfig getifaddr en0 2>/dev/null || ifconfig | grep "inet " | grep -v 127.0.0.1 | head -1 | awk '{print $2}')

if [ -z "$IP" ]; then
    IP="localhost"
fi

# Verificar variáveis de ambiente
if [ ! -f "../.env" ]; then
    echo -e "${YELLOW}⚠️  Arquivo .env não encontrado na raiz do projeto${NC}"
    echo -e "${YELLOW}   Configure as API keys antes de continuar${NC}\n"
fi

echo -e "${GREEN}✅ Tudo pronto!${NC}\n"
echo -e "${BLUE}📱 Acesse no iPhone:${NC}"
echo -e "   ${GREEN}http://${IP}:5000${NC}\n"
echo -e "${BLUE}💻 Ou localmente:${NC}"
echo -e "   ${GREEN}http://localhost:5000${NC}\n"
echo -e "${YELLOW}Pressione Ctrl+C para parar o servidor${NC}\n"

# Executar servidor
python3 api/server.py

