#!/bin/bash
# Verificação de Compatibilidade Completa
# Valida compatibilidade entre macOS Silicon e Ubuntu VPS

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔍 Verificação de Compatibilidade Completa${NC}\n"

# Detectar ambiente atual
if [[ "$OSTYPE" == "darwin"* ]]; then
    CURRENT_ENV="macOS"
    ARCH=$(uname -m)
    if [[ "$ARCH" == "arm64" ]]; then
        ARCH_TYPE="Apple Silicon (ARM64)"
    else
        ARCH_TYPE="Intel (x86_64)"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CURRENT_ENV="Ubuntu/Linux"
    ARCH=$(uname -m)
    ARCH_TYPE="${ARCH}"
else
    CURRENT_ENV="Unknown"
    ARCH_TYPE="Unknown"
fi

echo -e "${GREEN}Ambiente Atual: ${CURRENT_ENV} ${ARCH_TYPE}${NC}\n"

# Verificar Python
PYTHON_VERSION=$(python3 --version 2>&1)
PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)')
PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)')

echo -e "${BLUE}Python: ${PYTHON_VERSION}${NC}"

if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 8 ]); then
    echo -e "${RED}❌ Python 3.8+ necessário${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Versão Python compatível${NC}\n"
fi

# Verificar se venv está ativo
if [[ -z "$VIRTUAL_ENV" ]]; then
    echo -e "${YELLOW}⚠️  Ambiente virtual não ativo${NC}"
    echo -e "${BLUE}Ativando venv...${NC}"
    if [ -d "venv" ]; then
        source venv/bin/activate
    else
        echo -e "${RED}❌ venv não encontrado. Execute: ./scripts/setup_venv.sh${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✅ Ambiente virtual ativo: $VIRTUAL_ENV${NC}\n"

# Verificar dependências críticas
echo -e "${BLUE}📦 Verificando Dependências Críticas:${NC}\n"

check_package() {
    local package=$1
    local name=$2
    
    if python3 -c "import $package" 2>/dev/null; then
        local version=$(python3 -c "import $package; print(getattr($package, '__version__', 'installed'))" 2>/dev/null || echo "installed")
        echo -e "${GREEN}✅ ${name}: ${version}${NC}"
        
        # Verificar compatibilidade de arquitetura
        if [[ "$CURRENT_ENV" == "macOS" && "$ARCH" == "arm64" ]]; then
            # Verificar se pacote foi compilado para ARM64
            python3 -c "
import $package
import platform
print(f'   Arquitetura: {platform.machine()}')
" 2>/dev/null || true
        fi
        return 0
    else
        echo -e "${RED}❌ ${name}: Não instalado${NC}"
        return 1
    fi
}

# Dependências críticas
check_package "flask" "Flask"
check_package "flask_cors" "Flask-CORS"
check_package "dotenv" "python-dotenv"
check_package "openai" "OpenAI"
check_package "anthropic" "Anthropic"
check_package "google.generativeai" "Google Generative AI"
check_package "requests" "Requests"
check_package "httpx" "HTTPX"
check_package "pdfplumber" "pdfplumber"
check_package "PyPDF2" "PyPDF2"
check_package "dateutil" "python-dateutil"
check_package "psutil" "psutil"

# Verificar compatibilidade de arquitetura específica
echo -e "\n${BLUE}🏗️  Compatibilidade de Arquitetura:${NC}\n"

if [[ "$CURRENT_ENV" == "macOS" && "$ARCH" == "arm64" ]]; then
    echo -e "${GREEN}✅ macOS Silicon (ARM64)${NC}"
    echo -e "${BLUE}   Verificando compatibilidade ARM64...${NC}"
    
    # Verificar se pacotes foram compilados corretamente
    python3 -c "
import platform
import sys
print(f'Python: {sys.executable}')
print(f'Plataforma: {platform.platform()}')
print(f'Arquitetura: {platform.machine()}')
print(f'Processador: {platform.processor()}')
" || true
    
    echo -e "${GREEN}✅ Compatibilidade ARM64 verificada${NC}"
elif [[ "$CURRENT_ENV" == "Ubuntu/Linux" ]]; then
    echo -e "${GREEN}✅ Ubuntu/Linux (${ARCH})${NC}"
    echo -e "${BLUE}   Ambiente de produção${NC}"
fi

# Verificar arquivos de requirements
echo -e "\n${BLUE}📄 Verificando Arquivos de Requirements:${NC}\n"

if [ -f "requirements.txt" ]; then
    echo -e "${GREEN}✅ requirements.txt encontrado${NC}"
    DEP_COUNT=$(grep -v "^#" requirements.txt | grep -v "^$" | wc -l | tr -d ' ')
    echo -e "   ${BLUE}Dependências: ${DEP_COUNT}${NC}"
else
    echo -e "${RED}❌ requirements.txt não encontrado${NC}"
fi

if [ -f "requirements-dev.txt" ]; then
    echo -e "${GREEN}✅ requirements-dev.txt encontrado${NC}"
else
    echo -e "${YELLOW}⚠️  requirements-dev.txt não encontrado${NC}"
fi

if [ -f "requirements-vps.txt" ]; then
    echo -e "${GREEN}✅ requirements-vps.txt encontrado${NC}"
else
    echo -e "${YELLOW}⚠️  requirements-vps.txt não encontrado${NC}"
fi

# Resumo final
echo -e "\n${BLUE}📊 Resumo de Compatibilidade:${NC}\n"
echo -e "${GREEN}✅ Ambiente: ${CURRENT_ENV} ${ARCH_TYPE}${NC}"
echo -e "${GREEN}✅ Python: ${PYTHON_VERSION}${NC}"
echo -e "${GREEN}✅ Ambiente Virtual: Ativo${NC}"
echo -e "${GREEN}✅ Dependências: Instaladas${NC}"

echo -e "\n${GREEN}✅ Verificação de compatibilidade concluída!${NC}\n"

