#!/bin/bash

# Script de Deploy Automático para VPS
# GEM Expert Dashboard | senamfo.com.br (147.79.81.59)

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

VPS_IP="147.79.81.59"
VPS_DOMAIN="senamfo.com.br"
VPS_USER="${VPS_USER:-root}"
APP_DIR="/opt/gem_viagem_uruguai"
APP_PATH="$APP_DIR/06_DASHBOARD"
SERVICE_NAME="gemexpert"
NGINX_SITE="gemexpert"

echo -e "${BLUE}🚀 Deploy Automático para VPS${NC}"
echo -e "${BLUE}   Domínio: ${VPS_DOMAIN}${NC}"
echo -e "${BLUE}   IP: ${VPS_IP}${NC}\n"

# Verificar se está no diretório correto
if [ ! -f "api/server.py" ]; then
    echo -e "${RED}❌ Execute este script do diretório 06_DASHBOARD${NC}"
    exit 1
fi

# Verificar conexão SSH
echo -e "${YELLOW}📡 Verificando conexão com VPS...${NC}"
if ! ssh -o ConnectTimeout=5 ${VPS_USER}@${VPS_IP} "echo 'Conexão OK'" 2>/dev/null; then
    echo -e "${RED}❌ Não foi possível conectar à VPS${NC}"
    echo -e "${YELLOW}   Verifique:${NC}"
    echo -e "   - SSH configurado"
    echo -e "   - Chave SSH autorizada"
    echo -e "   - Firewall permitindo conexão"
    exit 1
fi

echo -e "${GREEN}✅ Conexão estabelecida${NC}\n"

# Criar diretório de aplicação
echo -e "${YELLOW}📁 Criando estrutura de diretórios...${NC}"
ssh ${VPS_USER}@${VPS_IP} "
    mkdir -p $APP_DIR
    mkdir -p /etc/nginx/sites-available
    mkdir -p /etc/nginx/sites-enabled
" 2>&1

# Clonar/Atualizar repositório
echo -e "${YELLOW}📥 Clonando/Atualizando repositório...${NC}"
ssh ${VPS_USER}@${VPS_IP} "
    if [ -d $APP_DIR/.git ]; then
        cd $APP_DIR
        git pull origin main
    else
        cd /opt
        git clone https://github.com/senal88/gem_viagem_uruguai.git
    fi
" 2>&1

# Instalar dependências do sistema
echo -e "${YELLOW}📦 Instalando dependências do sistema...${NC}"
ssh ${VPS_USER}@${VPS_IP} "
    apt update -qq
    apt install -y python3 python3-pip python3-venv nginx git 2>&1 | grep -v 'already installed'
" 2>&1

# Configurar ambiente virtual
echo -e "${YELLOW}🐍 Configurando ambiente Python...${NC}"
ssh ${VPS_USER}@${VPS_IP} "
    cd $APP_PATH
    if [ ! -d venv ]; then
        python3 -m venv venv
    fi
    source venv/bin/activate
    pip install --quiet --upgrade pip
    pip install --quiet -r requirements.txt
" 2>&1

# Verificar/criar .env
echo -e "${YELLOW}🔐 Configurando variáveis de ambiente...${NC}"
ssh ${VPS_USER}@${VPS_IP} "
    cd $APP_PATH
    if [ ! -f .env ]; then
        if [ -f ../.env.example ]; then
            cp ../.env.example .env
            echo '⚠️  Arquivo .env criado. Configure as API keys manualmente.'
        else
            echo 'OPENAI_API_KEY=' > .env
            echo 'ANTHROPIC_API_KEY=' >> .env
            echo 'GOOGLE_API_KEY=' >> .env
            echo 'FLASK_ENV=production' >> .env
            echo 'FLASK_DEBUG=False' >> .env
        fi
    fi
" 2>&1

# Criar configuração do Nginx
echo -e "${YELLOW}🌐 Configurando Nginx...${NC}"
ssh ${VPS_USER}@${VPS_IP} "cat > /etc/nginx/sites-available/${NGINX_SITE} << 'EOF'
server {
    listen 80;
    server_name ${VPS_DOMAIN} ${VPS_IP};

    # Logs
    access_log /var/log/nginx/gemexpert_access.log;
    error_log /var/log/nginx/gemexpert_error.log;

    # Aplicação
    location /gem {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;

        # WebSocket support (se necessário no futuro)
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \"upgrade\";
    }

    # Root redirect para /gem
    location = / {
        return 301 /gem;
    }

    # Static files (se necessário)
    location /gem/static {
        alias ${APP_PATH}/static;
        expires 30d;
        add_header Cache-Control \"public, immutable\";
    }
}
EOF
" 2>&1

# Habilitar site no Nginx
echo -e "${YELLOW}🔗 Habilitando site no Nginx...${NC}"
ssh ${VPS_USER}@${VPS_IP} "
    ln -sf /etc/nginx/sites-available/${NGINX_SITE} /etc/nginx/sites-enabled/
    nginx -t && systemctl reload nginx
" 2>&1

# Criar service do Systemd
echo -e "${YELLOW}⚙️  Configurando Systemd Service...${NC}"
ssh ${VPS_USER}@${VPS_IP} "cat > /etc/systemd/system/${SERVICE_NAME}.service << 'EOF'
[Unit]
Description=GEM Expert Dashboard
After=network.target

[Service]
Type=simple
User=${VPS_USER}
WorkingDirectory=${APP_PATH}
Environment=\"PATH=${APP_PATH}/venv/bin\"
ExecStart=${APP_PATH}/venv/bin/python3 ${APP_PATH}/api/server.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
" 2>&1

# Iniciar serviço
echo -e "${YELLOW}🚀 Iniciando serviço...${NC}"
ssh ${VPS_USER}@${VPS_IP} "
    systemctl daemon-reload
    systemctl enable ${SERVICE_NAME}
    systemctl restart ${SERVICE_NAME}
    sleep 2
    systemctl status ${SERVICE_NAME} --no-pager | head -10
" 2>&1

# Verificar status
echo -e "\n${YELLOW}📊 Verificando status...${NC}"
ssh ${VPS_USER}@${VPS_IP} "
    echo '=== Status do Serviço ==='
    systemctl is-active ${SERVICE_NAME} && echo '✅ Serviço ativo' || echo '❌ Serviço inativo'
    echo ''
    echo '=== Porta 5000 ==='
    netstat -tlnp | grep :5000 || echo '⚠️  Porta 5000 não está em uso'
    echo ''
    echo '=== Nginx ==='
    systemctl is-active nginx && echo '✅ Nginx ativo' || echo '❌ Nginx inativo'
" 2>&1

echo -e "\n${GREEN}✅ Deploy Concluído!${NC}\n"
echo -e "${BLUE}📱 Acesse o dashboard:${NC}"
echo -e "   ${GREEN}http://${VPS_DOMAIN}/gem${NC}"
echo -e "   ${GREEN}http://${VPS_IP}/gem${NC}\n"
echo -e "${YELLOW}Próximos passos:${NC}"
echo -e "   1. Configure as API keys em: ${APP_PATH}/.env"
echo -e "   2. Reinicie o serviço: systemctl restart ${SERVICE_NAME}"
echo -e "   3. Configure SSL: certbot --nginx -d ${VPS_DOMAIN}\n"

