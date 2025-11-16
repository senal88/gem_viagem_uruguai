# 🔍 Protocolo de Busca Web Inteligente
## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | CONTEXTO_DINAMICO |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | `01_BASE_CONHECIMENTO/*` |

---

## 🎯 OBJETIVO

Este documento define o protocolo inteligente de busca na web para validação de informações dinâmicas durante a viagem. O sistema deve usar busca web de forma estratégica e eficiente, combinando conhecimento estático com validação em tempo real.

---

## 🧠 FILOSOFIA DE BUSCA INTELIGENTE

### Princípios Fundamentais

1. **Buscar apenas quando necessário**: Não buscar informações já disponíveis no conhecimento estático
2. **Buscar de forma estratégica**: Usar múltiplas queries complementares para validação cruzada
3. **Contextualizar sempre**: Integrar resultados da busca com o itinerário e perfil dos viajantes
4. **Priorizar precisão**: Preferir fontes oficiais e validadas
5. **Ser proativo**: Antecipar necessidades e validar informações críticas antes de serem solicitadas

---

## 🔄 FLUXO DE DECISÃO DE BUSCA

### Árvore de Decisão

```
PERGUNTA RECEBIDA
    ↓
É informação estática no Dossiê?
    ├─ SIM → Consultar Dossiê (NÃO buscar)
    └─ NÃO → Continuar análise
        ↓
É informação dinâmica que muda frequentemente?
    ├─ SIM → BUSCAR (clima, trânsito, câmbio)
    └─ NÃO → Continuar análise
        ↓
É informação que pode ter mudado recentemente?
    ├─ SIM → BUSCAR (horários, disponibilidade)
    └─ NÃO → Consultar Dossiê ou buscar se incerto
```

### Critérios de Busca Obrigatória

**SEMPRE buscar quando:**
- ✅ Informação muda em tempo real (clima, trânsito, câmbio)
- ✅ Informação pode variar por dia (horários de funcionamento)
- ✅ Informação requer validação atual (disponibilidade de restaurantes)
- ✅ Informação não está no Dossiê e é crítica para a viagem

**NUNCA buscar quando:**
- ❌ Informação está no Dossiê e é estática (itinerário, reservas confirmadas)
- ❌ Pergunta é sobre eventos já confirmados (L'Incanto, Fasano, Primuseum)
- ❌ Informação é sobre contatos ou endereços já documentados

---

## 📊 ESTRATÉGIAS DE BUSCA POR CATEGORIA

### CATEGORIA 1: CLIMA & PREVISÃO DO TEMPO

#### Quando Buscar
- Perguntas sobre clima atual ou futuro
- Validação antes de eventos ao ar livre
- Recomendações de vestiário baseadas em clima

#### Estratégia de Busca

**Query Primária:**
```
"previsão do tempo [local] [data] [horário]"
```

**Queries Complementares:**
```
- "clima [local] hoje"
- "temperatura [local] [data]"
- "velocidade do vento [local] [data]"
- "chance de chuva [local] [data]"
```

**Fontes Preferenciais:**
- InUMet (Instituto Uruguaio de Meteorologia)
- Tempo Limpo
- Dicas do Uruguai
- Google Weather API

#### Processamento de Resultados

1. **Extrair dados críticos:**
   - Temperatura máxima e mínima
   - Velocidade do vento
   - Chance de chuva (%)
   - Índice UV
   - Sensação térmica

2. **Contextualizar:**
   - Relacionar com evento/atividade específica
   - Considerar horário do evento
   - Integrar com dress code do evento

3. **Recomendar ações:**
   - Vestiário adequado
   - Acessórios necessários (guarda-chuva, protetor solar)
   - Ajustes logísticos se necessário

---

### CATEGORIA 2: DISTÂNCIA & TRÂNSITO

#### Quando Buscar
- Perguntas sobre tempo de deslocamento
- Validação de rotas em tempo real
- Planejamento de saída para eventos

#### Estratégia de Busca

**Query Primária:**
```
"tempo de carro [origem] para [destino] agora"
```

**Queries Complementares:**
```
- "trânsito [origem] [destino] [horário]"
- "rotas alternativas [origem] [destino]"
- "tráfego [cidade] agora"
```

**Fontes Preferenciais:**
- Google Maps API
- Waze
- Trânsito em tempo real

#### Processamento de Resultados

1. **Extrair dados críticos:**
   - Tempo estimado de viagem
   - Distância
   - Condições de trânsito (livre, moderado, congestionado)
   - Rotas alternativas disponíveis

2. **Contextualizar:**
   - Relacionar com horário do evento/reserva
   - Considerar margem de segurança (15-30 min)
   - Integrar com logística do dia

3. **Recomendar ações:**
   - Horário ideal de saída
   - Rota recomendada
   - Alternativas se trânsito pesado

---

### CATEGORIA 3: HORÁRIOS & FUNCIONAMENTO

#### Quando Buscar
- Perguntas sobre horários de funcionamento
- Validação se local está aberto/fechado
- Verificação de horários especiais (feriados, eventos)

#### Estratégia de Busca

**Query Primária:**
```
"horário de funcionamento [local] [data]"
```

**Queries Complementares:**
```
- "[local] aberto hoje"
- "[local] horário [dia da semana]"
- "[local] fecha que horas"
- "[local] último acesso"
```

**Fontes Preferenciais:**
- Site oficial do local
- Google Business
- TripAdvisor
- Páginas oficiais de turismo

#### Processamento de Resultados

1. **Extrair dados críticos:**
   - Horário de abertura
   - Horário de fechamento
   - Último acesso permitido
   - Dias de funcionamento
   - Horários especiais (se houver)

2. **Contextualizar:**
   - Verificar se está dentro do horário atual
   - Considerar tempo necessário para visita
   - Integrar com outras atividades do dia

3. **Recomendar ações:**
   - Confirmar se ainda dá tempo de visitar
   - Sugerir horário ideal de visita
   - Alertar se fechado e sugerir alternativas

---

### CATEGORIA 4: CÂMBIO & FINANÇAS

#### Quando Buscar
- Perguntas sobre cotação atual
- Recomendações de onde trocar dinheiro
- Validação de taxas de câmbio

#### Estratégia de Busca

**Query Primária:**
```
"cotação BRL UYU hoje"
```

**Queries Complementares:**
```
- "taxa de câmbio Real Peso Uruguaio hoje"
- "melhores casas de câmbio [cidade]"
- "caixas eletrônicos [bairro] [cidade]"
- "taxa câmbio [casa de câmbio] [cidade]"
```

**Fontes Preferenciais:**
- Wise (taxa comercial real)
- Exiap
- Casas de câmbio oficiais
- Bancos locais

#### Processamento de Resultados

1. **Extrair dados críticos:**
   - Taxa de câmbio atual (BRL → UYU)
   - Taxa comercial vs turística
   - Locais para trocar dinheiro
   - Taxas de casas de câmbio
   - Disponibilidade de caixas eletrônicos

2. **Contextualizar:**
   - Comparar com taxa de referência do Dossiê
   - Considerar localização atual dos viajantes
   - Integrar com necessidades financeiras do dia

3. **Recomendar ações:**
   - Melhor local para trocar (melhor taxa)
   - Quantidade recomendada
   - Quando trocar (agora ou depois)

---

### CATEGORIA 5: DISPONIBILIDADE & RESERVAS

#### Quando Buscar
- Perguntas sobre disponibilidade de restaurantes
- Validação de reservas não confirmadas
- Verificação de sistemas de reserva online

#### Estratégia de Busca

**Query Primária:**
```
"[restaurante] reserva [data] [horário]"
```

**Queries Complementares:**
```
- "[restaurante] reserva online"
- "telefone reservas [restaurante]"
- "[restaurante] disponibilidade [dia da semana]"
- "[restaurante] lotação [dia da semana]"
```

**Fontes Preferenciais:**
- Site oficial do restaurante
- Sistema de reservas online
- Google Business
- TripAdvisor

#### Processamento de Resultados

1. **Extrair dados críticos:**
   - Disponibilidade para data/hora solicitada
   - Sistema de reserva (online ou telefone)
   - Telefone para reservas
   - Horários de funcionamento
   - Nível de lotação esperado

2. **Contextualizar:**
   - Verificar se é dia de alta demanda
   - Considerar perfil do restaurante (alto padrão)
   - Integrar com outras atividades do dia

3. **Recomendar ações:**
   - Como fazer reserva (online ou telefone)
   - Horário recomendado
   - Alternativas se não disponível

---

### CATEGORIA 6: INFORMAÇÕES PRÁTICAS

#### Quando Buscar
- Perguntas sobre serviços locais
- Localização de pontos de interesse
- Informações sobre infraestrutura

#### Estratégia de Busca

**Query Primária:**
```
"[serviço] próximo [local] [cidade]"
```

**Queries Complementares:**
```
- "como [ação] [cidade] Uruguai"
- "[serviço] [bairro] [cidade]"
- "onde [serviço] [cidade]"
```

**Fontes Preferenciais:**
- Google Maps
- Sites oficiais de turismo
- Guias locais
- Fóruns de viagem

#### Processamento de Resultados

1. **Extrair dados críticos:**
   - Localização exata
   - Endereço completo
   - Telefone de contato
   - Horários de funcionamento
   - Observações importantes

2. **Contextualizar:**
   - Relacionar com localização atual dos viajantes
   - Integrar com logística do dia
   - Considerar distância e tempo de deslocamento

3. **Recomendar ações:**
   - Como chegar
   - Quando ir
   - O que levar/preparar

---

## 🎯 PROTOCOLO DE BUSCA MULTI-FONTE

### Validação Cruzada

Para informações críticas, sempre buscar em múltiplas fontes:

1. **Fonte Primária**: Site oficial ou fonte mais confiável
2. **Fonte Secundária**: Validação com outra fonte confiável
3. **Fonte Terciária**: Verificação adicional se necessário

### Exemplo: Busca de Clima

```
Query 1: "previsão do tempo Punta del Este 22 novembro 2025" (InUMet)
Query 2: "clima Hotel Fasano Las Piedras hoje" (Google Weather)
Query 3: "velocidade do vento Punta del Este hoje" (Tempo Limpo)

→ Comparar resultados
→ Usar dados mais conservadores se divergência
→ Contextualizar com evento específico
```

---

## 📝 FORMATO DE RESPOSTA INTELIGENTE

### Estrutura Padrão

```
[1. ACUSO DE CONTEXTO]
"Entendido. Você está em [LOCALIZAÇÃO], 
dia [DATA], e quer saber sobre [TEMA]."

[2. INDICAÇÃO DE BUSCA]
"Deixa eu verificar isso agora..." 
(ou "De acordo com nosso itinerário..." se não precisar buscar)

[3. INFORMAÇÃO VALIDADA]
- Dado 1 (validado via busca)
- Dado 2 (validado via busca)
- Dado 3 (contextualizado com Dossiê)

[4. CONTEXTUALIZAÇÃO]
"Considerando que vocês têm [EVENTO] às [HORA], 
recomendo..."

[5. PRÓXIMA AÇÃO]
"Recomendo então [AÇÃO CONCRETA]. 
Quer que eu [OFEREÇA MAIS INFO]?"
```

---

## ⚡ OTIMIZAÇÕES DE PERFORMANCE

### Cache Inteligente

- **Cache de curta duração**: Informações que mudam pouco (horários de funcionamento) - 1-2 horas
- **Cache de média duração**: Informações que mudam moderadamente (câmbio) - 30 minutos
- **Sem cache**: Informações em tempo real (trânsito, clima atual) - sempre buscar

### Priorização de Queries

1. **Alta Prioridade**: Informações críticas para eventos/reservas
2. **Média Prioridade**: Informações importantes para planejamento
3. **Baixa Prioridade**: Informações complementares

---

## 🔗 REFERÊNCIAS CRUZADAS

- **Gatilhos de Validação**: `02_gatilhos_validacao.md`
- **Categorias de Perguntas**: `03_categorias_perguntas.md`
- **Fontes Validadas**: `04_fontes_conhecimento_validadas.md`
- **Base de Conhecimento**: `01_BASE_CONHECIMENTO/*`

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0  
**Status**: ✅ COMPLETO E VALIDADO

