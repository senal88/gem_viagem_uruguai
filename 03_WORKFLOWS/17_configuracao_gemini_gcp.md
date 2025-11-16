# 🔧 Configuração Avançada: Gemini com GCP
## Integração com Google Cloud Platform para Gemini Code Assist

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | WORKFLOW |
| **Prioridade** | IMPORTANTE |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | GCP Service Account |

---

## 🎯 OBJETIVO

Este documento fornece instruções para configurar o Gemini com Google Cloud Platform, incluindo Service Account e autenticação avançada.

---

## 🔐 CONFIGURAÇÃO GCP

### Informações do Projeto

- **Projeto GCP**: gcp-ai-setup-24410
- **Service Account**: gemini-vps-agent@gcp-ai-setup-24410.iam.gserviceaccount.com
- **Console URL**: https://console.cloud.google.com/home/dashboard?project=gcp-ai-setup-24410

### Autenticação via Service Account

#### Opção 1: Usar API Key Direta (Atual)

**Configuração Atual:**
```bash
GOOGLE_API_KEY=AQ.Ab8RN6Lqo6jrKtgINQwQ925S83ceUYisIk1iKSD8ccfnUTmxfA
```

**Uso:**
```python
import google.generativeai as genai

genai.configure(api_key=os.getenv('GOOGLE_API_KEY'))
model = genai.GenerativeModel('gemini-2.5-pro')
```

#### Opção 2: Usar Service Account (Avançado)

**Requisitos:**
1. Baixar arquivo JSON de credenciais do GCP
2. Configurar variável de ambiente `GOOGLE_APPLICATION_CREDENTIALS`

**Configuração:**
```bash
# Adicionar ao .env
GOOGLE_APPLICATION_CREDENTIALS=/caminho/para/service-account-key.json
GOOGLE_PROJECT_ID=gcp-ai-setup-24410
```

**Uso:**
```python
from google.auth import default
import google.generativeai as genai

credentials, project = default()
genai.configure(credentials=credentials)
model = genai.GenerativeModel('gemini-2.5-pro')
```

---

## 📝 NOTAS IMPORTANTES

### Service Account vs API Key

- **API Key**: Mais simples, adequado para uso direto
- **Service Account**: Mais seguro, adequado para produção e automação

### Recomendação

Para o GEM Expert, a **API Key direta** é suficiente e mais simples de configurar. O Service Account é útil para:
- Automação em servidores
- Integração com outros serviços GCP
- Acesso a recursos avançados do GCP

---

## 🔗 REFERÊNCIAS

- **GCP Console**: https://console.cloud.google.com/home/dashboard?project=gcp-ai-setup-24410
- **Service Account**: gemini-vps-agent@gcp-ai-setup-24410.iam.gserviceaccount.com
- **Gemini API Docs**: https://ai.google.dev/docs

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ CONFIGURAÇÃO DOCUMENTADA

