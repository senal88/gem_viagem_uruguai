# 📝 Guia: Nomenclatura do Repositório
## Padrões e Convenções de Nomenclatura para GEM Expert

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | PROMPTS_GUIA |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md` |

---

## 🎯 OBJETIVO

Este guia define os padrões completos de nomenclatura para arquivos, pastas e documentos no repositório do GEM Expert, garantindo consistência e facilitando navegação e manutenção.

---

## 📐 FORMATO PADRÃO DE NOMENCLATURA

### Estrutura Geral

```
[PREFIXO]_[CATEGORIA]_[DESCRICAO].[EXT]
```

**Componentes:**

1. **PREFIXO**: Número de 2 dígitos (00, 01, 02, etc.)
2. **CATEGORIA**: Tipo de conteúdo (em MAIÚSCULAS)
3. **DESCRICAO**: Descrição específica (em minúsculas, separado por underscore)
4. **EXT**: Extensão do arquivo (.md, .json, .csv)

---

## 🔢 PREFIXOS NUMÉRICOS

### Hierarquia de Prefixos

| Prefixo | Categoria | Descrição | Ordem Importação |
|---------|-----------|-----------|------------------|
| **00_** | Estrutura | Documentação estrutural | 1ª Fase |
| **01_** | Base Conhecimento | Conhecimento estático | 2ª Fase |
| **02_** | Contexto Dinâmico | Contexto dinâmico | 3ª Fase |
| **03_** | Workflows | Workflows e instruções | 4ª Fase |
| **04_** | Dados Estruturados | Dados JSON/CSV | 5ª Fase |
| **05_** | Prompts | Sistema de prompts | Suporte |
| **99_** | Referências | Histórico e referências | Não importa |

### Regras de Prefixos

- ✅ Sempre 2 dígitos (00, 01, 02...)
- ✅ Zero à esquerda obrigatório (01, não 1)
- ✅ Ordem sequencial dentro da categoria
- ❌ Não pular números (01, 02, 03... não 01, 03, 05)
- ❌ Não usar números duplicados

**Exemplos:**
```
✅ 00_nomenclatura_e_melhores_praticas.md
✅ 01_dossie_viagem_completo.md
✅ 02_protocolo_busca_web.md
❌ 1_dossie.md (sem zero à esquerda)
❌ 01_dossie_01.md (número duplicado)
```

---

## 📁 CATEGORIAS DE CONTEÚDO

### Categorias Principais

| Categoria | Uso | Exemplo |
|-----------|-----|---------|
| **GEM_STRUCTURE** | Documentação estrutural | `00_GEM_STRUCTURE/` |
| **BASE_CONHECIMENTO** | Conhecimento estático | `01_BASE_CONHECIMENTO/` |
| **CONTEXTO_DINAMICO** | Contexto dinâmico | `02_CONTEXTO_DINAMICO/` |
| **WORKFLOWS** | Workflows e instruções | `03_WORKFLOWS/` |
| **DADOS_ESTRUTURADOS** | Dados JSON/CSV | `04_DADOS_ESTRUTURADOS/` |
| **PROMPTS** | Sistema de prompts | `05_PROMPTS/` |
| **REFERENCIAS** | Histórico e referências | `99_REFERENCIAS/` |

### Categorias Específicas (Dentro de Arquivos)

Para documentos dentro das pastas principais, use categorias descritivas:

| Categoria | Uso | Exemplo |
|-----------|-----|---------|
| **dossie** | Dossiês completos | `01_dossie_viagem_completo.md` |
| **itinerario** | Itinerários | `02_itinerario_detalhado.md` |
| **reservas** | Reservas confirmadas | `03_reservas_confirmadas.md` |
| **logistica** | Logística e transporte | `04_logistica_transporte.md` |
| **perfil** | Perfis de viajantes | `05_perfil_viajantes.md` |
| **protocolo** | Protocolos de ação | `01_protocolo_busca_web.md` |
| **gatilhos** | Gatilhos de validação | `02_gatilhos_validacao.md` |
| **categorias** | Categorias de perguntas | `03_categorias_perguntas.md` |
| **fontes** | Fontes validadas | `04_fontes_conhecimento_validadas.md` |
| **workflow** | Workflows JSON | `01_workflow_concierge_principal.json` |
| **template** | Templates | `01_template_engenharia_contexto.md` |
| **guia** | Guias | `01_guia_engenharia_contexto.md` |

---

## 📝 DESCRIÇÕES

### Regras para Descrições

1. **Minúsculas**: Sempre usar minúsculas
2. **Underscore**: Separar palavras com underscore (_)
3. **Descritivo**: Ser específico e claro
4. **Conciso**: Evitar descrições muito longas
5. **Sem Espaços**: Nunca usar espaços

**Exemplos:**

```
✅ dossie_viagem_completo
✅ protocolo_busca_web
✅ reservas_confirmadas
❌ Dossie Viagem Completo (maiúsculas e espaços)
❌ protocolo-busca-web (hífen em vez de underscore)
❌ doc (muito genérico)
```

### Padrões de Descrição por Tipo

**Documentos de Base de Conhecimento:**
- `dossie_[tema]_completo`
- `itinerario_[tipo]`
- `reservas_[tipo]`
- `logistica_[aspecto]`
- `perfil_[quem]`

**Documentos de Contexto Dinâmico:**
- `protocolo_[acao]`
- `gatilhos_[tipo]`
- `categorias_[tipo]`
- `fontes_[tipo]_validadas`

**Documentos Estruturais:**
- `nomenclatura_e_[tema]`
- `indice_[tipo]`
- `checklist_[tipo]`
- `resumo_[tipo]`

---

## 📄 EXTENSÕES DE ARQUIVO

### Extensões Padronizadas

| Extensão | Uso | Exemplo |
|----------|-----|---------|
| **.md** | Documentação Markdown | `01_dossie_viagem_completo.md` |
| **.json** | Dados estruturados | `01_workflow_concierge_principal.json` |
| **.csv** | Dados tabulares | `01_hoteis_montevideo.csv` |
| **.txt** | Texto simples | `README.txt` (raramente usado) |

**Regras:**
- ✅ Sempre usar extensão apropriada
- ✅ Markdown para documentação (.md)
- ✅ JSON para dados estruturados (.json)
- ✅ CSV para dados tabulares (.csv)
- ❌ Não usar extensões genéricas sem necessidade

---

## 📁 NOMENCLATURA DE PASTAS

### Padrão de Pastas

```
[PREFIXO]_[CATEGORIA]
```

**Exemplos:**
```
00_GEM_STRUCTURE
01_BASE_CONHECIMENTO
02_CONTEXTO_DINAMICO
03_WORKFLOWS
04_DADOS_ESTRUTURADOS
05_PROMPTS
99_REFERENCIAS
99_OBSOLETOS
```

**Regras:**
- ✅ Prefixo numérico de 2 dígitos
- ✅ Categoria em MAIÚSCULAS
- ✅ Underscore separando prefixo e categoria
- ✅ Nomes descritivos e claros

---

## 🎯 EXEMPLOS COMPLETOS

### Exemplos Válidos

```
✅ 00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md
✅ 01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md
✅ 02_CONTEXTO_DINAMICO/01_protocolo_busca_web.md
✅ 03_WORKFLOWS/01_workflow_concierge_principal.json
✅ 04_DADOS_ESTRUTURADOS/01_hoteis_montevideo.json
✅ 05_PROMPTS/01_templates/01_template_engenharia_contexto.md
```

### Exemplos Inválidos

```
❌ GEM_STRUCTURE/nomenclatura.md (sem prefixo)
❌ 01_BASE_CONHECIMENTO/dossie.md (sem categoria)
❌ 01_BASE_CONHECIMENTO/01_Dossie Viagem.md (espaços e maiúsculas)
❌ 01_BASE_CONHECIMENTO/01-dossie-viagem.md (hífen em vez de underscore)
❌ 1_BASE_CONHECIMENTO/01_dossie.md (prefixo sem zero)
```

---

## 🔍 VALIDAÇÃO DE NOMENCLATURA

### Checklist de Validação

Antes de criar ou renomear arquivo:

- [ ] Prefixo numérico de 2 dígitos presente
- [ ] Categoria descritiva presente
- [ ] Descrição específica e clara
- [ ] Extensão correta (.md, .json, .csv)
- [ ] Sem espaços no nome
- [ ] Underscore separando componentes
- [ ] Minúsculas na descrição
- [ ] Consistente com outros arquivos da mesma categoria

---

## 🔄 RENOMEAÇÃO DE ARQUIVOS

### Processo de Renomeação

1. **Validar novo nome** usando checklist
2. **Atualizar referências cruzadas** em outros documentos
3. **Atualizar metadados** do arquivo renomeado
4. **Commitar mudança** com mensagem descritiva
5. **Verificar** se todas as referências foram atualizadas

**Exemplo de Commit:**
```
refactor: renomear documento seguindo nomenclatura padrão

- Renomeado: dossie.md → 01_dossie_viagem_completo.md
- Atualizadas referências cruzadas em 3 documentos
- Metadados atualizados
```

---

## 📚 REFERÊNCIAS

### Documentos Relacionados

- **Nomenclatura e Práticas**: `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md`
- **Template Criação**: `../01_templates/02_template_criacao_documento.md`
- **Template Validação**: `../01_templates/03_template_validacao.md`

---

## 🎓 BOAS PRÁTICAS

### Do's ✅

- ✅ Sempre usar prefixos numéricos
- ✅ Ser descritivo nas descrições
- ✅ Manter consistência dentro da categoria
- ✅ Validar antes de commitar
- ✅ Documentar mudanças de nomenclatura

### Don'ts ❌

- ❌ Não usar espaços
- ❌ Não usar maiúsculas na descrição
- ❌ Não usar hífen em vez de underscore
- ❌ Não criar nomes genéricos
- ❌ Não pular números na sequência

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ GUIA COMPLETO

