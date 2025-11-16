#!/bin/bash
# Script para regenerar e atualizar Google API Key automaticamente
# Uso: ./scripts/regenerar_google_api_key.sh [nova_chave]

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔐 Regeneração de Google API Key${NC}\n"

# Verificar se nova chave foi fornecida
if [ -z "$1" ]; then
    echo -e "${YELLOW}⚠️  Nenhuma chave fornecida${NC}"
    echo -e "\n${BLUE}📋 INSTRUÇÕES:${NC}"
    echo -e "1. Acesse: ${GREEN}https://console.cloud.google.com/apis/credentials?project=gcp-ai-setup-24410${NC}"
    echo -e "2. Localize a chave antiga: ${RED}AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs${NC}"
    echo -e "3. Clique em 'Editar' → 'Regenerar chave'"
    echo -e "4. Copie a nova chave"
    echo -e "5. Execute: ${GREEN}./scripts/regenerar_google_api_key.sh NOVA_CHAVE_AQUI${NC}\n"
    exit 1
fi

NOVA_CHAVE="$1"

# Validar formato da chave (AIzaSy seguido de 33 caracteres = 39 total, ou AQ.)
if [[ ! "$NOVA_CHAVE" =~ ^AIzaSy[A-Za-z0-9_-]{33}$ ]] && [[ ! "$NOVA_CHAVE" =~ ^AQ\.[A-Za-z0-9_-]+$ ]]; then
    echo -e "${RED}❌ Formato de chave inválido${NC}"
    echo -e "Chave recebida: ${NOVA_CHAVE:0:20}... (${#NOVA_CHAVE} caracteres)"
    echo -e "Formato esperado: AIzaSy... (39 caracteres) ou AQ...."
    exit 1
fi

echo -e "${GREEN}✅ Chave válida detectada${NC}\n"

# Atualizar .env local
ENV_LOCAL="$HOME/gem_viagem_uruguai/.env"
if [ -f "$ENV_LOCAL" ]; then
    echo -e "${BLUE}📝 Atualizando .env local...${NC}"
    
    # Backup (sem extensão .bak para evitar commit acidental)
    cp "$ENV_LOCAL" "${ENV_LOCAL}.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Remover linha antiga se existir
    sed -i '' '/^GOOGLE_API_KEY=/d' "$ENV_LOCAL" 2>/dev/null || sed -i '/^GOOGLE_API_KEY=/d' "$ENV_LOCAL"

    # Adicionar nova chave
    echo "GOOGLE_API_KEY=$NOVA_CHAVE" >> "$ENV_LOCAL"

    echo -e "${GREEN}✅ .env local atualizado${NC}"
else
    echo -e "${YELLOW}⚠️  Arquivo .env não encontrado em $ENV_LOCAL${NC}"
    echo -e "${BLUE}📝 Criando novo arquivo .env...${NC}"
    echo "GOOGLE_API_KEY=$NOVA_CHAVE" > "$ENV_LOCAL"
    echo -e "${GREEN}✅ Arquivo .env criado${NC}"
fi

# Atualizar .env no VPS
echo -e "\n${BLUE}📡 Atualizando VPS...${NC}"
VPS_ENV="/opt/gem_viagem_uruguai/06_DASHBOARD/.env"

ssh root@147.79.81.59 << EOF
    if [ -f "$VPS_ENV" ]; then
        # Backup
        cp "$VPS_ENV" "$VPS_ENV.bak.\$(date +%Y%m%d_%H%M%S)"

        # Remover linha antiga
        sed -i '/^GOOGLE_API_KEY=/d' "$VPS_ENV"

        # Adicionar nova chave
        echo "GOOGLE_API_KEY=$NOVA_CHAVE" >> "$VPS_ENV"

        echo "✅ .env no VPS atualizado"
    else
        echo "⚠️  Arquivo .env não encontrado no VPS"
        echo "GOOGLE_API_KEY=$NOVA_CHAVE" > "$VPS_ENV"
        echo "✅ Arquivo .env criado no VPS"
    fi

    # Reiniciar serviço
    systemctl restart gemexpert
    sleep 2

    if systemctl is-active --quiet gemexpert; then
        echo "✅ Serviço gemexpert reiniciado com sucesso"
    else
        echo "❌ Erro ao reiniciar serviço"
        systemctl status gemexpert
    fi
EOF

echo -e "\n${GREEN}✅ Processo concluído!${NC}"
echo -e "\n${BLUE}📋 Próximos passos:${NC}"
echo -e "1. Configure restrições na nova chave no Google Cloud Console"
echo -e "2. Teste o dashboard: ${GREEN}http://senamfo.com.br:8081/gem/${NC}"
echo -e "3. Teste o chat com Gemini no dashboard\n"

