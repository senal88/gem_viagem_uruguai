#!/bin/bash

# Script de Setup Completo do Repositório GEM Expert
# Autor: Luiz Fernando Sena
# Data: 2025-11-16

set -e

echo "🚀 Configurando repositório GEM Expert..."

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar se estamos no diretório correto
if [ ! -f "README.md" ]; then
    echo -e "${RED}❌ Erro: Execute este script na raiz do repositório${NC}"
    exit 1
fi

# 1. Configurar Git
echo -e "${YELLOW}📝 Configurando Git...${NC}"
git config user.name "Luiz Fernando Sena"
git config user.email "luizfernandomoreirasena@gmail.com"

# 2. Criar .gitignore se não existir
if [ ! -f ".gitignore" ]; then
    echo -e "${YELLOW}📝 Criando .gitignore...${NC}"
    cat > .gitignore << EOF
# Variáveis de ambiente
.env
.env.local
.env.*.local

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
env/
ENV/

# Node
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporários
tmp/
temp/
EOF
fi

# 3. Criar .env.example se não existir
if [ ! -f ".env.example" ]; then
    echo -e "${YELLOW}📝 Criando .env.example...${NC}"
    cat > .env.example << EOF
# GitHub
GITHUB_TOKEN=seu_token_aqui
GITHUB_USERNAME=senal88
GITHUB_REPO=gem_viagem_uruguai
GITHUB_OWNER=senal88

# OpenAI
OPENAI_API_KEY=sua_openai_api_key_aqui
OPENAI_MODEL=gpt-4-turbo-preview

# Anthropic (Claude)
ANTHROPIC_API_KEY=sua_anthropic_api_key_aqui
ANTHROPIC_MODEL=claude-3-5-sonnet-20241022

# Google (Gemini)
GOOGLE_API_KEY=sua_google_api_key_aqui
GOOGLE_MODEL=gemini-2.5-pro

# Busca Web
GOOGLE_CSE_ID=seu_google_cse_id_aqui
TAVILY_API_KEY=sua_tavily_api_key_aqui
SEARCH_PROVIDER=duckduckgo

# Configurações
NODE_ENV=development
LOG_LEVEL=info
EOF
fi

# 4. Criar .env se não existir (com valores padrão)
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}📝 Criando .env...${NC}"
    cp .env.example .env
    echo -e "${YELLOW}⚠️  Configure as variáveis de ambiente no arquivo .env${NC}"
fi

# 5. Verificar dependências
echo -e "${YELLOW}🔍 Verificando dependências...${NC}"

# Node.js
if command -v node &> /dev/null; then
    echo -e "${GREEN}✅ Node.js: $(node --version)${NC}"
else
    echo -e "${RED}❌ Node.js não encontrado${NC}"
fi

# Git
if command -v git &> /dev/null; then
    echo -e "${GREEN}✅ Git: $(git --version)${NC}"
else
    echo -e "${RED}❌ Git não encontrado${NC}"
fi

# Python
if command -v python3 &> /dev/null; then
    echo -e "${GREEN}✅ Python: $(python3 --version)${NC}"
else
    echo -e "${RED}❌ Python3 não encontrado${NC}"
fi

# 6. Instalar dependências Python (se pip disponível)
if command -v pip3 &> /dev/null; then
    echo -e "${YELLOW}📦 Instalando dependências Python...${NC}"
    pip3 install --quiet openai anthropic google-generativeai python-dotenv || true
    echo -e "${GREEN}✅ Dependências Python instaladas${NC}"
fi

# 7. Testar MCP Servers
echo -e "${YELLOW}🧪 Testando MCP Servers...${NC}"
if command -v npx &> /dev/null; then
    npx -y @modelcontextprotocol/server-filesystem --help > /dev/null 2>&1 && echo -e "${GREEN}✅ MCP Filesystem OK${NC}" || echo -e "${YELLOW}⚠️  MCP Filesystem não disponível${NC}"
    npx -y @modelcontextprotocol/server-web-search --help > /dev/null 2>&1 && echo -e "${GREEN}✅ MCP Web Search OK${NC}" || echo -e "${YELLOW}⚠️  MCP Web Search não disponível${NC}"
fi

# 8. Configurar remote do GitHub (se não configurado)
if ! git remote get-url origin &> /dev/null; then
    echo -e "${YELLOW}📝 Configurando remote GitHub...${NC}"
    git remote add origin https://github.com/senal88/gem_viagem_uruguai.git || true
fi

# 9. Verificar status do repositório
echo -e "${YELLOW}📊 Status do repositório:${NC}"
git status --short

echo ""
echo -e "${GREEN}✅ Setup concluído!${NC}"
echo ""
echo "Próximos passos:"
echo "1. Configure as variáveis de ambiente no arquivo .env"
echo "2. Revise as configurações de integração"
echo "3. Execute os testes de validação"

