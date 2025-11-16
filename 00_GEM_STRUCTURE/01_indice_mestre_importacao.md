# 📑 Índice Mestre de Importação

## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | GEM_STRUCTURE |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | Nenhuma (documento raiz) |

---

## 🎯 PROPÓSITO

Este documento serve como **índice mestre** para importação de todos os arquivos no GEM Expert. Ele define a ordem de importação, dependências e status de cada documento.

---

## 📦 ORDEM DE IMPORTAÇÃO RECOMENDADA

### FASE 1: ESTRUTURA E DOCUMENTAÇÃO (00_)

| Ordem | Arquivo | Tipo | Prioridade | Status | Descrição |
|-------|---------|------|------------|--------|-----------|
| 1 | `00_nomenclatura_e_melhores_praticas.md` | Estrutura | CRÍTICO | ✅ Pronto | Define padrões e convenções |
| 2 | `01_indice_mestre_importacao.md` | Estrutura | CRÍTICO | ✅ Pronto | Este documento |
| 3 | `02_checklist_validacao.md` | Estrutura | IMPORTANTE | ⏳ Pendente | Checklist de validação pré-importação |

---

### FASE 2: BASE DE CONHECIMENTO (01_)

| Ordem | Arquivo | Tipo | Prioridade | Status | Descrição |
|-------|---------|------|------------|--------|-----------|
| 4 | `01_dossie_viagem_completo.md` | Base | CRÍTICO | ⏳ A criar | Dossiê completo consolidado |
| 5 | `02_itinerario_detalhado.md` | Base | CRÍTICO | ⏳ A criar | Itinerário dia a dia detalhado |
| 6 | `03_reservas_confirmadas.md` | Base | CRÍTICO | ⏳ A criar | Todas as reservas confirmadas |
| 7 | `04_logistica_transporte.md` | Base | CRÍTICO | ⏳ A criar | Logística de transporte e condução |
| 8 | `05_perfil_viajantes.md` | Base | IMPORTANTE | ⏳ A criar | Perfil e preferências dos viajantes |

**Dependências Fase 2**: Nenhuma (pode ser importada independentemente)

---

### FASE 3: CONTEXTO DINÂMICO (02_)

| Ordem | Arquivo | Tipo | Prioridade | Status | Descrição |
|-------|---------|------|------------|--------|-----------|
| 9 | `01_protocolo_busca_web.md` | Dinâmico | CRÍTICO | ⏳ A criar | Protocolo completo de busca na web |
| 10 | `02_gatilhos_validacao.md` | Dinâmico | CRÍTICO | ⏳ A criar | Gatilhos que disparam busca |
| 11 | `03_categorias_perguntas.md` | Dinâmico | IMPORTANTE | ⏳ A criar | Categorização de perguntas |
| 12 | `04_fontes_conhecimento_validadas.md` | Dinâmico | IMPORTANTE | ⏳ A criar | Fontes validadas e confiáveis |

**Dependências Fase 3**: Fase 2 (base de conhecimento)

---

### FASE 4: WORKFLOWS (03_)

| Ordem | Arquivo | Tipo | Prioridade | Status | Descrição |
|-------|---------|------|------------|--------|-----------|
| 13 | `01_workflow_concierge_principal.json` | Workflow | CRÍTICO | ✅ Existe | Workflow principal do concierge |
| 14 | `02_workflow_backup_contingencia.json` | Workflow | IMPORTANTE | ⏳ A criar | Workflow para contingências |
| 15 | `03_exemplos_interacao.md` | Workflow | IMPORTANTE | ⏳ A criar | Exemplos de interação validados |

**Dependências Fase 4**: Fase 2 e Fase 3

---

### FASE 5: DADOS ESTRUTURADOS (04_)

| Ordem | Arquivo | Tipo | Prioridade | Status | Descrição |
|-------|---------|------|------------|--------|-----------|
| 16 | `01_hoteis_montevideo.json` | Dados | IMPORTANTE | ⏳ A criar | Hotéis em formato JSON |
| 17 | `02_reservas_estruturadas.json` | Dados | CRÍTICO | ⏳ A criar | Reservas em formato JSON |
| 18 | `03_contatos_essenciais.json` | Dados | CRÍTICO | ⏳ A criar | Contatos em formato JSON |
| 19 | `04_roteiro_timeline.json` | Dados | IMPORTANTE | ⏳ A criar | Timeline completa em JSON |

**Dependências Fase 5**: Fase 2 (base de conhecimento)

---

## 📊 MAPA DE DEPENDÊNCIAS

```
00_GEM_STRUCTURE/
├── 00_nomenclatura_e_melhores_praticas.md (INDEPENDENTE)
├── 01_indice_mestre_importacao.md (INDEPENDENTE)
└── 02_checklist_validacao.md (INDEPENDENTE)

01_BASE_CONHECIMENTO/
├── 01_dossie_viagem_completo.md (INDEPENDENTE)
├── 02_itinerario_detalhado.md (DEPENDE: dossie)
├── 03_reservas_confirmadas.md (DEPENDE: dossie)
├── 04_logistica_transporte.md (DEPENDE: dossie)
└── 05_perfil_viajantes.md (INDEPENDENTE)

02_CONTEXTO_DINAMICO/
├── 01_protocolo_busca_web.md (DEPENDE: base_conhecimento)
├── 02_gatilhos_validacao.md (DEPENDE: protocolo_busca)
├── 03_categorias_perguntas.md (DEPENDE: protocolo_busca)
└── 04_fontes_conhecimento_validadas.md (INDEPENDENTE)

03_WORKFLOWS/
├── 01_workflow_concierge_principal.json (DEPENDE: base + contexto)
├── 02_workflow_backup_contingencia.json (DEPENDE: workflow_principal)
└── 03_exemplos_interacao.md (DEPENDE: workflow_principal)

04_DADOS_ESTRUTURADOS/
├── 01_hoteis_montevideo.json (INDEPENDENTE)
├── 02_reservas_estruturadas.json (DEPENDE: reservas_confirmadas)
├── 03_contatos_essenciais.json (DEPENDE: dossie)
└── 04_roteiro_timeline.json (DEPENDE: itinerario)
```

---

## ✅ CHECKLIST DE IMPORTAÇÃO

### Pré-Importação

- [ ] Todos os arquivos seguem nomenclatura padrão
- [ ] Estrutura de pastas criada corretamente
- [ ] Metadados completos em cada documento
- [ ] Dependências mapeadas e resolvidas
- [ ] Dados validados e confirmados

### Durante Importação

- [ ] Importar Fase 1 completa
- [ ] Validar Fase 1 antes de prosseguir
- [ ] Importar Fase 2 na ordem especificada
- [ ] Validar Fase 2 antes de prosseguir
- [ ] Importar Fase 3 na ordem especificada
- [ ] Validar Fase 3 antes de prosseguir
- [ ] Importar Fase 4 na ordem especificada
- [ ] Validar Fase 4 antes de prosseguir
- [ ] Importar Fase 5 na ordem especificada
- [ ] Validação final completa

### Pós-Importação

- [ ] Testar consultas básicas
- [ ] Validar busca dinâmica (web)
- [ ] Verificar respostas contextuais
- [ ] Confirmar referências cruzadas
- [ ] Documentar problemas encontrados

---

## 🔍 VALIDAÇÃO POR FASE

### Fase 1 - Estrutura

**Critérios de Validação:**

- ✅ Documentos seguem template padrão
- ✅ Nomenclatura consistente
- ✅ Metadados completos

### Fase 2 - Base de Conhecimento

**Critérios de Validação:**

- ✅ Todas as informações críticas presentes
- ✅ Datas e horários corretos
- ✅ Contatos validados
- ✅ Sem informações contraditórias

### Fase 3 - Contexto Dinâmico

**Critérios de Validação:**

- ✅ Protocolos de busca definidos
- ✅ Gatilhos claramente especificados
- ✅ Fontes validadas e confiáveis

### Fase 4 - Workflows

**Critérios de Validação:**

- ✅ JSON válido e bem formatado
- ✅ Instruções claras e completas
- ✅ Exemplos testáveis

### Fase 5 - Dados Estruturados

**Critérios de Validação:**

- ✅ JSON válido
- ✅ Schema consistente
- ✅ Dados completos

---

## 📈 STATUS GERAL

| Fase | Arquivos Totais | Prontos | Pendentes | Progresso |
|------|----------------|---------|-----------|-----------|
| Fase 1 | 3 | 2 | 1 | 67% |
| Fase 2 | 5 | 0 | 5 | 0% |
| Fase 3 | 4 | 0 | 4 | 0% |
| Fase 4 | 3 | 1 | 2 | 33% |
| Fase 5 | 4 | 0 | 4 | 0% |
| **TOTAL** | **19** | **3** | **16** | **16%** |

---

## 🚀 PRÓXIMOS PASSOS

1. ✅ Criar estrutura de pastas completa
2. ⏳ Reestruturar documentos existentes seguindo nomenclatura
3. ⏳ Criar documentos faltantes da Fase 2
4. ⏳ Criar documentos faltantes da Fase 3
5. ⏳ Criar documentos faltantes da Fase 5
6. ⏳ Validar todos os documentos
7. ⏳ Executar importação no GEM Expert

---

## 📝 NOTAS DE IMPORTAÇÃO

### Comandos de Importação (Exemplo)

```bash
# Fase 1
import 00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md
import 00_GEM_STRUCTURE/01_indice_mestre_importacao.md

# Fase 2
import 01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md
import 01_BASE_CONHECIMENTO/02_itinerario_detalhado.md
# ... (continuar na ordem)
```

### Ordem Alternativa (Se necessário)

Se houver problemas de dependência, pode-se importar em ordem alfabética dentro de cada fase, mas **não é recomendado**.

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ ESTRUTURA DEFINIDA - AGUARDANDO CRIAÇÃO DE DOCUMENTOS
