# 💰 LIMITES DE CUSTOS E COTAS - API Keys Google Cloud

## 📊 RESUMO EXECUTIVO

**Projeto**: `gcp-ai-setup-24410`  
**Chave Ativa**: `AIzaSyByKC4TPLsULBMLc5he5Ci9-rcIG2vJBDM`  
**APIs Configuradas**: Generative Language API (Gemini)

---

## 🎯 LIMITES RELEVANTES POR API

### 1. 🤖 Generative Language API (Gemini)

#### Créditos Gratuitos Mensais
- **$200 USD em créditos** por mês (sempre grátis)
- **15 RPM** (Requests Per Minute) - Padrão
- **1.500 RPD** (Requests Per Day) - Padrão

#### Custos Após Créditos Gratuitos
| Modelo | Custo por 1M tokens (entrada) | Custo por 1M tokens (saída) |
|--------|-------------------------------|------------------------------|
| **Gemini 2.5 Pro** | $1.25 | $5.00 |
| **Gemini 1.5 Pro** | $1.25 | $5.00 |
| **Gemini 1.5 Flash** | $0.075 | $0.30 |

#### Estimativa de Uso para Dashboard
- **Chat simples**: ~500 tokens por mensagem
- **100 mensagens/dia**: ~50K tokens/dia = **$0.06/dia**
- **3.000 mensagens/mês**: ~1.5M tokens/mês = **$1.88/mês**

**✅ Dentro do crédito grátis de $200/mês**

---

### 2. 🗺️ Google Maps APIs (Se Configuradas)

#### Créditos Gratuitos Mensais
- **$200 USD em créditos** por mês (sempre grátis)

#### Custos por Requisição
| API | Custo por Requisição | Crédito Grátis |
|-----|---------------------|----------------|
| **Maps JavaScript API** | $0.007 por carga | 28.000 cargas/mês |
| **Geocoding API** | $0.005 por requisição | 40.000 requisições/mês |
| **Directions API** | $0.005 por requisição | 40.000 requisições/mês |
| **Places API** | $0.017 por requisição | 11.700 requisições/mês |

#### Estimativa de Uso para Dashboard
- **Mapas carregados**: ~10/dia = 300/mês = **$2.10/mês**
- **Geocoding**: ~20/dia = 600/mês = **$3.00/mês**
- **Directions**: ~5/dia = 150/mês = **$0.75/mês**

**Total Maps**: ~$5.85/mês  
**✅ Dentro do crédito grátis de $200/mês**

---

### 3. 🌤️ OpenWeather API (Se Configurada)

#### Plano Gratuito
- **60 requisições/minuto**
- **1.000.000 requisições/mês**
- **Gratuito** (sem custo)

#### Estimativa de Uso
- **Atualização a cada 5 min**: 288 requisições/dia = 8.640/mês
- **✅ Dentro do limite grátis**

---

### 4. 💱 ExchangeRate API (Se Configurada)

#### Plano Gratuito
- **1.500 requisições/mês**
- **Gratuito** (sem custo)

#### Estimativa de Uso
- **Atualização a cada 5 min**: 288 requisições/dia = 8.640/mês
- **⚠️ Excede limite grátis** - precisa de plano pago ou reduzir frequência

---

## ⚠️ LIMITES CRÍTICOS DE SEGURANÇA

### 1. Limite de Faturamento Diário

**Recomendação**: Configurar limite de **$10/dia** para proteção

**Como Configurar**:
1. Acesse: https://console.cloud.google.com/billing
2. Selecione sua conta de faturamento
3. Configure "Budget & alerts"
4. Crie alerta para $5/dia e limite de $10/dia

---

### 2. Limite de Requisições por Minuto (RPM)

**Generative Language API**:
- **Padrão**: 15 RPM
- **Pode aumentar** via suporte se necessário

**Impacto**: Se exceder, receberá erro `429 Too Many Requests`

---

### 3. Limite de Requisições por Dia (RPD)

**Generative Language API**:
- **Padrão**: 1.500 RPD
- **Pode aumentar** via suporte se necessário

**Impacto**: Se exceder, receberá erro `429 Too Many Requests`

---

## 🔐 CONFIGURAÇÕES DE SEGURANÇA RECOMENDADAS

### 1. Budget e Alertas

```bash
# Criar budget via gcloud CLI
gcloud billing budgets create \
  --billing-account=BILLING_ACCOUNT_ID \
  --display-name="GEM Expert - Limite Diário" \
  --budget-amount=10USD \
  --threshold-rule=percent=50 \
  --threshold-rule=percent=90 \
  --threshold-rule=percent=100
```

**Alertas Recomendados**:
- ⚠️ **50% do budget** ($5) - Email de aviso
- 🟡 **90% do budget** ($9) - Email de alerta
- 🔴 **100% do budget** ($10) - Email crítico + desabilitar APIs

---

### 2. Quotas e Limites

**Verificar quotas atuais**:
```bash
gcloud compute project-info describe --project=gcp-ai-setup-24410
```

**Solicitar aumento de quota** (se necessário):
1. Acesse: https://console.cloud.google.com/iam-admin/quotas
2. Filtre por "Generative Language API"
3. Selecione quota desejada
4. Clique em "Edit Quotas"
5. Solicite aumento justificando uso

---

### 3. Restrições de API Key

**Já configurado**:
- ✅ Restrições de API (apenas Generative Language API)
- ⚠️ **Pendente**: Restrições de HTTP referrers ou IP

**Recomendação**: Adicionar restrições de HTTP referrers:
```
http://senamfo.com.br:8081/*
https://senamfo.com.br/*
localhost:5000/*
127.0.0.1:5000/*
```

---

## 📊 MONITORAMENTO DE CUSTOS

### 1. Dashboard de Faturamento

**Acesse**: https://console.cloud.google.com/billing

**Verificar**:
- Uso diário atual
- Projeção mensal
- Top serviços por custo
- Histórico de uso

---

### 2. Logs de Uso

**Ver logs de API**:
```bash
gcloud logging read "resource.type=api" \
  --project=gcp-ai-setup-24410 \
  --limit=50 \
  --format=json
```

**Filtrar por API específica**:
```bash
gcloud logging read "resource.type=api AND protoPayload.serviceName=generativelanguage.googleapis.com" \
  --project=gcp-ai-setup-24410 \
  --limit=100
```

---

### 3. Alertas de Custo

**Configurar via Console**:
1. Acesse: https://console.cloud.google.com/billing
2. Selecione conta de faturamento
3. Vá em "Budgets & alerts"
4. Crie novo budget:
   - **Valor**: $10/mês
   - **Alertas**: 50%, 90%, 100%
   - **Ações**: Enviar email

---

## 💡 ESTIMATIVAS DE CUSTO TOTAL

### Cenário Conservador (Uso Normal)

| Serviço | Uso Mensal | Custo |
|---------|------------|-------|
| **Gemini API** | 1.5M tokens | $1.88 |
| **Maps APIs** | 1.050 requisições | $5.85 |
| **OpenWeather** | 8.640 requisições | $0.00 |
| **ExchangeRate** | 288 requisições | $0.00 |
| **TOTAL** | - | **~$7.73/mês** |

**✅ Bem dentro do crédito grátis de $200/mês**

---

### Cenário Intensivo (Uso Alto)

| Serviço | Uso Mensal | Custo |
|---------|------------|-------|
| **Gemini API** | 10M tokens | $12.50 |
| **Maps APIs** | 5.000 requisições | $27.85 |
| **OpenWeather** | 50.000 requisições | $0.00 |
| **ExchangeRate** | 1.500 requisições | $0.00 |
| **TOTAL** | - | **~$40.35/mês** |

**✅ Ainda dentro do crédito grátis de $200/mês**

---

## 🚨 ALERTAS CRÍTICOS

### 1. Excesso de Requisições (429 Error)

**Sintoma**: Erro `429 Too Many Requests`

**Solução**:
- Implementar retry com backoff exponencial
- Reduzir frequência de requisições
- Solicitar aumento de quota

---

### 2. Excesso de Custos

**Sintoma**: Custo acima do esperado

**Ações Imediatas**:
1. Verificar logs de uso anormal
2. Verificar se há uso não autorizado
3. Configurar limites de budget
4. Desabilitar APIs não essenciais temporariamente

---

### 3. Chave Comprometida

**Sintoma**: Uso anormal detectado

**Ações Imediatas**:
1. ✅ **JÁ FEITO**: Regenerar chave
2. Verificar logs de uso antes da regeneração
3. Configurar restrições rigorosas na nova chave
4. Monitorar uso da nova chave

---

## 📋 CHECKLIST DE SEGURANÇA DE CUSTOS

- [x] Chave regenerada após exposição
- [ ] **Configurar budget de $10/mês**
- [ ] **Configurar alertas em 50%, 90%, 100%**
- [ ] **Adicionar restrições de HTTP referrers na chave**
- [ ] **Monitorar uso diário por 1 semana**
- [ ] Verificar logs de uso anormal
- [ ] Configurar alertas de uso anormal
- [ ] Documentar custos esperados

---

## 🔗 LINKS ÚTEIS

- **Faturamento**: https://console.cloud.google.com/billing
- **Quotas**: https://console.cloud.google.com/iam-admin/quotas
- **Budgets**: https://console.cloud.google.com/billing/budgets
- **Logs**: https://console.cloud.google.com/logs?project=gcp-ai-setup-24410
- **Preços Gemini**: https://ai.google.dev/pricing
- **Preços Maps**: https://mapsplatform.google.com/pricing/

---

## 📝 RESUMO FINAL

### ✅ Dentro do Crédito Grátis
- Gemini API: **$1.88/mês** (uso normal)
- Maps APIs: **$5.85/mês** (se configuradas)
- **Total**: ~$7.73/mês << $200 crédito grátis

### ⚠️ Ações Recomendadas
1. **Configurar budget de $10/mês** (proteção)
2. **Configurar alertas** (50%, 90%, 100%)
3. **Adicionar restrições de HTTP referrers**
4. **Monitorar uso inicial** por 1 semana

---

**Última atualização**: 16 de Novembro de 2025  
**Status**: Dentro dos limites seguros

