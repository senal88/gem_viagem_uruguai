# 🔒 SEGURANÇA - Chave de API do Google Exposta

## ⚠️ ALERTA DE SEGURANÇA

**Data**: 16 de Novembro de 2025  
**Status**: ✅ RESOLVIDO

---

## 📋 RESUMO DO PROBLEMA

Uma chave de API do Google foi detectada publicamente acessível no repositório GitHub:

- **Chave**: `AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs`
- **Projeto GCP**: `gcp-ai-setup-24410`
- **Arquivo**: `07_INTEGRACOES/GUIA_COMPLETO_API_KEYS.md`
- **Commit**: `0a4e01b4c25bed0b1fc6c6e415325ae6fc76fe7f`

---

## ✅ AÇÕES TOMADAS

1. ✅ **Chave removida** do arquivo `GUIA_COMPLETO_API_KEYS.md`
2. ✅ **Substituída por placeholder** `SUA_GOOGLE_API_KEY_AQUI`
3. ✅ **Verificação completa** do repositório para outras ocorrências
4. ✅ **Commit e push** das alterações

---

## 🔐 AÇÕES NECESSÁRIAS NO GOOGLE CLOUD CONSOLE

### 1. Regenerar a Chave Comprometida

1. Acesse: https://console.cloud.google.com/apis/credentials
2. Selecione o projeto: `gcp-ai-setup-24410`
3. Localize a chave: `AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs`
4. Clique em **"Editar"**
5. Clique em **"Regenerar chave"**
6. Confirme a regeneração

### 2. Adicionar Restrições à Nova Chave

Após regenerar, configure restrições:

#### Restrições de Aplicativo (HTTP referrers)
```
http://senamfo.com.br:8081/*
https://senamfo.com.br/*
localhost:5000/*
127.0.0.1:5000/*
```

#### Restrições de API
- ✅ Google Maps JavaScript API
- ✅ Google Maps Geocoding API
- ✅ Google Maps Directions API
- ✅ Google Places API (se necessário)

#### Restrições de IP (Opcional)
```
147.79.81.59/32  # IP do VPS
```

### 3. Atualizar Variáveis de Ambiente

Após regenerar a chave:

1. **Local (.env)**:
```bash
GOOGLE_API_KEY=nova_chave_aqui
GOOGLE_MAPS_API_KEY=nova_chave_aqui
```

2. **VPS**:
```bash
ssh root@147.79.81.59
cd /opt/gem_viagem_uruguai/06_DASHBOARD
nano .env
# Atualizar GOOGLE_API_KEY
systemctl restart gemexpert
```

---

## 📝 PREVENÇÃO FUTURA

### ✅ Boas Práticas Implementadas

1. ✅ `.env` adicionado ao `.gitignore`
2. ✅ `.env.example` criado com placeholders
3. ✅ Documentação usa placeholders, não chaves reais
4. ✅ GitHub Push Protection ativado

### ⚠️ Checklist Antes de Commits

- [ ] Verificar se `.env` está no `.gitignore`
- [ ] Nunca commitar chaves reais em arquivos de documentação
- [ ] Usar sempre placeholders em exemplos
- [ ] Revisar diffs antes de push
- [ ] Usar `git-secrets` ou similar para validação

---

## 🔗 LINKS ÚTEIS

- **Google Cloud Console**: https://console.cloud.google.com/
- **Credenciais**: https://console.cloud.google.com/apis/credentials
- **Logs de Abuso**: https://console.cloud.google.com/logs
- **Documentação de Segurança**: https://cloud.google.com/security/command-center/docs/how-to-respond-to-abuse-notifications

---

## 📞 SUPORTE

Se precisar de ajuda adicional:

1. **Google Cloud Support**: https://cloud.google.com/support
2. **Documentação de Credenciais**: https://cloud.google.com/docs/authentication/api-keys

---

**Última atualização**: 16 de Novembro de 2025  
**Status**: Chave removida do repositório - Aguardando regeneração no GCP

