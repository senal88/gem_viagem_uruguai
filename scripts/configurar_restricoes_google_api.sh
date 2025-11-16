#!/bin/bash
# Script para configurar restrições na Google API Key
# Abre o Google Cloud Console com as configurações corretas

BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${BLUE}🔐 Configuração de Restrições - Google API Key${NC}\n"

echo -e "${GREEN}📋 INSTRUÇÕES PARA CONFIGURAR RESTRIÇÕES:${NC}\n"

echo -e "1. ${BLUE}Acesse o Google Cloud Console:${NC}"
echo -e "   https://console.cloud.google.com/apis/credentials?project=gcp-ai-setup-24410\n"

echo -e "2. ${BLUE}Clique na chave de API que você regenerou${NC}\n"

echo -e "3. ${BLUE}Configure Restrições de Aplicativo:${NC}"
echo -e "   Selecione: ${GREEN}'Endereços IP'${NC}"
echo -e "   Adicione:"
echo -e "   - ${GREEN}147.79.81.59/32${NC} (IP do VPS)"
echo -e "   - ${GREEN}0.0.0.0/0${NC} (se quiser permitir de qualquer lugar - menos seguro)\n"

echo -e "   ${BLUE}OU${NC} selecione: ${GREEN}'HTTP referrers (websites)'${NC}"
echo -e "   Adicione:"
echo -e "   - ${GREEN}http://senamfo.com.br:8081/*${NC}"
echo -e "   - ${GREEN}https://senamfo.com.br/*${NC}"
echo -e "   - ${GREEN}http://localhost:5000/*${NC}"
echo -e "   - ${GREEN}http://127.0.0.1:5000/*${NC}\n"

echo -e "4. ${BLUE}Configure Restrições de API:${NC}"
echo -e "   Selecione: ${GREEN}'Restringir chave'${NC}"
echo -e "   Marque apenas:"
echo -e "   - ${GREEN}✅ Maps JavaScript API${NC}"
echo -e "   - ${GREEN}✅ Geocoding API${NC}"
echo -e "   - ${GREEN}✅ Directions API${NC}"
echo -e "   - ${GREEN}✅ Places API${NC} (opcional)\n"

echo -e "5. ${BLUE}Clique em 'Salvar'${NC}\n"

echo -e "${GREEN}✅ Pronto! Sua chave estará protegida.${NC}\n"

# Tentar abrir no navegador (Mac)
if [[ "$OSTYPE" == "darwin"* ]]; then
    read -p "Abrir Google Cloud Console no navegador? (s/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[SsYy]$ ]]; then
        open "https://console.cloud.google.com/apis/credentials?project=gcp-ai-setup-24410"
    fi
fi

