# 📝 Categorias de Perguntas Inteligentes
## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | CONTEXTO_DINAMICO |
| **Prioridade** | IMPORTANTE |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | `01_protocolo_busca_web.md`, `02_gatilhos_validacao.md` |

---

## 🎯 OBJETIVO

Este documento categoriza tipos de perguntas que o GEM Expert pode receber, definindo padrões de reconhecimento, processamento e resposta para cada categoria.

---

## 📊 CATEGORIAS PRINCIPAIS

### CATEGORIA 1: CLIMA & PREVISÃO DO TEMPO

#### Padrões de Reconhecimento

**Palavras-chave:**
- clima, tempo, temperatura, chuva, vento, sol, nublado
- previsão, previsão do tempo, como está o tempo
- frio, quente, calor, fresco
- guarda-chuva, casaco, roupas

**Padrões de Pergunta:**
```
- "Qual a previsão para [evento/local/data]?"
- "Como está o tempo [hoje/amanhã/agora]?"
- "Vai chover [data/horário]?"
- "Preciso de casaco [hoje à noite]?"
- "Está ventando muito?"
- "Qual a temperatura [local/data]?"
```

#### Processamento

1. **Extrair contexto:**
   - Local mencionado (ou inferir do itinerário)
   - Data/horário mencionado
   - Evento relacionado (se houver)

2. **Ativar gatilho:**
   - ✅ Sempre buscar (informação dinâmica)

3. **Buscar informações:**
   - Previsão específica para data/hora/local
   - Temperatura máxima e mínima
   - Velocidade do vento
   - Chance de chuva
   - Índice UV

#### Formato de Resposta

```
[ACUSO CONTEXTO]
"Verifiquei a previsão para [LOCAL] [DATA] às [HORA]..."

[INFORMAÇÃO VALIDADA]
- Temperatura: [X-Y]°C
- Céu: [condição]
- Vento: [velocidade] km/h
- Chance de chuva: [X]%

[CONTEXTUALIZAÇÃO]
"Considerando que vocês têm [EVENTO] às [HORA]..."

[RECOMENDAÇÃO]
- Vestiário adequado
- Acessórios necessários
- Ajustes logísticos
```

#### Exemplos

**Pergunta**: "Qual a previsão para o casamento no Fasano hoje?"

**Resposta**:
> "Perfeito! Acabo de verificar a previsão para o Fasano Las Piedras hoje (Sábado, 22/11) às 16h30:
>
> **Clima Esperado:**
> - Temperatura: 22-24°C
> - Céu: Parcialmente nublado a ensolarado
> - Vento: Moderado (10-15 km/h)
> - Chance chuva: <10%
>
> **Recomendações:**
> - O traje esporte fino está perfeito
> - Levar pashmina ou estola (vento ao anoitecer)
> - Protetor solar se houver foto ao ar livre"

---

### CATEGORIA 2: DISTÂNCIA & TRÂNSITO

#### Padrões de Reconhecimento

**Palavras-chave:**
- tempo, distância, quanto tempo leva
- trânsito, tráfego, congestionado
- rota, caminho, como chegar
- sair, partir, que horas sair

**Padrões de Pergunta:**
```
- "Quanto tempo leva de [origem] para [destino]?"
- "Como está o trânsito [agora/para [horário]]?"
- "Que horas devemos sair para [evento]?"
- "Tem muito trânsito [rota]?"
- "Qual a melhor rota para [destino]?"
```

#### Processamento

1. **Extrair contexto:**
   - Origem (ou inferir localização atual)
   - Destino mencionado
   - Horário de chegada necessário (se evento)

2. **Ativar gatilho:**
   - ✅ Sempre buscar (informação em tempo real)

3. **Buscar informações:**
   - Tempo estimado de viagem
   - Condições de trânsito
   - Rotas alternativas
   - Distância

#### Formato de Resposta

```
[ACUSO CONTEXTO]
"Para chegarem ao [DESTINO] às [HORA]..."

[INFORMAÇÃO VALIDADA]
- Tempo estimado: [X] minutos
- Distância: [X] km
- Trânsito: [condição]
- Rota recomendada: [rota]

[RECOMENDAÇÃO LOGÍSTICA]
"Saiam do [ORIGEM] por volta das [HORA_SAIDA] 
para chegarem com [MARGEM] de antecedência."
```

#### Exemplos

**Pergunta**: "Que horas devemos sair do hotel para a festa pré-wedding no L'Incanto?"

**Resposta**:
> "Para chegarem ao L'Incanto às 18h30 com calma, recomendo:
>
> **Tempo de Deslocamento:**
> - Distância: ~5 km
> - Tempo estimado: 15-20 minutos (sem trânsito)
> - Trânsito esperado às 18h: Moderado
>
> **Recomendação:**
> - Saiam do Barradas Hotel por volta das **18h00**
> - Chegada estimada: 18h15-18h20
> - Tempo para estacionar e chegar ao restaurante: 10 min
> - Chegada final: 18h25-18h30 ✅"

---

### CATEGORIA 3: HORÁRIOS & FUNCIONAMENTO

#### Padrões de Reconhecimento

**Palavras-chave:**
- aberto, fechado, funcionamento
- horário, que horas, até que horas
- visita, visitar, acesso
- último acesso, fecha

**Padrões de Pergunta:**
```
- "[Local] está aberto [hoje/agora]?"
- "Até que horas [local] fica aberto?"
- "Que horas [local] abre?"
- "[Local] fecha que horas [hoje]?"
- "Posso visitar [local] [agora/hoje]?"
```

#### Processamento

1. **Extrair contexto:**
   - Local mencionado
   - Data/horário de interesse
   - Tipo de visita planejada

2. **Ativar gatilho:**
   - ✅ Buscar (horários podem variar)

3. **Buscar informações:**
   - Horário de abertura
   - Horário de fechamento
   - Último acesso permitido
   - Dias de funcionamento
   - Horários especiais

#### Formato de Resposta

```
[ACUSO CONTEXTO]
"Verifiquei o horário de funcionamento do [LOCAL]..."

[INFORMAÇÃO VALIDADA]
- Horário: [ABERTURA] até [FECHAMENTO]
- Último acesso: [HORA]
- Status atual: [ABERTO/FECHADO]

[VALIDAÇÃO]
"[LOCAL] está [ABERTO/FECHADO] agora.
Vocês [PODEM/NÃO PODEM] visitar."

[RECOMENDAÇÃO]
- Horário ideal de visita
- Tempo necessário
- Alternativas se fechado
```

#### Exemplos

**Pergunta**: "A Casapueblo já está aberta? Que horas fecha hoje?"

**Resposta**:
> "Verifiquei o horário de funcionamento da Casapueblo hoje:
>
> **Horários:**
> - Abertura: 10h00
> - Fechamento: Pôr do sol (~19h00)
> - Último acesso: ~18h00
> - Status: ✅ ABERTA agora
>
> **Recomendação:**
> - Para a 'Cerimônia do Sol', cheguem até 16h00
> - Explorem até 18h30
> - Participem da cerimônia às 19h00
> - Tempo total de visita: 1,5-2 horas"

---

### CATEGORIA 4: CÂMBIO & FINANÇAS

#### Padrões de Reconhecimento

**Palavras-chave:**
- cotação, câmbio, taxa
- trocar dinheiro, casa de câmbio
- real, peso, dólar
- melhor taxa, onde trocar

**Padrões de Pergunta:**
```
- "Qual a cotação do Real hoje?"
- "Onde trocar dinheiro com melhor taxa?"
- "Qual a melhor casa de câmbio [cidade]?"
- "Quanto está o dólar/peso hoje?"
- "Onde tem caixa eletrônico [próximo]?"
```

#### Processamento

1. **Extrair contexto:**
   - Moedas envolvidas (BRL/UYU)
   - Localização atual
   - Quantidade aproximada (se mencionada)

2. **Ativar gatilho:**
   - ✅ Sempre buscar (cotação dinâmica)

3. **Buscar informações:**
   - Taxa de câmbio atual
   - Comparação de taxas (comercial vs turística)
   - Locais para trocar
   - Caixas eletrônicos disponíveis

#### Formato de Resposta

```
[ACUSO CONTEXTO]
"Verifiquei a cotação atual do Real para Peso Uruguaio..."

[INFORMAÇÃO VALIDADA]
- Taxa comercial: 1 BRL = [X] UYU
- Taxa turística: 1 BRL = [Y] UYU (pior)
- Diferença: [Z]%

[LOCAIS RECOMENDADOS]
1. [MELHOR OPÇÃO]: [Local] - Taxa: [X] UYU
2. [ALTERNATIVA]: [Local] - Taxa: [Y] UYU

[RECOMENDAÇÃO]
"[MELHOR OPÇÃO] oferece a melhor taxa.
Recomendo trocar [QUANTIDADE] agora."
```

#### Exemplos

**Pergunta**: "Qual a melhor cotação do Real para Peso hoje? Estamos em Montevidéu."

**Resposta**:
> "Verifiquei a cotação atual:
>
> **Câmbio Hoje (23/11):**
> - Taxa Comercial (Wise): 1 BRL = 7.40-7.51 UYU
> - Taxa em casas de câmbio: 7.30-7.35 UYU (pior)
>
> **Locais Recomendados:**
> 1. **Caixas Eletrônicos** (MELHOR): Taxa automática melhor
> 2. Casas de câmbio: Taxa pior (~5% de diferença)
>
> **Recomendação:**
> - Sacar no caixa eletrônico AGORA (melhor taxa, 24h)
> - Levar R$500-1000 para Primuseum, almoço e compras"

---

### CATEGORIA 5: DISPONIBILIDADE & RESERVAS

#### Padrões de Reconhecimento

**Palavras-chave:**
- reserva, disponibilidade, mesa
- conseguir, tem vaga, lotado
- como reservar, telefone
- aceita reserva, precisa reservar

**Padrões de Pergunta:**
```
- "Conseguimos mesa em [restaurante] para [data/hora]?"
- "[Restaurante] tem disponibilidade [hoje/amanhã]?"
- "Como fazer reserva em [restaurante]?"
- "[Restaurante] aceita reserva online?"
- "Precisa reservar em [restaurante]?"
```

#### Processamento

1. **Extrair contexto:**
   - Restaurante/local mencionado
   - Data/horário desejado
   - Número de pessoas (se mencionado)

2. **Ativar gatilho:**
   - ✅ Buscar (disponibilidade dinâmica)

3. **Buscar informações:**
   - Disponibilidade para data/hora
   - Sistema de reserva (online ou telefone)
   - Telefone para reservas
   - Nível de lotação esperado

#### Formato de Resposta

```
[ACUSO CONTEXTO]
"Verifiquei a disponibilidade no [RESTAURANTE]..."

[INFORMAÇÃO VALIDADA]
- Disponibilidade: [DISPONÍVEL/NÃO DISPONÍVEL]
- Sistema de reserva: [ONLINE/TELEFONE]
- Telefone: [+598 XX XXX XXXX]

[INSTRUÇÕES]
"Para reservar:
1. [PASSO 1]
2. [PASSO 2]
3. [PASSO 3]"

[ALTERNATIVAS]
Se não disponível: Sugerir alternativas similares
```

#### Exemplos

**Pergunta**: "Conseguimos reserva no Lo de Tere para hoje à noite?"

**Resposta**:
> "Verifiquei a disponibilidade no Lo de Tere:
>
> **Status:**
> - Lo de Tere não possui sistema de reserva online
> - **É PRECISO LIGAR DIRETO** para confirmar
>
> **Contato:**
> - Telefone: +598 4244 0492
> - Horário: Aberto até ~23h30
> - Desconto: Antes de 20h30 (aplica)
>
> **Recomendação:**
> - Liguem AGORA (é sexta-feira, peak)
> - Peçam mesa para 20h00-20h30
> - Confirmem antes de sair do hotel"

---

### CATEGORIA 6: INFORMAÇÕES PRÁTICAS

#### Padrões de Reconhecimento

**Palavras-chave:**
- onde, como, localização
- próximo, perto, próximo de
- estacionamento, banco, farmácia
- como fazer, como chegar

**Padrões de Pergunta:**
```
- "Onde tem [serviço] [próximo]?"
- "Como [ação] [no Uruguai/em [cidade]]?"
- "Onde fica [local]?"
- "Tem [serviço] perto de [local]?"
- "Como chegar em [local]?"
```

#### Processamento

1. **Extrair contexto:**
   - Serviço/local procurado
   - Localização de referência
   - Tipo de informação necessária

2. **Ativar gatilho:**
   - ✅ Buscar (informação específica)

3. **Buscar informações:**
   - Localização exata
   - Endereço completo
   - Telefone de contato
   - Horários de funcionamento
   - Observações importantes

#### Formato de Resposta

```
[ACUSO CONTEXTO]
"Encontrei [SERVIÇO] próximo a [LOCAL]..."

[INFORMAÇÃO VALIDADA]
- Localização: [ENDEREÇO]
- Distância: [X] km / [Y] minutos
- Telefone: [+598 XX XXX XXXX]
- Horário: [HORÁRIOS]

[COMO CHEGAR]
"[INSTRUÇÕES DE DESLOCAMENTO]"

[OBSERVAÇÕES]
"[INFORMAÇÕES ADICIONAIS RELEVANTES]"
```

#### Exemplos

**Pergunta**: "Onde é o estacionamento mais próximo do Mercado del Puerto?"

**Resposta**:
> "Encontrei estacionamento próximo ao Mercado del Puerto:
>
> **Localização:**
> - Estacionamento próprio do Mercado del Puerto
> - Endereço: Próximo ao porto, Cidade Velha
> - Distância: A pé do mercado
>
> **Informações:**
> - Tipo: Estacionamento pago
> - Horário: Disponível durante funcionamento do mercado
> - Observação: Pode ficar cheio em horários de pico
>
> **Recomendação:**
> - Cheguem cedo (antes das 13h) para garantir vaga
> - Alternativa: Estacionamento público próximo à Rambla"

---

## 🎯 MATRIZ DE CATEGORIZAÇÃO RÁPIDA

| Palavra-chave Principal | Categoria | Buscar? |
|-------------------------|-----------|---------|
| clima, tempo, temperatura | CLIMA | ✅ SIM |
| trânsito, tempo leva, rota | TRÂNSITO | ✅ SIM |
| aberto, fechado, horário | HORÁRIOS | ✅ SIM |
| cotação, câmbio, trocar | CÂMBIO | ✅ SIM |
| reserva, disponibilidade, mesa | RESERVAS | ✅ SIM |
| onde, como, próximo | PRÁTICAS | ✅ SIM |
| itinerário, reserva confirmada | ESTÁTICO | ❌ NÃO |

---

## 🔗 REFERÊNCIAS CRUZADAS

- **Protocolo de Busca**: `01_protocolo_busca_web.md`
- **Gatilhos de Validação**: `02_gatilhos_validacao.md`
- **Base de Conhecimento**: `01_BASE_CONHECIMENTO/*`

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0  
**Status**: ✅ COMPLETO E VALIDADO

