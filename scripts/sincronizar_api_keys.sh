#!/bin/bash

# Script para Sincronizar API Keys entre Local e VPS
# GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

VPS_IP="147.79.81.59"
VPS_USER="root"
LOCAL_ENV="$HOME/gem_viagem_uruguai/.env"
VPS_ENV="/opt/gem_viagem_uruguai/06_DASHBOARD/.env"

echo -e "${BLUE}🔄 Sincronizando API Keys para VPS...${NC}\n"

# Verificar se arquivo local existe
if [ ! -f "$LOCAL_ENV" ]; then
    echo -e "${RED}❌ Arquivo .env local não encontrado${NC}"
    exit 1
fi

# Ler API keys do arquivo local
echo -e "${YELLOW}📖 Lendo API Keys do arquivo local...${NC}"

OPENAI_KEY=$(grep "^OPENAI_API_KEY=" "$LOCAL_ENV" | cut -d'=' -f2 | tr -d ' ')
ANTHROPIC_KEY=$(grep "^ANTHROPIC_API_KEY=" "$LOCAL_ENV" | cut -d'=' -f2 | tr -d ' ')
GOOGLE_KEY=$(grep "^GOOGLE_API_KEY=" "$LOCAL_ENV" | cut -d'=' -f2 | tr -d ' ')
GOOGLE_MAPS_KEY=$(grep "^GOOGLE_MAPS_API_KEY=" "$LOCAL_ENV" | cut -d'=' -f2 | tr -d ' ')
OPENWEATHER_KEY=$(grep "^OPENWEATHER_API_KEY=" "$LOCAL_ENV" | cut -d'=' -f2 | tr -d ' ')
EXCHANGERATE_KEY=$(grep "^EXCHANGERATE_API_KEY=" "$LOCAL_ENV" | cut -d'=' -f2 | tr -d ' ')

# Sincronizar com VPS
echo -e "${YELLOW}📡 Sincronizando com VPS...${NC}"

ssh ${VPS_USER}@${VPS_IP} << EOF
    # Criar arquivo .env se não existir
    touch ${VPS_ENV}
    
    # Atualizar ou adicionar cada chave
    if [ -n "$OPENAI_KEY" ]; then
        sed -i '/^OPENAI_API_KEY=/d' ${VPS_ENV}
        echo "OPENAI_API_KEY=$OPENAI_KEY" >> ${VPS_ENV}
        echo "✅ OpenAI API Key sincronizada"
    fi
    
    if [ -n "$ANTHROPIC_KEY" ]; then
        sed -i '/^ANTHROPIC_API_KEY=/d' ${VPS_ENV}
        echo "ANTHROPIC_API_KEY=$ANTHROPIC_KEY" >> ${VPS_ENV}
        echo "✅ Anthropic API Key sincronizada"
    fi
    
    if [ -n "$GOOGLE_KEY" ]; then
        sed -i '/^GOOGLE_API_KEY=/d' ${VPS_ENV}
        echo "GOOGLE_API_KEY=$GOOGLE_KEY" >> ${VPS_ENV}
        echo "✅ Google API Key sincronizada"
    fi
    
    if [ -n "$GOOGLE_MAPS_KEY" ]; then
        sed -i '/^GOOGLE_MAPS_API_KEY=/d' ${VPS_ENV}
        echo "GOOGLE_MAPS_API_KEY=$GOOGLE_MAPS_KEY" >> ${VPS_ENV}
        echo "✅ Google Maps API Key sincronizada"
    fi
    
    if [ -n "$OPENWEATHER_KEY" ]; then
        sed -i '/^OPENWEATHER_API_KEY=/d' ${VPS_ENV}
        echo "OPENWEATHER_API_KEY=$OPENWEATHER_KEY" >> ${VPS_ENV}
        echo "✅ OpenWeather API Key sincronizada"
    fi
    
    if [ -n "$EXCHANGERATE_KEY" ]; then
        sed -i '/^EXCHANGERATE_API_KEY=/d' ${VPS_ENV}
        echo "EXCHANGERATE_API_KEY=$EXCHANGERATE_KEY" >> ${VPS_ENV}
        echo "✅ ExchangeRate API Key sincronizada"
    fi
    
    # Remover linhas duplicadas
    sort -u ${VPS_ENV} -o ${VPS_ENV}.tmp
    mv ${VPS_ENV}.tmp ${VPS_ENV}
    
    echo ""
    echo "📊 Resumo das chaves na VPS:"
    grep -E "API_KEY|_KEY" ${VPS_ENV} | grep -v "^#" | cut -d'=' -f1
EOF

# Reiniciar serviço
echo -e "\n${YELLOW}🔄 Reiniciando serviço...${NC}"
ssh ${VPS_USER}@${VPS_IP} "systemctl restart gemexpert && sleep 2 && systemctl is-active gemexpert && echo '✅ Serviço reiniciado e ativo' || echo '⚠️ Serviço pode ter problemas'"

echo -e "\n${GREEN}✅ Sincronização Concluída!${NC}\n"
echo -e "${BLUE}📝 Próximos passos:${NC}"
echo -e "   1. Teste o chat no dashboard"
echo -e "   2. Verifique se os erros foram resolvidos"
echo -e "   3. Configure outras API Keys se necessário\n"

