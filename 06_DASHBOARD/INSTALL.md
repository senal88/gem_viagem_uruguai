# 📱 Instalação do Dashboard Mobile
## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 🚀 INSTALAÇÃO RÁPIDA

### Passo 1: Instalar Dependências

```bash
cd 06_DASHBOARD
pip3 install --user -r requirements.txt
```

### Passo 2: Configurar Variáveis de Ambiente

Certifique-se de que o arquivo `.env` na raiz do projeto contém:

```bash
OPENAI_API_KEY=sua_key
ANTHROPIC_API_KEY=sua_key
GOOGLE_API_KEY=sua_key
```

### Passo 3: Executar Servidor

```bash
python3 api/server.py
```

### Passo 4: Acessar no iPhone

1. Descubra seu IP local:
   ```bash
   # macOS/Linux
   ifconfig | grep "inet " | grep -v 127.0.0.1
   
   # Ou use:
   ipconfig getifaddr en0
   ```

2. No iPhone, abra o navegador Safari
3. Acesse: `http://[SEU_IP_LOCAL]:5000`
4. Adicione à Tela de Início para acesso rápido

---

## 📱 ADICIONAR À TELA DE INÍCIO DO IPHONE

1. Abra o Safari no iPhone
2. Acesse o dashboard
3. Toque no botão de compartilhar (quadrado com seta)
4. Selecione "Adicionar à Tela de Início"
5. Personalize o nome: "GEM Expert"
6. Toque em "Adicionar"

Agora você tem um ícone na tela de início que abre o dashboard como um app!

---

## 🔧 CONFIGURAÇÃO AVANÇADA

### Executar em Background

```bash
# Usando nohup
nohup python3 api/server.py > dashboard.log 2>&1 &

# Ou usando screen
screen -S dashboard
python3 api/server.py
# Pressione Ctrl+A depois D para desanexar
```

### Mudar Porta

```bash
PORT=8080 python3 api/server.py
```

### Modo Produção

```bash
FLASK_ENV=production python3 api/server.py
```

---

## 🌐 DEPLOY (Opcional)

### Vercel

1. Instalar Vercel CLI: `npm i -g vercel`
2. Criar `vercel.json`:
```json
{
  "version": 2,
  "builds": [
    {
      "src": "api/server.py",
      "use": "@vercel/python"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "api/server.py"
    }
  ]
}
```
3. Deploy: `vercel`

### Render

1. Conectar repositório GitHub
2. Configurar:
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `python api/server.py`
3. Adicionar variáveis de ambiente
4. Deploy automático

---

## ✅ CHECKLIST

- [ ] Dependências instaladas
- [ ] Variáveis de ambiente configuradas
- [ ] Servidor executando
- [ ] Dashboard acessível no iPhone
- [ ] Chat funcionando
- [ ] Visualizações carregando

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0

