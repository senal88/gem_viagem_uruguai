# ⚡ Gatilhos de Validação Inteligente

## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | CONTEXTO_DINAMICO |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | `01_protocolo_busca_web.md` |

---

## 🎯 OBJETIVO

Este documento define os gatilhos específicos que disparam busca na web para validação de informações dinâmicas. Cada gatilho é mapeado com padrões de pergunta, contexto e ação correspondente.

---

## 🔍 GATILHOS OBRIGATÓRIOS (SEMPRE BUSCAR)

### GATILHO 1: CLIMA & PREVISÃO DO TEMPO

#### Padrões de Pergunta

```
- "Qual a previsão para [evento/local/data]?"
- "Como está o tempo [hoje/amanhã]?"
- "Preciso de casaco [hoje à noite/amanhã]?"
- "Vai chover [data/horário]?"
- "Qual a temperatura [local/data]?"
- "Está ventando muito [local]?"
```

#### Contexto de Ativação

- ✅ Pergunta menciona clima, tempo, temperatura, chuva, vento
- ✅ Pergunta relacionada a evento ao ar livre
- ✅ Pergunta sobre vestiário baseado em clima
- ✅ Validação antes de atividades externas

#### Ação de Busca

```javascript
search_web([
  "previsão do tempo [local] [data] [horário]",
  "clima [local] hoje",
  "temperatura [local] [data]",
  "velocidade do vento [local] [data]",
  "chance de chuva [local] [data]"
])
```

#### Exemplo Prático

**Pergunta**: "Qual a previsão para o casamento no Fasano hoje?"

**Gatilho Ativado**: ✅ CLIMA & PREVISÃO

**Busca Executada**:

```
search_web([
  "previsão do tempo Punta del Este 22 novembro 2025",
  "clima Hotel Fasano Las Piedras hoje",
  "velocidade do vento Punta del Este hoje"
])
```

---

### GATILHO 2: TRÂNSITO & DESLOCAMENTO

#### Padrões de Pergunta

```
- "Quanto tempo leva de [origem] para [destino]?"
- "Como está o trânsito [agora/para [horário]]?"
- "Que horas devemos sair para [evento]?"
- "Tem muito trânsito [rota]?"
- "Qual a melhor rota para [destino]?"
```

#### Contexto de Ativação

- ✅ Pergunta sobre tempo de deslocamento
- ✅ Pergunta sobre trânsito atual ou futuro
- ✅ Planejamento de saída para eventos/reservas
- ✅ Validação de rotas

#### Ação de Busca

```javascript
search_web([
  "tempo de carro [origem] para [destino] agora",
  "trânsito [origem] [destino] [horário]",
  "rotas alternativas [origem] [destino]",
  "tráfego [cidade] agora"
])
```

#### Exemplo Prático

**Pergunta**: "Que horas devemos sair do hotel para a festa pré-wedding no L'Incanto?"

**Gatilho Ativado**: ✅ TRÂNSITO & DESLOCAMENTO

**Busca Executada**:

```
search_web([
  "trânsito Barradas Parque Hotel para Restaurante L'Incanto Punta del Este",
  "tempo de carro Barradas Hotel para Porto Punta del Este 18h",
  "tráfego Punta del Este 18h hoje"
])
```

---

### GATILHO 3: HORÁRIOS & FUNCIONAMENTO

#### Padrões de Pergunta

```
- "[Local] está aberto [hoje/agora]?"
- "Até que horas [local] fica aberto?"
- "Que horas [local] abre?"
- "[Local] fecha que horas [hoje]?"
- "Posso visitar [local] [agora/hoje]?"
```

#### Contexto de Ativação

- ✅ Pergunta sobre horários de funcionamento
- ✅ Validação se local está aberto/fechado
- ✅ Verificação de horários especiais
- ✅ Planejamento de visita

#### Ação de Busca

```javascript
search_web([
  "horário de funcionamento [local] [data]",
  "[local] aberto hoje",
  "[local] horário [dia da semana]",
  "[local] fecha que horas",
  "[local] último acesso"
])
```

#### Exemplo Prático

**Pergunta**: "A Casapueblo já está aberta? Que horas fecha hoje?"

**Gatilho Ativado**: ✅ HORÁRIOS & FUNCIONAMENTO

**Busca Executada**:

```
search_web([
  "horário de funcionamento Casapueblo Punta Ballena hoje",
  "Casapueblo fecha que horas",
  "Casapueblo último acesso hoje"
])
```

---

### GATILHO 4: CÂMBIO & FINANÇAS

#### Padrões de Pergunta

```
- "Qual a cotação do Real hoje?"
- "Onde trocar dinheiro com melhor taxa?"
- "Qual a melhor casa de câmbio [cidade]?"
- "Quanto está o dólar/peso hoje?"
- "Onde tem caixa eletrônico [próximo]?"
```

#### Contexto de Ativação

- ✅ Pergunta sobre cotação atual
- ✅ Pergunta sobre onde trocar dinheiro
- ✅ Validação de taxas de câmbio
- ✅ Localização de serviços financeiros

#### Ação de Busca

```javascript
search_web([
  "cotação BRL UYU hoje",
  "taxa de câmbio Real Peso Uruguaio hoje",
  "melhores casas de câmbio [cidade]",
  "caixas eletrônicos [bairro] [cidade]",
  "taxa câmbio [casa de câmbio] [cidade]"
])
```

#### Exemplo Prático

**Pergunta**: "Qual a melhor cotação do Real para Peso hoje? Estamos em Montevidéu."

**Gatilho Ativado**: ✅ CÂMBIO & FINANÇAS

**Busca Executada**:

```
search_web([
  "cotação BRL UYU hoje Montevidéu",
  "melhores casas de câmbio Pocitos Montevidéu",
  "caixas eletrônicos Punta Carretas Montevidéu"
])
```

---

### GATILHO 5: DISPONIBILIDADE & RESERVAS

#### Padrões de Pergunta

```
- "Conseguimos mesa em [restaurante] para [data/hora]?"
- "[Restaurante] tem disponibilidade [hoje/amanhã]?"
- "Como fazer reserva em [restaurante]?"
- "[Restaurante] aceita reserva online?"
- "Precisa reservar em [restaurante]?"
```

#### Contexto de Ativação

- ✅ Pergunta sobre disponibilidade de restaurantes
- ✅ Pergunta sobre como fazer reserva
- ✅ Validação de sistemas de reserva
- ✅ Restaurantes não confirmados no Dossiê

#### Ação de Busca

```javascript
search_web([
  "[restaurante] reserva [data] [horário]",
  "[restaurante] reserva online",
  "telefone reservas [restaurante]",
  "[restaurante] disponibilidade [dia da semana]",
  "[restaurante] lotação [dia da semana]"
])
```

#### Exemplo Prático

**Pergunta**: "Conseguimos reserva no Lo de Tere para hoje à noite?"

**Gatilho Ativado**: ✅ DISPONIBILIDADE & RESERVAS

**Busca Executada**:

```
search_web([
  "reserva online Lo de Tere Punta del Este",
  "Lo de Tere disponibilidade sexta-feira",
  "telefone Lo de Tere reservas"
])
```

---

### GATILHO 6: INFORMAÇÕES PRÁTICAS

#### Padrões de Pergunta

```
- "Onde tem [serviço] [próximo]?"
- "Como [ação] [no Uruguai/em [cidade]]?"
- "Onde fica [local]?"
- "Tem [serviço] perto de [local]?"
- "Como chegar em [local]?"
```

#### Contexto de Ativação

- ✅ Pergunta sobre serviços locais
- ✅ Pergunta sobre localização
- ✅ Pergunta sobre como fazer algo
- ✅ Informações não disponíveis no Dossiê

#### Ação de Busca

```javascript
search_web([
  "[serviço] próximo [local] [cidade]",
  "como [ação] [cidade] Uruguai",
  "[serviço] [bairro] [cidade]",
  "onde [serviço] [cidade]"
])
```

#### Exemplo Prático

**Pergunta**: "Onde é o estacionamento mais próximo do Mercado del Puerto?"

**Gatilho Ativado**: ✅ INFORMAÇÕES PRÁTICAS

**Busca Executada**:

```
search_web([
  "estacionamento Mercado del Puerto Montevidéu",
  "estacionamento próximo Mercado del Puerto",
  "onde estacionar Mercado del Puerto"
])
```

---

## 🚫 GATILHOS DE NÃO-BUSCA (NÃO BUSCAR)

### NÃO BUSCAR: Informações Estáticas do Dossiê

#### Padrões de Pergunta

```
- "Que horas é o casamento no Fasano?"
- "Onde fica o Barradas Hotel?"
- "Qual o telefone do Primuseum?"
- "Que dia vamos para Punta del Este?"
```

#### Contexto

- ❌ Informação está no Dossiê (`01_BASE_CONHECIMENTO/`)
- ❌ Informação é estática e não muda
- ❌ Reservas já confirmadas

#### Ação

```
Consultar Dossiê diretamente
NÃO buscar na web
```

---

### NÃO BUSCAR: Eventos Confirmados

#### Padrões de Pergunta

```
- "O que está incluído no tour da Pizzorno?"
- "O Primuseum tem transfer?"
- "Qual o dress code do casamento?"
```

#### Contexto

- ❌ Evento já está reservado e confirmado
- ❌ Informações já estão no Dossiê
- ❌ Não requer validação dinâmica

#### Ação

```
Consultar `03_reservas_confirmadas.md`
NÃO buscar na web
```

---

## 🎯 MATRIZ DE DECISÃO RÁPIDA

| Tipo de Pergunta | Buscar? | Prioridade | Exemplo |
|------------------|---------|------------|---------|
| Clima/Tempo | ✅ SIM | ALTA | "Como está o tempo hoje?" |
| Trânsito | ✅ SIM | ALTA | "Quanto tempo até o evento?" |
| Horários | ✅ SIM | MÉDIA | "Está aberto agora?" |
| Câmbio | ✅ SIM | MÉDIA | "Qual a cotação hoje?" |
| Disponibilidade | ✅ SIM | ALTA | "Tem mesa disponível?" |
| Informações Práticas | ✅ SIM | BAIXA | "Onde tem estacionamento?" |
| Itinerário Fixo | ❌ NÃO | - | "Que dia vamos a PDE?" |
| Reservas Confirmadas | ❌ NÃO | - | "Horário do Primuseum?" |
| Contatos do Dossiê | ❌ NÃO | - | "Telefone do Casapueblo?" |

---

## ⚡ GATILHOS PROATIVOS (BUSCAR ANTECIPADAMENTE)

### Validação Proativa para Eventos Críticos

O sistema deve buscar automaticamente antes de eventos importantes:

#### Evento: Casamento (22/11 - 16:30)

**Gatilho Proativo**: Buscar clima 2-3 horas antes do evento

**Busca Automática**:

```
search_web([
  "previsão do tempo Punta del Este 22 novembro 16h30",
  "clima Hotel Fasano Las Piedras hoje"
])
```

#### Evento: Primuseum (23/11 - 20:30)

**Gatilho Proativo**: Validar funcionamento no domingo

**Busca Automática**:

```
search_web([
  "Primuseum Montevidéu horário de funcionamento Domingo",
  "Primuseum Montevidéu aberto hoje 23 novembro 2025"
])
```

---

## 🔗 REFERÊNCIAS CRUZADAS

- **Protocolo de Busca**: `01_protocolo_busca_web.md`
- **Categorias de Perguntas**: `03_categorias_perguntas.md`
- **Reservas Confirmadas**: `01_BASE_CONHECIMENTO/03_reservas_confirmadas.md`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ COMPLETO E VALIDADO
