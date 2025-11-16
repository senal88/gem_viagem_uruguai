# ✅ Template: Validação de Documentos
## Checklist Completo de Validação Pré-Commit

---

## 🎯 QUANDO USAR ESTE TEMPLATE

Use este template antes de fazer commit de qualquer documento no repositório.

**Aplicável para:**
- ✅ Validação pré-commit
- ✅ Revisão de documentos
- ✅ Validação de mudanças
- ✅ Garantia de qualidade

---

## 📋 CHECKLIST DE VALIDAÇÃO

### 1. Nomenclatura

- [ ] Nome do arquivo segue padrão: `[PREFIXO]_[CATEGORIA]_[DESCRICAO].[EXT]`
- [ ] Prefixo numérico correto (00_, 01_, 02_, etc.)
- [ ] Categoria descritiva e clara
- [ ] Descrição específica e não ambígua
- [ ] Extensão correta (.md, .json, .csv)

**Exemplos:**
```
✅ 01_dossie_viagem_completo.md
✅ 02_protocolo_busca_web.md
❌ dossie.md (sem prefixo e categoria)
❌ protocolo.md (sem categoria)
```

---

### 2. Metadados

- [ ] Seção de metadados presente
- [ ] Tipo correto (BASE_CONHECIMENTO, CONTEXTO_DINAMICO, etc.)
- [ ] Prioridade definida (CRÍTICO, IMPORTANTE, SUPORTE)
- [ ] Data de atualização correta
- [ ] Versão no formato X.Y.Z
- [ ] Dependências listadas (se houver)

**Template de Metadados:**
```markdown
## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | [TIPO] |
| **Prioridade** | [PRIORIDADE] |
| **Última Atualização** | [DATA] |
| **Versão** | [X.Y.Z] |
| **Dependências** | [LISTA] |
```

---

### 3. Estrutura

- [ ] Título principal claro e descritivo
- [ ] Subtítulo com contexto (GEM Expert - Viagem...)
- [ ] Seção de objetivo presente
- [ ] Hierarquia de títulos lógica (## → ### → ####)
- [ ] Não mais de 4 níveis de profundidade
- [ ] Seções não muito longas (<50 linhas cada)

**Hierarquia Correta:**
```markdown
# Título Principal (único)
## Seção Principal
### Subseção
#### Detalhe
```

---

### 4. Conteúdo

- [ ] Conteúdo completo e coerente
- [ ] Informações precisas e validadas
- [ ] Sem informações contraditórias
- [ ] Exemplos quando apropriado
- [ ] Tabelas formatadas corretamente
- [ ] Listas bem estruturadas
- [ ] Código formatado corretamente (se houver)

**Tabelas:**
```markdown
| Campo | Valor |
|-------|-------|
| **Campo 1** | Valor 1 |
| **Campo 2** | Valor 2 |
```

---

### 5. Referências Cruzadas

- [ ] Referências cruzadas documentadas
- [ ] Caminhos relativos corretos
- [ ] Arquivos referenciados existem
- [ ] Nenhuma referência quebrada
- [ ] Relacionamentos bidirecionais (quando aplicável)

**Formato:**
```markdown
## 🔗 REFERÊNCIAS CRUZADAS

- **Documento Relacionado**: `../01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md`
- **Usado por**: `02_contexto_dinamico.md`
```

---

### 6. Formatação

- [ ] Markdown válido
- [ ] Sem erros de sintaxe
- [ ] Espaçamento consistente
- [ ] Emojis usados consistentemente (se aplicável)
- [ ] Links funcionais (se houver)
- [ ] Imagens com alt text (se houver)

---

### 7. Versionamento

- [ ] Versão atualizada se houver mudanças
- [ ] Changelog atualizado (se aplicável)
- [ ] Data de atualização correta
- [ ] Status atualizado (✅ COMPLETO / ⏳ PENDENTE / ⚠️ PARCIAL)

**Formato de Versão:**
```
MAJOR.MINOR.PATCH
- MAJOR: Mudanças estruturais significativas
- MINOR: Adição de novas seções
- PATCH: Correções e ajustes
```

---

### 8. Consistência com Repositório

- [ ] Segue padrões estabelecidos
- [ ] Consistente com outros documentos
- [ ] Nomenclatura alinhada com guia
- [ ] Estrutura alinhada com templates
- [ ] Formatação consistente

---

## 🔍 VALIDAÇÃO ESPECÍFICA POR TIPO

### BASE_CONHECIMENTO

- [ ] Informações estáticas e imutáveis
- [ ] Sem referências a informações dinâmicas
- [ ] Dados validados e confirmados
- [ ] Sem ações pendentes críticas

### CONTEXTO_DINAMICO

- [ ] Protocolos de busca definidos
- [ ] Gatilhos claramente especificados
- [ ] Fontes validadas e confiáveis
- [ ] Exemplos práticos incluídos

### GEM_STRUCTURE

- [ ] Documentação estrutural clara
- [ ] Referências a outros documentos corretas
- [ ] Guias e templates atualizados
- [ ] Checklists completos

---

## ✅ APROVAÇÃO FINAL

### Critérios de Aprovação

- [ ] ✅ Todos os itens críticos validados
- [ ] ✅ Nenhum problema crítico encontrado
- [ ] ✅ Dados consistentes e corretos
- [ ] ✅ Estrutura completa e organizada
- [ ] ✅ Referências funcionais

### Aprovado por

| Campo | Valor |
|-------|-------|
| **Data** | [DATA] |
| **Responsável** | [NOME] |
| **Status** | ✅ APROVADO |

---

## 📝 NOTAS DE VALIDAÇÃO

_Use este espaço para documentar observações durante a validação:_

---

## 🔗 REFERÊNCIAS

- **Checklist Validação Principal**: `00_GEM_STRUCTURE/02_checklist_validacao.md`
- **Guia Nomenclatura**: `../02_guias/02_guia_nomenclatura.md`
- **Template Criação**: `02_template_criacao_documento.md`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ TEMPLATE VALIDADO

