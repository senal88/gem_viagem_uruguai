# 🚀 Deploy para VPS - senamfo.com.br
## GEM Expert Dashboard | IP: 147.79.81.59

---

## 📋 INFORMAÇÕES DA VPS

| Campo | Valor |
|-------|-------|
| **Domínio** | senamfo.com.br |
| **IP** | 147.79.81.59 |
| **Serviço** | Dashboard GEM Expert |
| **Porta** | 5000 (interno) / 80/443 (nginx) |

---

## 🚀 DEPLOY RÁPIDO

### Passo 1: Conectar na VPS

```bash
ssh root@147.79.81.59
# Ou
ssh root@senamfo.com.br
```

### Passo 2: Executar Script de Deploy

```bash
# No servidor VPS
cd /opt
git clone https://github.com/senal88/gem_viagem_uruguai.git
cd gem_viagem_uruguai/06_DASHBOARD
chmod +x deploy_vps.sh
./deploy_vps.sh
```

### Passo 3: Acessar

- **HTTP**: http://senamfo.com.br/gem
- **HTTPS**: https://senamfo.com.br/gem (se SSL configurado)

---

## 📦 PRÉ-REQUISITOS

### No Servidor VPS

```bash
# Atualizar sistema
apt update && apt upgrade -y

# Instalar dependências
apt install -y python3 python3-pip python3-venv nginx git

# Instalar certificado SSL (opcional)
apt install -y certbot python3-certbot-nginx
```

---

## 🔧 CONFIGURAÇÃO MANUAL

### 1. Criar Usuário (Recomendado)

```bash
# Criar usuário para aplicação
useradd -m -s /bin/bash gemexpert
su - gemexpert
```

### 2. Clonar Repositório

```bash
cd /opt
git clone https://github.com/senal88/gem_viagem_uruguai.git
cd gem_viagem_uruguai
```

### 3. Configurar Ambiente Virtual

```bash
cd 06_DASHBOARD
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 4. Configurar Variáveis de Ambiente

```bash
# Copiar .env.example para .env
cp ../.env.example .env

# Editar .env com suas chaves
nano .env
```

### 5. Configurar Nginx

```bash
# Criar configuração do nginx
sudo nano /etc/nginx/sites-available/gemexpert
```

Conteúdo (ver arquivo `nginx_config.conf`):

### 6. Habilitar Site

```bash
sudo ln -s /etc/nginx/sites-available/gemexpert /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### 7. Configurar Systemd Service

```bash
# Criar service
sudo nano /etc/systemd/system/gemexpert.service
```

Conteúdo (ver arquivo `gemexpert.service`):

### 8. Iniciar Serviço

```bash
sudo systemctl daemon-reload
sudo systemctl enable gemexpert
sudo systemctl start gemexpert
sudo systemctl status gemexpert
```

---

## 🔒 SSL/HTTPS (Opcional)

```bash
# Gerar certificado SSL
sudo certbot --nginx -d senamfo.com.br

# Renovação automática
sudo certbot renew --dry-run
```

---

## 📊 MONITORAMENTO

### Ver Logs

```bash
# Logs da aplicação
sudo journalctl -u gemexpert -f

# Logs do nginx
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Status do Serviço

```bash
sudo systemctl status gemexpert
```

### Reiniciar Serviço

```bash
sudo systemctl restart gemexpert
```

---

## 🔄 ATUALIZAÇÃO

### Atualizar Código

```bash
cd /opt/gem_viagem_uruguai
git pull origin main
cd 06_DASHBOARD
source venv/bin/activate
pip install -r requirements.txt --upgrade
sudo systemctl restart gemexpert
```

---

## ✅ CHECKLIST DE DEPLOY

- [ ] VPS acessível via SSH
- [ ] Dependências instaladas (Python, nginx, git)
- [ ] Repositório clonado
- [ ] Ambiente virtual criado
- [ ] Dependências Python instaladas
- [ ] Variáveis de ambiente configuradas (.env)
- [ ] Nginx configurado
- [ ] Systemd service criado
- [ ] Serviço iniciado e funcionando
- [ ] Site acessível via HTTP/HTTPS
- [ ] SSL configurado (opcional)

---

## 🐛 TROUBLESHOOTING

### Erro: Porta 5000 já em uso

```bash
# Verificar processos na porta 5000
sudo lsof -i :5000

# Matar processo se necessário
sudo kill -9 [PID]
```

### Erro: Nginx não inicia

```bash
# Verificar configuração
sudo nginx -t

# Ver logs
sudo tail -f /var/log/nginx/error.log
```

### Erro: Aplicação não inicia

```bash
# Verificar logs do systemd
sudo journalctl -u gemexpert -n 50

# Verificar permissões
ls -la /opt/gem_viagem_uruguai/06_DASHBOARD/
```

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0

