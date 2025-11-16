# 📐 Estrutura de Nomenclatura e Melhores Práticas de Engenharia de Contexto

## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 🎯 OBJETIVO

Este documento define a estrutura completa de nomenclatura, organização e melhores práticas para engenharia de contexto aplicada ao GEM Expert da viagem de Aline Torres e Luiz Fernando Sena ao Uruguai (18-25 Novembro 2025).

---

## 📁 ESTRUTURA DE NOMENCLATURA

### 1. Hierarquia de Arquivos e Pastas

```
gem_viagem_uruguai/
├── 00_GEM_STRUCTURE/          # Documentação estrutural e referência
│   ├── 00_nomenclatura_e_melhores_praticas.md
│   ├── 01_indice_mestre_importacao.md
│   └── 02_checklist_validacao.md
│
├── 01_BASE_CONHECIMENTO/      # Conhecimento estático e imutável
│   ├── 01_dossie_viagem_completo.md
│   ├── 02_itinerario_detalhado.md
│   ├── 03_reservas_confirmadas.md
│   ├── 04_logistica_transporte.md
│   └── 05_perfil_viajantes.md
│
├── 02_CONTEXTO_DINAMICO/      # Informações que requerem validação em tempo real
│   ├── 01_protocolo_busca_web.md
│   ├── 02_gatilhos_validacao.md
│   ├── 03_categorias_perguntas.md
│   └── 04_fontes_conhecimento_validadas.md
│
├── 03_WORKFLOWS/              # Workflows e instruções do GEM
│   ├── 01_workflow_concierge_principal.json
│   ├── 02_workflow_backup_contingencia.json
│   └── 03_exemplos_interacao.md
│
├── 04_DADOS_ESTRUTURADOS/     # Dados em formato estruturado (JSON, CSV)
│   ├── 01_hoteis_montevideo.json
│   ├── 02_reservas_estruturadas.json
│   ├── 03_contatos_essenciais.json
│   └── 04_roteiro_timeline.json
│
└── 99_REFERENCIAS/            # Documentos de referência e histórico
    ├── 01_documentos_originais/
    └── 02_fontes_pesquisa/
```

### 2. Padrão de Nomenclatura de Arquivos

#### Formato Geral

```
[PREFIXO]_[CATEGORIA]_[DESCRICAO]_[DATA_OPCIONAL].[EXTENSAO]
```

#### Prefixos Numéricos (Ordem de Importação)

- `00_` = Documentação estrutural
- `01_` = Base de conhecimento (prioridade máxima)
- `02_` = Contexto dinâmico
- `03_` = Workflows
- `04_` = Dados estruturados
- `99_` = Referências e histórico

#### Categorias

- `GEM_STRUCTURE` = Estrutura e documentação do GEM
- `BASE_CONHECIMENTO` = Conhecimento estático
- `CONTEXTO_DINAMICO` = Protocolos de busca e validação
- `WORKFLOWS` = Workflows e instruções
- `DADOS_ESTRUTURADOS` = JSON, CSV, dados tabulares

#### Extensões

- `.md` = Documentação Markdown
- `.json` = Dados estruturados (workflows, configurações)
- `.csv` = Dados tabulares
- `.txt` = Texto simples

#### Exemplos Válidos

```
✅ 01_dossie_viagem_completo.md
✅ 02_protocolo_busca_web.md
✅ 03_workflow_concierge_principal.json
✅ 04_hoteis_montevideo.json
❌ dossie_viagem.md (sem prefixo)
❌ workflow.json (sem categoria)
```

---

## 🏗️ MELHORES PRÁTICAS DE ENGENHARIA DE CONTEXTO

### 1. Princípios Fundamentais

#### 1.1. Separação de Responsabilidades

- **Conhecimento Estático**: Informações imutáveis (itinerário, reservas, contatos)
- **Conhecimento Dinâmico**: Informações que mudam (clima, trânsito, horários)
- **Protocolos de Ação**: Como buscar e validar informações dinâmicas

#### 1.2. Hierarquia de Importância

1. **Crítico** (01_): Informações essenciais para funcionamento
2. **Importante** (02_): Protocolos e validações
3. **Suporte** (03_): Workflows e exemplos
4. **Referência** (99_): Histórico e fontes

#### 1.3. Granularidade Adequada

- **Um conceito por arquivo**: Cada arquivo deve ter um propósito único e claro
- **Tamanho ideal**: 200-2000 linhas por arquivo
- **Modularidade**: Arquivos podem ser importados independentemente

### 2. Estrutura de Documentos Markdown

#### 2.1. Template Padrão

```markdown
# [TÍTULO PRINCIPAL]
## [Subtítulo Descritivo]

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | [BASE_CONHECIMENTO / CONTEXTO_DINAMICO / WORKFLOW] |
| **Prioridade** | [CRÍTICO / IMPORTANTE / SUPORTE] |
| **Última Atualização** | [DATA] |
| **Versão** | [X.Y.Z] |
| **Dependências** | [Lista de arquivos relacionados] |

---

## [CONTEÚDO PRINCIPAL]

[Conteúdo estruturado com seções claras]

---

## 🔗 REFERÊNCIAS CRUZADAS

- Relacionado a: `[arquivo_relacionado.md]`
- Usado por: `[arquivo_que_usa.md]`
- Depende de: `[arquivo_dependencia.md]`
```

#### 2.2. Formatação Padrão

**Títulos e Seções:**

- Use `#` para título principal (único por arquivo)
- Use `##` para seções principais
- Use `###` para subseções
- Use `####` para detalhes dentro de subseções

**Tabelas:**

- Sempre use tabelas para dados estruturados
- Inclua cabeçalhos descritivos
- Use formatação consistente

**Código e Exemplos:**

- Use blocos de código com linguagem especificada
- JSON deve ser válido e formatado
- Exemplos devem ser realistas e testáveis

**Ênfase:**

- `**Negrito**` para informações críticas
- `*Itálico*` para observações
- `> Citação` para alertas importantes

### 3. Estrutura de Dados JSON

#### 3.1. Schema Padrão para Workflows

```json
{
  "metadata": {
    "name": "nome_workflow",
    "description": "Descrição clara e concisa",
    "version": "1.0.0",
    "created_at": "2025-11-16",
    "updated_at": "2025-11-16",
    "author": "GEM Expert System",
    "dependencies": []
  },
  "tools": [],
  "instructions": "",
  "examples": []
}
```

#### 3.2. Schema Padrão para Dados Estruturados

```json
{
  "metadata": {
    "source": "origem_dos_dados",
    "last_updated": "2025-11-16",
    "validated": true
  },
  "data": []
}
```

### 4. Convenções de Conteúdo

#### 4.1. Nomes de Viajantes

- **Sempre use**: "Aline Torres" e "Luiz Fernando Sena"
- **Formato curto**: "Aline" e "Luiz Fernando"
- **Formato conjunto**: "Aline e Luiz Fernando"

#### 4.2. Datas e Horários

- **Formato ISO**: `2025-11-18` para datas
- **Formato legível**: `18 de novembro de 2025` ou `18/11/2025`
- **Horários**: `10:35` (formato 24h)
- **Fuso horário**: UTC-3 (Uruguai)

#### 4.3. Locais e Destinos

- **Montevidéu**: Abreviação `MVD` quando apropriado
- **Punta del Este**: Abreviação `PDE` quando apropriado
- **Sempre especifique**: Bairro quando relevante (Punta Carretas, Pocitos)

#### 4.4. Moedas e Valores

- **Real Brasileiro**: `R$` ou `BRL`
- **Peso Uruguaio**: `UY$` ou `UYU`
- **Sempre inclua**: Conversão quando relevante

### 5. Protocolos de Validação

#### 5.1. Informações Estáticas

- ✅ **Validar antes de importar**: Verificar datas, horários, contatos
- ✅ **Marcar como confirmado**: Usar tag `[CONFIRMADO]` ou `[VALIDADO]`
- ✅ **Documentar fonte**: Sempre incluir origem da informação

#### 5.2. Informações Dinâmicas

- ⚠️ **Sempre buscar**: Clima, trânsito, horários de funcionamento
- ⚠️ **Validar em tempo real**: Usar ferramentas de busca web
- ⚠️ **Documentar gatilhos**: Listar quando buscar é obrigatório

#### 5.3. Contingências

- 🔄 **Plano B sempre**: Ter alternativas para eventos críticos
- 🔄 **Documentar ações**: O que fazer se informação não estiver disponível
- 🔄 **Alertas proativos**: Avisar sobre possíveis problemas

### 6. Versionamento e Atualização

#### 6.1. Controle de Versão

- **Formato**: `MAJOR.MINOR.PATCH` (ex: `1.2.3`)
- **MAJOR**: Mudanças estruturais significativas
- **MINOR**: Adição de novas seções ou informações
- **PATCH**: Correções e ajustes menores

#### 6.2. Histórico de Mudanças

```markdown
## 📝 CHANGELOG

### [Versão] - [Data]
- **Adicionado**: [O que foi adicionado]
- **Modificado**: [O que foi modificado]
- **Removido**: [O que foi removido]
- **Corrigido**: [O que foi corrigido]
```

### 7. Checklist de Qualidade

Antes de considerar um documento pronto para importação:

- [ ] Nomenclatura segue padrão definido
- [ ] Metadados completos e atualizados
- [ ] Estrutura hierárquica clara
- [ ] Referências cruzadas documentadas
- [ ] Dados validados e confirmados
- [ ] Exemplos testáveis incluídos
- [ ] Formatação consistente
- [ ] Sem informações contraditórias
- [ ] Links e referências funcionais
- [ ] Versionamento atualizado

---

## 📊 MATRIZ DE DEPENDÊNCIAS

### Ordem de Importação Recomendada

1. **Fase 1 - Estrutura** (00_)
   - Nomenclatura e práticas
   - Índice mestre
   - Checklist

2. **Fase 2 - Base de Conhecimento** (01_)
   - Dossiê completo
   - Itinerário detalhado
   - Reservas confirmadas
   - Logística transporte
   - Perfil viajantes

3. **Fase 3 - Contexto Dinâmico** (02_)
   - Protocolo busca web
   - Gatilhos validação
   - Categorias perguntas
   - Fontes conhecimento

4. **Fase 4 - Workflows** (03_)
   - Workflow principal
   - Workflow backup
   - Exemplos interação

5. **Fase 5 - Dados Estruturados** (04_)
   - Hotéis
   - Reservas JSON
   - Contatos
   - Timeline

---

## 🎓 GLOSSÁRIO DE TERMOS

- **GEM**: Google Expert Model (modelo de especialista)
- **Base de Conhecimento**: Informações estáticas e imutáveis
- **Contexto Dinâmico**: Informações que requerem validação em tempo real
- **Workflow**: Sequência de instruções e exemplos para o GEM
- **Gatilho**: Condição que dispara uma ação (ex: busca na web)
- **Dossiê**: Compilação completa de informações sobre a viagem
- **Protocolo**: Conjunto de regras e procedimentos definidos

---

## 📌 NOTAS FINAIS

Esta estrutura foi projetada para:

- ✅ Facilitar importação no GEM Expert
- ✅ Manter organização clara e escalável
- ✅ Permitir manutenção e atualização fácil
- ✅ Garantir consistência entre documentos
- ✅ Suportar versionamento e rastreabilidade

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ APROVADO PARA IMPORTAÇÃO
