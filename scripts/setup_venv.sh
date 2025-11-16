#!/bin/bash
# Setup Virtual Environment - macOS Silicon & Ubuntu Compatible
# Cria ambiente virtual isolado e instala dependências

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_DIR="$PROJECT_ROOT/venv"
PYTHON_VERSION="python3"

echo -e "${BLUE}🔧 Configurando Ambiente Virtual${NC}\n"

# Detectar sistema operacional
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    ARCH=$(uname -m)
    if [[ "$ARCH" == "arm64" ]]; then
        ARCH_TYPE="Apple Silicon"
    else
        ARCH_TYPE="Intel"
    fi
    echo -e "${GREEN}✅ Sistema: macOS ${ARCH_TYPE}${NC}"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    ARCH=$(uname -m)
    DISTRO=$(lsb_release -si 2>/dev/null || echo "Linux")
    echo -e "${GREEN}✅ Sistema: ${DISTRO} ${ARCH}${NC}"
else
    OS="unknown"
    echo -e "${YELLOW}⚠️  Sistema não identificado: $OSTYPE${NC}"
fi

# Verificar Python
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python 3 não encontrado${NC}"
    exit 1
fi

PYTHON_VERSION_FULL=$(python3 --version)
echo -e "${GREEN}✅ ${PYTHON_VERSION_FULL}${NC}\n"

# Verificar versão mínima (3.8+)
PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)')
PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)')

if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 8 ]); then
    echo -e "${RED}❌ Python 3.8+ necessário. Versão atual: ${PYTHON_VERSION_FULL}${NC}"
    exit 1
fi

# Remover venv existente se solicitado
if [ -d "$VENV_DIR" ]; then
    echo -e "${YELLOW}⚠️  Ambiente virtual já existe em: $VENV_DIR${NC}"
    read -p "Remover e recriar? (s/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        echo -e "${BLUE}🗑️  Removendo ambiente virtual existente...${NC}"
        rm -rf "$VENV_DIR"
    else
        echo -e "${GREEN}✅ Usando ambiente virtual existente${NC}\n"
        exit 0
    fi
fi

# Criar ambiente virtual
echo -e "${BLUE}📦 Criando ambiente virtual...${NC}"
python3 -m venv "$VENV_DIR"

# Ativar ambiente virtual
echo -e "${BLUE}🔌 Ativando ambiente virtual...${NC}"
source "$VENV_DIR/bin/activate"

# Atualizar pip
echo -e "${BLUE}⬆️  Atualizando pip...${NC}"
pip install --upgrade pip setuptools wheel

# Instalar dependências base
echo -e "${BLUE}📥 Instalando dependências base...${NC}"
pip install -r "$PROJECT_ROOT/requirements.txt"

# Instalar dependências de desenvolvimento se macOS
if [[ "$OS" == "macos" ]]; then
    if [ -f "$PROJECT_ROOT/requirements-dev.txt" ]; then
        echo -e "${BLUE}📥 Instalando dependências de desenvolvimento...${NC}"
        pip install -r "$PROJECT_ROOT/requirements-dev.txt"
    fi
fi

# Verificar instalação
echo -e "\n${BLUE}🔍 Verificando instalação...${NC}"
python3 -c "import flask; print(f'✅ Flask {flask.__version__}')" || echo "❌ Flask não instalado"
python3 -c "import openai; print(f'✅ OpenAI {openai.__version__}')" || echo "⚠️  OpenAI não instalado"
python3 -c "import anthropic; print(f'✅ Anthropic {anthropic.__version__}')" || echo "⚠️  Anthropic não instalado"
python3 -c "import google.generativeai; print(f'✅ Google Generative AI')" || echo "⚠️  Google Generative AI não instalado"
python3 -c "import pdfplumber; print(f'✅ pdfplumber {pdfplumber.__version__}')" || echo "⚠️  pdfplumber não instalado"

echo -e "\n${GREEN}✅ Ambiente virtual configurado com sucesso!${NC}\n"
echo -e "${BLUE}📝 Para ativar o ambiente virtual:${NC}"
echo -e "   ${YELLOW}source venv/bin/activate${NC}\n"
echo -e "${BLUE}📝 Para desativar:${NC}"
echo -e "   ${YELLOW}deactivate${NC}\n"

