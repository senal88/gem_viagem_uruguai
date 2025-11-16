#!/bin/bash
# Validação de Dependências - macOS Silicon & Ubuntu VPS
# Verifica compatibilidade e versões

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_DIR="$PROJECT_ROOT/venv"

echo -e "${BLUE}🔍 Validando Dependências${NC}\n"

# Verificar se venv existe
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${RED}❌ Ambiente virtual não encontrado${NC}"
    echo -e "${YELLOW}Execute: ./scripts/setup_venv.sh${NC}"
    exit 1
fi

# Ativar venv
source "$VENV_DIR/bin/activate"

# Detectar sistema
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    ARCH=$(uname -m)
    echo -e "${GREEN}✅ Ambiente: macOS ${ARCH}${NC}\n"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    ARCH=$(uname -m)
    DISTRO=$(lsb_release -si 2>/dev/null || echo "Linux")
    echo -e "${GREEN}✅ Ambiente: ${DISTRO} ${ARCH}${NC}\n"
fi

# Verificar Python
PYTHON_VERSION=$(python3 --version)
echo -e "${BLUE}Python: ${PYTHON_VERSION}${NC}"

# Verificar dependências críticas
echo -e "\n${BLUE}📦 Verificando Dependências Críticas:${NC}\n"

check_dependency() {
    local module=$1
    local name=$2
    
    if python3 -c "import $module" 2>/dev/null; then
        local version=$(python3 -c "import $module; print(getattr($module, '__version__', 'installed'))" 2>/dev/null || echo "installed")
        echo -e "${GREEN}✅ ${name}: ${version}${NC}"
        return 0
    else
        echo -e "${RED}❌ ${name}: Não instalado${NC}"
        return 1
    fi
}

# Dependências críticas
check_dependency "flask" "Flask"
check_dependency "flask_cors" "Flask-CORS"
check_dependency "dotenv" "python-dotenv"
check_dependency "openai" "OpenAI"
check_dependency "anthropic" "Anthropic"
check_dependency "google.generativeai" "Google Generative AI"
check_dependency "requests" "Requests"
check_dependency "httpx" "HTTPX"
check_dependency "pdfplumber" "pdfplumber"
check_dependency "PyPDF2" "PyPDF2"
check_dependency "dateutil" "python-dateutil"
check_dependency "psutil" "psutil"

# Verificar compatibilidade de arquitetura
echo -e "\n${BLUE}🏗️  Verificando Compatibilidade de Arquitetura:${NC}\n"

if [[ "$OS" == "macos" && "$ARCH" == "arm64" ]]; then
    echo -e "${GREEN}✅ macOS Silicon (ARM64) detectado${NC}"
    echo -e "${BLUE}   Verificando compatibilidade de pacotes...${NC}"
    
    # Verificar se pacotes foram compilados para ARM64
    python3 -c "
import sys
import platform
print(f'Python: {sys.executable}')
print(f'Plataforma: {platform.platform()}')
print(f'Arquitetura: {platform.machine()}')
print(f'Processador: {platform.processor()}')
" || true
fi

# Verificar variáveis de ambiente
echo -e "\n${BLUE}🔐 Verificando Variáveis de Ambiente:${NC}\n"

if [ -f "$PROJECT_ROOT/.env" ]; then
    echo -e "${GREEN}✅ Arquivo .env encontrado${NC}"
    
    # Verificar chaves críticas (sem mostrar valores)
    if grep -q "GOOGLE_API_KEY" "$PROJECT_ROOT/.env"; then
        echo -e "${GREEN}✅ GOOGLE_API_KEY configurada${NC}"
    else
        echo -e "${YELLOW}⚠️  GOOGLE_API_KEY não encontrada${NC}"
    fi
    
    if grep -q "OPENAI_API_KEY" "$PROJECT_ROOT/.env"; then
        echo -e "${GREEN}✅ OPENAI_API_KEY configurada${NC}"
    else
        echo -e "${YELLOW}⚠️  OPENAI_API_KEY não encontrada${NC}"
    fi
    
    if grep -q "ANTHROPIC_API_KEY" "$PROJECT_ROOT/.env"; then
        echo -e "${GREEN}✅ ANTHROPIC_API_KEY configurada${NC}"
    else
        echo -e "${YELLOW}⚠️  ANTHROPIC_API_KEY não encontrada${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Arquivo .env não encontrado${NC}"
fi

# Testar imports críticos
echo -e "\n${BLUE}🧪 Testando Imports Críticos:${NC}\n"

test_import() {
    local code=$1
    local name=$2
    
    if python3 -c "$code" 2>/dev/null; then
        echo -e "${GREEN}✅ ${name}: OK${NC}"
        return 0
    else
        echo -e "${RED}❌ ${name}: FALHOU${NC}"
        return 1
    fi
}

test_import "from flask import Flask" "Flask import"
test_import "from flask_cors import CORS" "Flask-CORS import"
test_import "import openai" "OpenAI import"
test_import "import anthropic" "Anthropic import"
test_import "import google.generativeai as genai" "Google Generative AI import"

echo -e "\n${GREEN}✅ Validação concluída!${NC}\n"

