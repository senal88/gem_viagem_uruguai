# 🤖 AUTOMATIZAÇÃO COMPLETA - Regeneração de Google API Key

## ✅ O QUE FOI AUTOMATIZADO

Todos os scripts necessários foram criados e estão prontos para uso!

---

## 🚀 PROCESSO AUTOMATIZADO

### Passo 1: Regenerar Chave no Google Cloud (Manual - Requer Login)

⚠️ **Este passo requer login manual no Google Cloud Console**

1. Acesse: https://console.cloud.google.com/apis/credentials?project=gcp-ai-setup-24410
2. Localize a chave antiga: `AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs`
3. Clique em **"Editar"** → **"Regenerar chave"**
4. Copie a nova chave

### Passo 2: Atualizar Automaticamente (Script)

```bash
cd ~/gem_viagem_uruguai
./scripts/regenerar_google_api_key.sh NOVA_CHAVE_AQUI
```

**O que o script faz automaticamente:**
- ✅ Valida formato da chave
- ✅ Atualiza `.env` local
- ✅ Atualiza `.env` no VPS via SSH
- ✅ Reinicia serviço `gemexpert` no VPS
- ✅ Verifica se serviço está rodando

### Passo 3: Configurar Restrições (Script Guia)

```bash
./scripts/configurar_restricoes_google_api.sh
```

Este script abre o Google Cloud Console e mostra instruções passo a passo.

### Passo 4: Testar (Script)

```bash
./scripts/testar_google_api_key.sh
```

Testa se a chave está funcionando corretamente.

---

## 📋 RESUMO DOS SCRIPTS CRIADOS

| Script | Função | Uso |
|--------|--------|-----|
| `regenerar_google_api_key.sh` | Atualiza chave automaticamente | `./scripts/regenerar_google_api_key.sh NOVA_CHAVE` |
| `configurar_restricoes_google_api.sh` | Guia para configurar restrições | `./scripts/configurar_restricoes_google_api.sh` |
| `testar_google_api_key.sh` | Testa se chave funciona | `./scripts/testar_google_api_key.sh` |

---

## ⚡ EXECUÇÃO RÁPIDA (TUDO EM UM)

```bash
# 1. Regenerar chave no Google Cloud (manual)
# 2. Executar script de atualização
./scripts/regenerar_google_api_key.sh SUA_NOVA_CHAVE

# 3. Configurar restrições (guia interativo)
./scripts/configurar_restricoes_google_api.sh

# 4. Testar
./scripts/testar_google_api_key.sh
```

---

## 🔐 SEGURANÇA

- ✅ Chave removida do código
- ✅ Scripts validam formato antes de atualizar
- ✅ Backup automático do `.env` antes de modificar
- ✅ Restrições podem ser configuradas facilmente

---

## 📞 SUPORTE

Se algo der errado:

1. **Verificar logs do serviço**:
```bash
ssh root@147.79.81.59
journalctl -u gemexpert -f
```

2. **Verificar .env no VPS**:
```bash
ssh root@147.79.81.59
cat /opt/gem_viagem_uruguai/06_DASHBOARD/.env
```

3. **Restaurar backup**:
```bash
ssh root@147.79.81.59
cd /opt/gem_viagem_uruguai/06_DASHBOARD
ls -la .env.bak.*  # Ver backups disponíveis
cp .env.bak.TIMESTAMP .env  # Restaurar backup específico
systemctl restart gemexpert
```

---

**Status**: ✅ Scripts criados e prontos para uso  
**Próximo passo**: Regenerar chave no Google Cloud e executar script de atualização

