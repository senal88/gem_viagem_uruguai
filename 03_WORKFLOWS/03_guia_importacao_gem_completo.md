# 📋 Guia Completo de Importação na GEM
## Concierge de Viagem Elite - Uruguai 2025

---

## 🎯 INFORMAÇÕES PARA PREENCHER NA GEM

### 1. Nome do GEM

```
concierge_pro_uruguai_aline_luiz_2025
```

**Formato:** `concierge_[destino]_[viajantes]_[ano]`

**Por quê?** O nome deve ser um identificador único, em `snake_case`, que resume o propósito exato do GEM.

---

### 2. Descrição

```
Workflow (Nível Elite) para o Concierge e HUB de Inteligência em Tempo Real da viagem de Aline Torres e Luiz Fernando Sena ao Uruguai (18-25 Nov 2025). Otimizado para síntese de múltiplas fontes de busca e gerenciamento proativo de contingências.
```

**Formato:** Um resumo claro da missão do GEM, seu público-alvo (para quem ele serve) e o principal valor agregado (o que ele faz).

---

### 3. Ferramentas (Tools)

**Ferramenta Obrigatória:**

```json
{
  "name": "google:search",
  "description": "Pesquisa, sintetiza e cruza informações de múltiplas fontes da web em tempo real (clima, trânsito, horários, disponibilidade, menus, críticas recentes, notícias locais) para fornecer respostas detalhadas e proativas."
}
```

**Como adicionar na GEM:**
- Na seção "Tools" ou "Ferramentas"
- Adicionar `google:search` como ferramenta disponível
- Configurar para uso automático quando necessário

---

### 4. Instruções

**Arquivo de Referência:** `02_instrucoes_gem_formatadas.md`

**Conteúdo Completo:** Copiar e colar o conteúdo completo do arquivo `02_instrucoes_gem_formatadas.md` na seção "Instruções" do GEM.

**Resumo do que contém:**
- Identidade do concierge
- Protocolo de atuação (fluxo interativo)
- Gatilhos obrigatórios para busca na web
- Princípios de execução
- Regras específicas de interação
- Exemplos de interação
- Regras críticas de condução

---

### 5. Conhecimento (Knowledge Base)

**Estrutura de Arquivos para Importar:**

A base de conhecimento deve ser uma **coleção de arquivos granulares e bem estruturados**. Importar os seguintes arquivos na ordem indicada:

#### 5.1. Arquivo Principal: Dossiê Completo

**Arquivo:** `01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md`

**Conteúdo:**
- Informações dos Viajantes (Nomes, Documentos, Contato de Emergência)
- Visão Geral (Período, Destinos, Fuso Horário)
- Logística de Voos (Companhia, Códigos, Horários, Bagagem, Pagamento)
- Seguro Viagem (Apólice, Contato)
- Informações Financeiras (Moeda, Câmbio, Orçamento)
- Hospedagem
- Transporte
- Clima e Vestiário
- Contatos Essenciais
- Distâncias e Tempos de Deslocamento
- Eventos e Reservas Críticas
- Documentação e Segurança

**Prioridade:** CRÍTICO

---

#### 5.2. Itinerário Detalhado

**Arquivo:** `01_BASE_CONHECIMENTO/02_itinerario_detalhado.md`

**Conteúdo:**
- Tabelas dia a dia (Data, Dia da Semana, Local Principal)
- Para cada dia: Horário, Atividade, Local, Status (✅ Confirmado, 💡 Sugestão, ⏳ Pendente), Observações
- Resumo de Status
- Referências Cruzadas

**Prioridade:** CRÍTICO

---

#### 5.3. Reservas Confirmadas

**Arquivo:** `01_BASE_CONHECIMENTO/03_reservas_confirmadas.md`

**Conteúdo:**
- Lista detalhada de cada reserva crítica (Hotéis, Restaurantes, Tours)
- Para cada reserva: Data, Horário, Local, Endereço, Custo, Código de Confirmação, Contato, Dress Code (se aplicável)
- Tabela Resumo de Custos
- Ações Pendentes Relacionadas
- Contatos de Emergência

**Prioridade:** CRÍTICO

---

#### 5.4. Logística de Transporte

**Arquivo:** `01_BASE_CONHECIMENTO/04_logistica_transporte.md`

**Conteúdo:**
- Detalhes do Aluguel de Carro (Plataforma, Período, Local de Retirada/Devolução)
- Regras Críticas de Condução (Ex: Faróis ligados, Tolerância Zero Álcool, Pedágios)
- Rotas Principais (Ex: Aeroporto → Hotel, MVD → PDE) com tempo médio e distância
- Informações de Estacionamento (Hotéis, Pontos Turísticos)
- Combustível e Pedágios
- Emergências e Assistência
- Aplicativos Úteis

**Prioridade:** CRÍTICO

---

#### 5.5. Perfil dos Viajantes

**Arquivo:** `01_BASE_CONHECIMENTO/05_perfil_viajantes.md`

**Conteúdo:**
- Perfil Individual (Aline Torres e Luiz Fernando Sena)
- Preferências de Viagem (Estilo, Interesses, Ritmo)
- Perfil do Casal (Interesses compartilhados)
- Expectativas e Objetivos da Viagem (Ex: Evento principal, experiências desejadas)
- Preferências de Vestiário (Estilos, Dress codes)
- Experiências Desejadas
- Comunicação e Preferências

**Prioridade:** IMPORTANTE

---

## 📝 CHECKLIST DE IMPORTAÇÃO

### Passo 1: Criar o GEM
- [ ] Acessar plataforma GEM
- [ ] Criar novo GEM
- [ ] Preencher nome: `concierge_pro_uruguai_aline_luiz_2025`

### Passo 2: Configurar Descrição
- [ ] Copiar descrição completa (seção 2 acima)
- [ ] Colar no campo "Descrição"

### Passo 3: Adicionar Ferramentas
- [ ] Adicionar ferramenta `google:search`
- [ ] Configurar descrição da ferramenta
- [ ] Habilitar uso automático quando necessário

### Passo 4: Configurar Instruções
- [ ] Abrir arquivo `02_instrucoes_gem_formatadas.md`
- [ ] Copiar TODO o conteúdo
- [ ] Colar na seção "Instruções" do GEM
- [ ] Verificar formatação (markdown deve ser preservado)

### Passo 5: Importar Arquivos de Conhecimento
- [ ] Importar `01_dossie_viagem_completo.md` (CRÍTICO)
- [ ] Importar `02_itinerario_detalhado.md` (CRÍTICO)
- [ ] Importar `03_reservas_confirmadas.md` (CRÍTICO)
- [ ] Importar `04_logistica_transporte.md` (CRÍTICO)
- [ ] Importar `05_perfil_viajantes.md` (IMPORTANTE)

### Passo 6: Validar Importação
- [ ] Verificar se todos os arquivos foram importados corretamente
- [ ] Testar busca por informações específicas (ex: "Qual o número da reserva do hotel Barradas?")
- [ ] Testar gatilho de busca web (ex: "Qual a previsão do tempo para amanhã?")
- [ ] Verificar se o GEM responde contextualmente

### Passo 7: Testes Finais
- [ ] Perguntar sobre reserva confirmada (deve usar conhecimento estático)
- [ ] Perguntar sobre clima (deve usar busca web)
- [ ] Perguntar sobre trânsito (deve usar busca web)
- [ ] Perguntar sobre horário de funcionamento (deve usar busca web)
- [ ] Verificar tom de voz (sofisticado, prestativo, elite)

---

## 🎯 ORDEM DE PRIORIDADE DE IMPORTAÇÃO

1. **CRÍTICO (Importar Primeiro):**
   - `01_dossie_viagem_completo.md`
   - `02_itinerario_detalhado.md`
   - `03_reservas_confirmadas.md`
   - `04_logistica_transporte.md`

2. **IMPORTANTE (Importar em Seguida):**
   - `05_perfil_viajantes.md`

3. **OPCIONAL (Se necessário):**
   - Arquivos em `04_DADOS_ESTRUTURADOS/` (JSON estruturados)
   - Arquivos em `99_REFERENCIAS/` (documentos originais)

---

## 📍 LOCALIZAÇÃO DOS ARQUIVOS

```
gem_viagem_uruguai/
├── 01_BASE_CONHECIMENTO/
│   ├── 01_dossie_viagem_completo.md      ← CRÍTICO
│   ├── 02_itinerario_detalhado.md       ← CRÍTICO
│   ├── 03_reservas_confirmadas.md       ← CRÍTICO
│   ├── 04_logistica_transporte.md        ← CRÍTICO
│   └── 05_perfil_viajantes.md            ← IMPORTANTE
│
└── 03_WORKFLOWS/
    ├── 01_workflow_concierge_principal.json
    ├── 02_instrucoes_gem_formatadas.md   ← INSTRUÇÕES
    └── 03_guia_importacao_gem_completo.md ← ESTE ARQUIVO
```

---

## ✅ VALIDAÇÃO PÓS-IMPORTAÇÃO

Após importar tudo, fazer as seguintes perguntas de teste:

### Teste 1: Conhecimento Estático
**Pergunta:** "Qual o número da reserva do hotel Barradas?"
**Resposta Esperada:** "6417055860" (deve vir do conhecimento estático, SEM busca web)

### Teste 2: Busca Web (Clima)
**Pergunta:** "Qual a previsão do tempo para o casamento no Fasano amanhã?"
**Resposta Esperada:** Deve usar `google:search` e fornecer previsão detalhada

### Teste 3: Contextualização
**Pergunta:** "O que temos hoje?"
**Resposta Esperada:** Deve identificar o dia atual e consultar o itinerário para responder contextualmente

### Teste 4: Plano B (Proatividade)
**Pergunta:** "Está chovendo muito aqui. O que fazer?"
**Resposta Esperada:** Deve consultar o itinerário do dia, identificar atividades externas, e sugerir alternativas proativamente

### Teste 5: Regras Críticas
**Pergunta:** "Estamos indo dirigir para Punta del Este. O que preciso saber?"
**Resposta Esperada:** Deve relembrar as regras críticas (faróis, álcool, pedágios)

---

## 🔄 ATUALIZAÇÕES FUTURAS

Quando houver atualizações nos arquivos de conhecimento:

1. Atualizar o arquivo correspondente em `01_BASE_CONHECIMENTO/`
2. Reimportar o arquivo atualizado na GEM
3. Testar se as mudanças foram aplicadas corretamente

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ GUIA COMPLETO PARA IMPORTAÇÃO

