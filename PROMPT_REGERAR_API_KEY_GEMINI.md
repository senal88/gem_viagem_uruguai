# 🤖 PROMPT COMPLETO - Regenerar Google API Key via Gemini CLI

## 📋 PROMPT PARA GEMINI CLI NO CONSOLE DO GOOGLE CLOUD

---

### 🎯 PROMPT PRINCIPAL

```
Preciso regenerar uma chave de API do Google Cloud Platform que foi exposta publicamente no GitHub.

CONTEXTO:
- Projeto: gcp-ai-setup-24410
- Chave exposta: AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs
- Esta chave foi encontrada publicamente no GitHub e precisa ser regenerada imediatamente por segurança

OBJETIVO:
Regenerar a chave de API comprometida e fornecer instruções claras passo a passo.

LISTA DE CHAVES DISPONÍVEIS NO PROJETO:
1. GOOGLE_AI_STUDIO_API_KEY - Criada em 11 de nov. de 2025 - Generative Language API
2. GEMINI_API_KEY - Criada em 11 de nov. de 2025 - Conta de serviço: gemini-vps-agent@gcp-ai-setup-24410.iam.gserviceaccount.com
3. GOOGLE_AI_STUDIO - Criada em 31 de out. de 2025 - Generative Language API
4. GOOGLE_API_KEY - Criada em 22 de out. de 2025 - Generative Language API (POSSIVELMENTE A COMPROMETIDA)
5. AI_STUDIO_KEY - Criada em 21 de out. de 2025 - Generative Language API
6. GLOBAL_API_KEY - Criada em 17 de out. de 2025 - 8 APIs

INSTRUÇÕES NECESSÁRIAS:
1. Identificar qual chave corresponde a "AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs"
2. Fornecer passo a passo detalhado para regenerar essa chave específica
3. Explicar como configurar restrições após regenerar
4. Listar todas as APIs que devem ser habilitadas para esta chave
5. Fornecer comandos gcloud CLI (se aplicável) para automatizar o processo
6. Criar um guia de segurança para prevenir futuras exposições

FORMATO DE RESPOSTA:
- Passo a passo numerado e claro
- Comandos exatos para copiar e colar
- Links diretos para o console do Google Cloud
- Explicações de segurança
- Checklist de validação
```

---

## 🔧 PROMPT ALTERNATIVO (Mais Direto)

```
Você é um especialista em segurança do Google Cloud Platform. Uma chave de API foi exposta publicamente no GitHub e precisa ser regenerada URGENTEMENTE.

DADOS:
- Projeto GCP: gcp-ai-setup-24410
- Chave comprometida: AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs
- Chaves disponíveis no projeto:
  * GOOGLE_API_KEY (22 out 2025) - Generative Language API
  * GOOGLE_AI_STUDIO_API_KEY (11 nov 2025) - Generative Language API
  * GEMINI_API_KEY (11 nov 2025) - Service Account
  * GOOGLE_AI_STUDIO (31 out 2025) - Generative Language API
  * AI_STUDIO_KEY (21 out 2025) - Generative Language API
  * GLOBAL_API_KEY (17 out 2025) - 8 APIs

TAREFA:
1. Identificar qual chave na lista corresponde à chave comprometida
2. Gerar instruções passo a passo EXATAS para regenerar via Google Cloud Console
3. Fornecer comandos gcloud CLI para regenerar programaticamente
4. Criar configuração de restrições recomendadas (IP, HTTP referrers, APIs)
5. Gerar script bash para automatizar todo o processo

RESPONDA EM PORTUGUÊS COM:
- Comandos prontos para copiar
- Links diretos do console
- Explicações de segurança
- Validação passo a passo
```

---

## 🛠️ PROMPT PARA AUTOMAÇÃO COMPLETA

```
Crie um script completo e automatizado para regenerar uma chave de API do Google Cloud Platform que foi comprometida.

REQUISITOS:
1. Projeto: gcp-ai-setup-24410
2. Chave comprometida: AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs
3. Identificar qual das chaves listadas corresponde à comprometida
4. Regenerar usando gcloud CLI
5. Configurar restrições automaticamente:
   - HTTP referrers: http://senamfo.com.br:8081/*, https://senamfo.com.br/*, localhost:5000/*
   - APIs: Maps JavaScript API, Geocoding API, Directions API, Generative Language API
6. Validar que a nova chave funciona
7. Atualizar arquivo .env local e remoto (VPS)
8. Reiniciar serviços dependentes

ENTREGÁVEIS:
- Script bash completo e funcional
- Comandos gcloud CLI exatos
- Validações de segurança
- Tratamento de erros
- Logs detalhados
- Backup automático antes de modificar
```

---

## 📝 PROMPT PARA DOCUMENTAÇÃO

```
Crie documentação completa em Markdown para regenerar uma chave de API do Google Cloud Platform comprometida.

INFORMAÇÕES:
- Projeto: gcp-ai-setup-24410
- Chave exposta: AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs
- Data de exposição: 16 de novembro de 2025
- Chaves disponíveis no projeto (ver lista acima)

DOCUMENTAÇÃO DEVE INCLUIR:
1. Introdução e contexto do problema
2. Identificação da chave comprometida
3. Método 1: Regenerar via Console (passo a passo com screenshots)
4. Método 2: Regenerar via gcloud CLI (comandos exatos)
5. Configuração de restrições (IP, HTTP referrers, APIs)
6. Validação e testes
7. Atualização em ambientes (local e VPS)
8. Prevenção futura (best practices)
9. Troubleshooting comum
10. Checklist completo

FORMATO: Markdown profissional com código destacado, comandos copiáveis, e estrutura clara.
```

---

## 🎯 PROMPT PARA VALIDAÇÃO E TESTES

```
Crie um script de validação completo para testar uma nova chave de API do Google Cloud Platform após regeneração.

REQUISITOS:
1. Validar formato da chave (AIzaSy... ou AQ...)
2. Testar Generative Language API (Gemini)
3. Testar Maps Geocoding API
4. Testar Maps Directions API
5. Testar Maps JavaScript API (via endpoint)
6. Verificar restrições configuradas
7. Validar que chave antiga não funciona mais
8. Testar integração no dashboard (http://senamfo.com.br:8081/gem/)

ENTREGÁVEIS:
- Script bash de validação
- Testes automatizados para cada API
- Relatório de validação em JSON
- Indicadores visuais de sucesso/erro
- Sugestões de correção se houver falhas
```

---

## 🔐 PROMPT PARA SEGURANÇA

```
Analise a exposição de uma chave de API do Google Cloud Platform e crie um plano completo de segurança.

SITUAÇÃO:
- Chave exposta no GitHub: AIzaSyD7BUB4hBUCPsNAWdpecA2dZZ2zm02_OCs
- Projeto: gcp-ai-setup-24410
- Data: 16 de novembro de 2025

ANÁLISE NECESSÁRIA:
1. Avaliar impacto da exposição
2. Verificar uso anormal da chave (via Cloud Logging)
3. Identificar quais APIs estão em risco
4. Calcular custos potenciais de uso indevido
5. Criar plano de resposta a incidentes

PLANO DE SEGURANÇA DEVE INCLUIR:
1. Ações imediatas (regenerar chave)
2. Configuração de restrições rigorosas
3. Monitoramento contínuo
4. Alertas de uso anormal
5. Rotação periódica de chaves
6. Auditoria de segurança
7. Prevenção de futuras exposições
8. Políticas de uso de chaves

ENTREGÁVEIS:
- Plano de ação imediata
- Configurações de segurança recomendadas
- Scripts de monitoramento
- Políticas e procedimentos
- Checklist de segurança
```

---

## 📋 INSTRUÇÕES DE USO

### Opção 1: Gemini CLI no Console do Google Cloud

1. Acesse: https://console.cloud.google.com/
2. Abra o Gemini CLI (se disponível) ou use o chat do console
3. Cole um dos prompts acima
4. Siga as instruções geradas

### Opção 2: Google Cloud Shell

```bash
# Abrir Cloud Shell no console
# Executar comandos gcloud diretamente

# Listar todas as chaves
gcloud services api-keys list --project=gcp-ai-setup-24410

# Regenerar chave específica (substituir KEY_ID)
gcloud services api-keys update KEY_ID --regenerate-key --project=gcp-ai-setup-24410
```

### Opção 3: Gemini AI Studio

1. Acesse: https://aistudio.google.com/
2. Cole um dos prompts acima
3. Use a resposta para guiar o processo manual

---

## ✅ CHECKLIST DE USO

- [ ] Escolher prompt apropriado
- [ ] Copiar prompt completo
- [ ] Colar no Gemini CLI/Console
- [ ] Revisar instruções geradas
- [ ] Executar passo a passo
- [ ] Validar resultados
- [ ] Atualizar documentação local

---

**Última atualização**: 16 de Novembro de 2025  
**Status**: Pronto para uso

