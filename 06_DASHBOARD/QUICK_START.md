# ⚡ Quick Start - Dashboard Mobile
## Início Rápido em 3 Passos

---

## 🚀 INÍCIO RÁPIDO (3 MINUTOS)

### Passo 1: Instalar Dependências (1 min)

```bash
cd 06_DASHBOARD
pip3 install --user flask flask-cors python-dotenv openai anthropic google-generativeai
```

### Passo 2: Executar Servidor (30 seg)

```bash
python3 api/server.py
```

Você verá:
```
🚀 Servidor iniciando na porta 5000
📱 Acesse no iPhone: http://[SEU_IP_LOCAL]:5000
```

### Passo 3: Acessar no iPhone (1 min)

1. **Descobrir IP local:**
   ```bash
   # No terminal do Mac
   ipconfig getifaddr en0
   # Ou
   ifconfig | grep "inet " | grep -v 127.0.0.1
   ```

2. **No iPhone:**
   - Abra Safari
   - Digite: `http://[IP_DO_PASSO_1]:5000`
   - Exemplo: `http://192.168.1.100:5000`

3. **Adicionar à Tela de Início:**
   - Toque no botão de compartilhar (□↑)
   - "Adicionar à Tela de Início"
   - Nome: "GEM Expert"
   - "Adicionar"

---

## ✅ PRONTO!

Agora você tem um app na tela de início do iPhone que abre o dashboard completo!

---

## 🎯 RECURSOS DISPONÍVEIS

- 💬 **Chat**: Converse com GEM Expert (OpenAI, Claude ou Gemini)
- 📅 **Próximo Evento**: Veja o que vem por aí
- 🌤️ **Clima**: Previsão do tempo atualizada
- 💱 **Câmbio**: Cotação BRL/UYU
- 📋 **Itinerário**: Timeline completa
- ⚡ **Ações Rápidas**: Contatos, reservas, transporte

---

## 🔧 TROUBLESHOOTING

### Não consegue acessar no iPhone?

1. **Verificar se Mac e iPhone estão na mesma rede Wi-Fi**
2. **Verificar firewall do Mac:**
   ```bash
   # Permitir conexões na porta 5000
   sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/bin/python3
   ```

3. **Testar localmente primeiro:**
   ```bash
   # No Mac, abra: http://localhost:5000
   ```

### Erro ao instalar dependências?

```bash
# Usar ambiente virtual
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

**Última atualização**: 16 de Novembro de 2025

