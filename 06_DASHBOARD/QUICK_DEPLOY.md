# ⚡ Quick Deploy - VPS senamfo.com.br
## Deploy em 1 Comando

---

## 🚀 DEPLOY AUTOMÁTICO

### Opção 1: Deploy Local (Recomendado)

```bash
cd 06_DASHBOARD
./deploy_vps.sh
```

O script irá:
1. ✅ Conectar na VPS via SSH
2. ✅ Clonar/atualizar repositório
3. ✅ Instalar dependências
4. ✅ Configurar ambiente Python
5. ✅ Configurar Nginx
6. ✅ Criar service Systemd
7. ✅ Iniciar aplicação

---

### Opção 2: Deploy Manual na VPS

```bash
# Conectar na VPS
ssh root@147.79.81.59

# Executar na VPS
cd /opt
git clone https://github.com/senal88/gem_viagem_uruguai.git
cd gem_viagem_uruguai/06_DASHBOARD
chmod +x deploy_vps.sh
./deploy_vps.sh
```

---

## 📱 ACESSO

Após o deploy:

- **HTTP**: http://senamfo.com.br/gem
- **IP Direto**: http://147.79.81.59/gem

---

## ⚙️ CONFIGURAÇÃO PÓS-DEPLOY

### 1. Configurar API Keys

```bash
ssh root@147.79.81.59
nano /opt/gem_viagem_uruguai/06_DASHBOARD/.env
```

Adicionar:
```bash
OPENAI_API_KEY=sua_key
ANTHROPIC_API_KEY=sua_key
GOOGLE_API_KEY=sua_key
FLASK_ENV=production
FLASK_DEBUG=False
```

### 2. Reiniciar Serviço

```bash
systemctl restart gemexpert
systemctl status gemexpert
```

---

## 🔒 SSL/HTTPS (Opcional)

```bash
ssh root@147.79.81.59
certbot --nginx -d senamfo.com.br
```

---

## 📊 COMANDOS ÚTEIS

### Ver Logs

```bash
# Logs da aplicação
journalctl -u gemexpert -f

# Logs do Nginx
tail -f /var/log/nginx/gemexpert_access.log
tail -f /var/log/nginx/gemexpert_error.log
```

### Reiniciar

```bash
systemctl restart gemexpert
systemctl reload nginx
```

### Atualizar Código

```bash
cd /opt/gem_viagem_uruguai
git pull origin main
cd 06_DASHBOARD
source venv/bin/activate
pip install -r requirements.txt --upgrade
systemctl restart gemexpert
```

---

**Última atualização**: 16 de Novembro de 2025

