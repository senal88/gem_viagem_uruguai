#!/bin/bash

# Script para Obter Todas as API Keys
# GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔑 Guia para Obter Todas as API Keys${NC}\n"

echo -e "${YELLOW}📋 API Keys Necessárias:${NC}\n"

echo -e "${GREEN}1. Google Maps API Key${NC}"
echo -e "   URL: ${BLUE}https://console.cloud.google.com/${NC}"
echo -e "   Tempo: ~5 minutos"
echo -e "   Custo: Grátis (\$200 créditos/mês)"
echo -e "   Passos:"
echo -e "   1. Criar projeto"
echo -e "   2. Ativar APIs (Maps JavaScript, Directions, Geocoding)"
echo -e "   3. Criar chave de API"
echo -e "   4. Configurar restrições\n"

echo -e "${GREEN}2. OpenWeather API Key${NC}"
echo -e "   URL: ${BLUE}https://openweathermap.org/api${NC}"
echo -e "   Tempo: ~3 minutos"
echo -e "   Custo: Grátis (60 req/min)"
echo -e "   Passos:"
echo -e "   1. Criar conta"
echo -e "   2. Confirmar email"
echo -e "   3. Copiar API Key do dashboard\n"

echo -e "${GREEN}3. ExchangeRate API Key${NC}"
echo -e "   URL: ${BLUE}https://www.exchangerate-api.com/${NC}"
echo -e "   Tempo: ~2 minutos"
echo -e "   Custo: Grátis (1.500 req/mês)"
echo -e "   Passos:"
echo -e "   1. Criar conta"
echo -e "   2. Confirmar email"
echo -e "   3. Copiar API Key do dashboard\n"

echo -e "${GREEN}4. Google AI Studio (Gemini)${NC}"
echo -e "   URL: ${BLUE}https://aistudio.google.com/${NC}"
echo -e "   Status: ${YELLOW}✅ Já configurada${NC}"
echo -e "   Chave atual: AIzaSyD7BUB4hBU...2_OCs\n"

echo -e "${GREEN}5. OpenAI API Key${NC}"
echo -e "   URL: ${BLUE}https://platform.openai.com/${NC}"
echo -e "   Tempo: ~5 minutos"
echo -e "   Custo: Pago"
echo -e "   Passos:"
echo -e "   1. Criar conta"
echo -e "   2. Adicionar método de pagamento"
echo -e "   3. Criar API Key\n"

echo -e "${GREEN}6. Anthropic API Key${NC}"
echo -e "   URL: ${BLUE}https://console.anthropic.com/${NC}"
echo -e "   Tempo: ~5 minutos"
echo -e "   Custo: Pago"
echo -e "   Passos:"
echo -e "   1. Criar conta"
echo -e "   2. Adicionar créditos"
echo -e "   3. Criar API Key\n"

echo -e "${BLUE}📖 Guia Completo:${NC}"
echo -e "   Veja: ${GREEN}07_INTEGRACOES/GUIA_COMPLETO_API_KEYS.md${NC}\n"

echo -e "${YELLOW}⚡ Abrir Links Automaticamente?${NC}"
echo -e "   Digite 's' para abrir todos os links no navegador\n"

read -p "Abrir links? (s/n): " resposta

if [ "$resposta" = "s" ] || [ "$resposta" = "S" ]; then
    echo -e "\n${BLUE}Abrindo links...${NC}\n"

    # Detectar sistema operacional
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        open "https://console.cloud.google.com/"
        sleep 1
        open "https://openweathermap.org/api"
        sleep 1
        open "https://www.exchangerate-api.com/"
        sleep 1
        open "https://aistudio.google.com/"
        sleep 1
        open "https://platform.openai.com/"
        sleep 1
        open "https://console.anthropic.com/"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        xdg-open "https://console.cloud.google.com/" 2>/dev/null &
        sleep 1
        xdg-open "https://openweathermap.org/api" 2>/dev/null &
        sleep 1
        xdg-open "https://www.exchangerate-api.com/" 2>/dev/null &
        sleep 1
        xdg-open "https://aistudio.google.com/" 2>/dev/null &
        sleep 1
        xdg-open "https://platform.openai.com/" 2>/dev/null &
        sleep 1
        xdg-open "https://console.anthropic.com/" 2>/dev/null &
    fi

    echo -e "${GREEN}✅ Links abertos!${NC}\n"
fi

echo -e "${BLUE}📝 Após obter as chaves, configure no .env:${NC}\n"
echo -e "GOOGLE_MAPS_API_KEY=sua_chave"
echo -e "OPENWEATHER_API_KEY=sua_chave"
echo -e "EXCHANGERATE_API_KEY=sua_chave"
echo -e "OPENAI_API_KEY=sua_chave"
echo -e "ANTHROPIC_API_KEY=sua_chave\n"

echo -e "${YELLOW}💡 Dica:${NC}"
echo -e "   Use o guia completo para instruções detalhadas passo a passo!"

