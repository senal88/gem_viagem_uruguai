#!/bin/bash
# Setup VPS Ubuntu - Instalação e Configuração Completa
# Para executar na VPS Ubuntu

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

PROJECT_DIR="/opt/gem_viagem_uruguai"
VENV_DIR="$PROJECT_DIR/venv"

echo -e "${BLUE}🚀 Configurando VPS Ubuntu${NC}\n"

# Verificar se é root ou tem sudo
if [ "$EUID" -ne 0 ] && ! sudo -n true 2>/dev/null; then
    echo -e "${RED}❌ Execute com sudo ou como root${NC}"
    exit 1
fi

# Atualizar sistema
echo -e "${BLUE}📦 Atualizando sistema...${NC}"
sudo apt-get update -qq
sudo apt-get upgrade -y -qq

# Instalar dependências do sistema
echo -e "${BLUE}📦 Instalando dependências do sistema...${NC}"
sudo apt-get install -y -qq \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    nginx \
    supervisor \
    git \
    curl \
    wget

# Verificar Python
PYTHON_VERSION=$(python3 --version)
echo -e "${GREEN}✅ ${PYTHON_VERSION}${NC}"

# Criar diretório do projeto se não existir
if [ ! -d "$PROJECT_DIR" ]; then
    echo -e "${BLUE}📁 Criando diretório do projeto...${NC}"
    sudo mkdir -p "$PROJECT_DIR"
    sudo chown $USER:$USER "$PROJECT_DIR"
fi

# Criar ambiente virtual
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${BLUE}📦 Criando ambiente virtual...${NC}"
    python3 -m venv "$VENV_DIR"
fi

# Ativar ambiente virtual
source "$VENV_DIR/bin/activate"

# Atualizar pip
echo -e "${BLUE}⬆️  Atualizando pip...${NC}"
pip install --upgrade pip setuptools wheel

# Instalar dependências de produção
if [ -f "$PROJECT_DIR/requirements-vps.txt" ]; then
    echo -e "${BLUE}📥 Instalando dependências de produção...${NC}"
    pip install -r "$PROJECT_DIR/requirements-vps.txt"
elif [ -f "$PROJECT_DIR/requirements.txt" ]; then
    echo -e "${BLUE}📥 Instalando dependências...${NC}"
    pip install -r "$PROJECT_DIR/requirements.txt"
fi

# Verificar instalação
echo -e "\n${BLUE}🔍 Verificando instalação...${NC}"
python3 -c "import flask; print(f'✅ Flask {flask.__version__}')" || echo "❌ Flask não instalado"
python3 -c "import gunicorn; print(f'✅ Gunicorn {gunicorn.__version__}')" || echo "⚠️  Gunicorn não instalado"

echo -e "\n${GREEN}✅ VPS configurada com sucesso!${NC}\n"

