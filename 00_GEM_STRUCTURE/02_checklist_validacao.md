# ✅ Checklist de Validação Pré-Importação
## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | GEM_STRUCTURE |
| **Prioridade** | IMPORTANTE |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | `00_nomenclatura_e_melhores_praticas.md` |

---

## ✅ CHECKLIST GERAL

### Estrutura de Arquivos

- [ ] Todos os arquivos seguem nomenclatura padrão (`[PREFIXO]_[CATEGORIA]_[DESCRICAO].[EXT]`)
- [ ] Estrutura de pastas criada corretamente
- [ ] Arquivos organizados nas pastas corretas
- [ ] Nenhum arquivo duplicado ou órfão

### Metadados dos Documentos

- [ ] Todos os documentos Markdown têm seção de metadados
- [ ] Metadados completos (Tipo, Prioridade, Última Atualização, Versão, Dependências)
- [ ] Versões consistentes e atualizadas
- [ ] Dependências mapeadas corretamente

### Conteúdo

- [ ] Informações críticas presentes e corretas
- [ ] Datas e horários validados
- [ ] Contatos verificados e atualizados
- [ ] Sem informações contraditórias entre documentos
- [ ] Referências cruzadas funcionais

---

## 📁 CHECKLIST POR FASE

### FASE 1: ESTRUTURA E DOCUMENTAÇÃO (00_)

#### Arquivos
- [ ] `00_nomenclatura_e_melhores_praticas.md` existe e está completo
- [ ] `01_indice_mestre_importacao.md` existe e está atualizado
- [ ] `02_checklist_validacao.md` existe (este documento)

#### Validação
- [ ] Nomenclatura definida e clara
- [ ] Melhores práticas documentadas
- [ ] Índice mestre reflete estrutura atual
- [ ] Checklist completo e testável

---

### FASE 2: BASE DE CONHECIMENTO (01_)

#### Arquivos
- [ ] `01_dossie_viagem_completo.md` existe e está completo
- [ ] `02_itinerario_detalhado.md` existe e está completo
- [ ] `03_reservas_confirmadas.md` existe e está completo
- [ ] `04_logistica_transporte.md` existe e está completo
- [ ] `05_perfil_viajantes.md` existe e está completo

#### Validação de Conteúdo

**Dossiê Completo:**
- [ ] Informações dos viajantes corretas
- [ ] Período e destinos corretos
- [ ] Logística de voos completa
- [ ] Hospedagem documentada
- [ ] Transporte documentado
- [ ] Clima e vestiário documentados
- [ ] Informações financeiras corretas
- [ ] Contatos essenciais presentes

**Itinerário Detalhado:**
- [ ] Todos os 8 dias documentados
- [ ] Horários corretos
- [ ] Atividades descritas
- [ ] Status de cada atividade claro
- [ ] Observações relevantes incluídas

**Reservas Confirmadas:**
- [ ] Todas as 5 reservas críticas documentadas
- [ ] Datas e horários corretos
- [ ] Custos atualizados
- [ ] Contatos de emergência presentes
- [ ] Status de pagamento claro

**Logística Transporte:**
- [ ] Informações do aluguel de carro completas
- [ ] Regras críticas de condução documentadas
- [ ] Rotas principais mapeadas
- [ ] Estacionamentos documentados
- [ ] Informações sobre pedágios claras

**Perfil Viajantes:**
- [ ] Informações individuais completas
- [ ] Preferências documentadas
- [ ] Perfil do casal descrito
- [ ] Expectativas e objetivos claros

---

### FASE 3: CONTEXTO DINÂMICO (02_)

#### Arquivos
- [ ] `01_protocolo_busca_web.md` existe e está completo
- [ ] `02_gatilhos_validacao.md` existe e está completo
- [ ] `03_categorias_perguntas.md` existe e está completo
- [ ] `04_fontes_conhecimento_validadas.md` existe e está completo

#### Validação
- [ ] Protocolos de busca definidos claramente
- [ ] Gatilhos especificados e testáveis
- [ ] Categorias de perguntas bem definidas
- [ ] Fontes validadas e confiáveis

---

### FASE 4: WORKFLOWS (03_)

#### Arquivos
- [ ] `01_workflow_concierge_principal.json` existe e é JSON válido
- [ ] `02_workflow_backup_contingencia.json` existe (se aplicável)
- [ ] `03_exemplos_interacao.md` existe e está completo

#### Validação JSON
- [ ] JSON válido (sem erros de sintaxe)
- [ ] Schema consistente
- [ ] Metadados presentes
- [ ] Instruções claras e completas
- [ ] Exemplos testáveis

---

### FASE 5: DADOS ESTRUTURADOS (04_)

#### Arquivos
- [ ] `01_hoteis_montevideo.json` existe e é JSON válido
- [ ] `02_reservas_estruturadas.json` existe e é JSON válido
- [ ] `03_contatos_essenciais.json` existe e é JSON válido
- [ ] `04_roteiro_timeline.json` existe e é JSON válido

#### Validação JSON
- [ ] JSON válido (sem erros de sintaxe)
- [ ] Schema consistente entre arquivos
- [ ] Dados completos e corretos
- [ ] Metadados presentes

---

## 🔍 VALIDAÇÃO DE INTEGRIDADE

### Consistência de Dados

- [ ] Datas consistentes entre documentos
- [ ] Horários consistentes entre documentos
- [ ] Contatos consistentes entre documentos
- [ ] Custos consistentes entre documentos
- [ ] Locais consistentes entre documentos

### Referências Cruzadas

- [ ] Todas as referências cruzadas funcionais
- [ ] Arquivos referenciados existem
- [ ] Links internos corretos
- [ ] Nenhuma referência quebrada

### Completude

- [ ] Todas as informações críticas presentes
- [ ] Nenhuma informação faltante crítica
- [ ] Ações pendentes documentadas
- [ ] Observações relevantes incluídas

---

## 🧪 TESTES DE VALIDAÇÃO

### Teste 1: Validação de Datas
- [ ] Todas as datas no formato correto
- [ ] Sequência temporal lógica
- [ ] Nenhuma data impossível (ex: 30 de fevereiro)
- [ ] Fuso horário considerado

### Teste 2: Validação de Horários
- [ ] Horários no formato 24h
- [ ] Sequência lógica dentro de cada dia
- [ ] Tempo suficiente entre atividades
- [ ] Horários de voos corretos

### Teste 3: Validação de Contatos
- [ ] Formato de telefone correto (+598 para Uruguai)
- [ ] Emails válidos (formato correto)
- [ ] Contatos essenciais presentes

### Teste 4: Validação de Custos
- [ ] Valores em moeda correta (R$ ou UYU)
- [ ] Conversões corretas quando aplicável
- [ ] Totais calculados corretamente

### Teste 5: Validação de Rotas
- [ ] Distâncias realistas
- [ ] Tempos de deslocamento realistas
- [ ] Rotas possíveis (não contraditórias)

---

## 📊 RELATÓRIO DE VALIDAÇÃO

### Status Geral

| Fase | Arquivos | Validados | Pendentes | Status |
|------|----------|-----------|-----------|--------|
| Fase 1 | 3 | [ ] | [ ] | ⏳ |
| Fase 2 | 5 | [ ] | [ ] | ⏳ |
| Fase 3 | 4 | [ ] | [ ] | ⏳ |
| Fase 4 | 3 | [ ] | [ ] | ⏳ |
| Fase 5 | 4 | [ ] | [ ] | ⏳ |
| **TOTAL** | **19** | **0** | **19** | **⏳** |

### Problemas Encontrados

| Tipo | Descrição | Arquivo | Severidade | Status |
|------|-----------|---------|------------|--------|
| - | - | - | - | - |

### Observações

- [ ] Nenhuma observação crítica
- [ ] Observações menores documentadas abaixo

---

## ✅ APROVAÇÃO PARA IMPORTAÇÃO

### Critérios de Aprovação

- [ ] ✅ Todos os arquivos críticos validados
- [ ] ✅ Nenhum problema crítico encontrado
- [ ] ✅ Dados consistentes e corretos
- [ ] ✅ Estrutura completa e organizada
- [ ] ✅ Referências funcionais

### Aprovado por

| Campo | Valor |
|-------|-------|
| **Data** | |
| **Responsável** | |
| **Assinatura** | |

---

## 📝 NOTAS DE VALIDAÇÃO

_Use este espaço para documentar observações durante a validação:_

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ⏳ AGUARDANDO VALIDAÇÃO

