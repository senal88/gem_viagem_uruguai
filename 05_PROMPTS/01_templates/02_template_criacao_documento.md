# 📄 Template: Criação de Novo Documento
## Guia Completo para Criar Documentos no GEM Expert

---

## 🎯 QUANDO USAR ESTE TEMPLATE

Use este template ao criar qualquer novo documento no repositório do GEM Expert.

**Aplicável para:**
- ✅ Novos documentos em qualquer pasta
- ✅ Documentação adicional
- ✅ Guias e tutoriais
- ✅ Documentos de referência

---

## 📋 PROCESSO PASSO A PASSO

### PASSO 1: Definir Nomenclatura

**Consulte**: `02_guias/02_guia_nomenclatura.md`

**Formato**: `[PREFIXO]_[CATEGORIA]_[DESCRICAO].[EXT]`

**Exemplo:**
```
✅ 01_dossie_viagem_completo.md
✅ 02_protocolo_busca_web.md
❌ dossie_viagem.md (sem prefixo)
❌ protocolo.md (sem categoria)
```

### PASSO 2: Escolher Localização

**Estrutura de Pastas:**
```
00_GEM_STRUCTURE/      → Documentação estrutural
01_BASE_CONHECIMENTO/  → Conhecimento estático
02_CONTEXTO_DINAMICO/  → Contexto dinâmico
03_WORKFLOWS/          → Workflows e instruções
04_DADOS_ESTRUTURADOS/ → Dados estruturados (JSON, CSV)
05_PROMPTS/            → Sistema de prompts
99_REFERENCIAS/        → Referências e histórico
```

### PASSO 3: Usar Template Apropriado

**Para Documentos de Contexto:**
- Use: `01_template_engenharia_contexto.md`

**Para Documentos Gerais:**
- Use: Este template (`02_template_criacao_documento.md`)

### PASSO 4: Preencher Estrutura Base

```markdown
# [TÍTULO PRINCIPAL]
## [Subtítulo] | GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | [TIPO] |
| **Prioridade** | [PRIORIDADE] |
| **Última Atualização** | [DATA] |
| **Versão** | 1.0.0 |
| **Dependências** | [LISTA] |

---

## 🎯 OBJETIVO

[Descrição clara do objetivo]

---

## [CONTEÚDO PRINCIPAL]

[Desenvolver conteúdo aqui]

---

## 🔗 REFERÊNCIAS CRUZADAS

- **Relacionado a**: `[arquivo.md]`
- **Usado por**: `[arquivo.md]`

---

**Última atualização**: [DATA]  
**Versão**: 1.0.0  
**Status**: ✅ COMPLETO
```

### PASSO 5: Desenvolver Conteúdo

**Princípios:**
1. **Clareza**: Seja claro e direto
2. **Estrutura**: Use hierarquia lógica
3. **Completude**: Inclua todas as informações necessárias
4. **Consistência**: Siga padrões estabelecidos
5. **Referências**: Documente relacionamentos

### PASSO 6: Validar Antes de Commit

**Use**: `03_template_validacao.md`

**Checklist:**
- [ ] Nomenclatura correta
- [ ] Metadados completos
- [ ] Estrutura hierárquica clara
- [ ] Referências cruzadas funcionais
- [ ] Sem erros de formatação
- [ ] Versão atualizada

---

## 📝 EXEMPLO COMPLETO

### Exemplo: Criar Novo Documento de Guia

**1. Nomenclatura:**
```
02_guia_importacao_gem.md
```

**2. Localização:**
```
03_WORKFLOWS/02_guia_importacao_gem.md
```

**3. Estrutura:**

```markdown
# 📥 Guia de Importação no GEM Expert
## Passo a Passo Completo | GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | WORKFLOW |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | `00_GEM_STRUCTURE/01_indice_mestre_importacao.md` |

---

## 🎯 OBJETIVO

Este guia fornece instruções passo a passo para importar todos os documentos do GEM Expert no sistema.

---

## 📋 PRÉ-REQUISITOS

- [ ] Acesso ao sistema GEM Expert
- [ ] Todos os documentos validados
- [ ] Checklist de validação completo

---

## 🚀 PROCESSO DE IMPORTAÇÃO

### Fase 1: Estrutura

[Conteúdo detalhado...]

### Fase 2: Base de Conhecimento

[Conteúdo detalhado...]

---

## 🔗 REFERÊNCIAS CRUZADAS

- **Índice Mestre**: `00_GEM_STRUCTURE/01_indice_mestre_importacao.md`
- **Checklist**: `00_GEM_STRUCTURE/02_checklist_validacao.md`

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0  
**Status**: ✅ COMPLETO
```

---

## 🎓 BOAS PRÁTICAS

### Nomenclatura

- ✅ Use prefixos numéricos para ordem
- ✅ Use categorias descritivas
- ✅ Use descrições claras
- ❌ Evite abreviações ambíguas
- ❌ Evite caracteres especiais

### Estrutura

- ✅ Mantenha hierarquia lógica
- ✅ Use seções claras e descritivas
- ✅ Agrupe informações relacionadas
- ❌ Evite níveis muito profundos (>4 níveis)
- ❌ Evite seções muito longas (>50 linhas)

### Conteúdo

- ✅ Seja específico e claro
- ✅ Use exemplos quando útil
- ✅ Documente decisões importantes
- ❌ Evite informações redundantes
- ❌ Evite jargão desnecessário

---

## 🔗 REFERÊNCIAS

- **Template Engenharia de Contexto**: `01_template_engenharia_contexto.md`
- **Guia Nomenclatura**: `../02_guias/02_guia_nomenclatura.md`
- **Template Validação**: `03_template_validacao.md`

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0  
**Status**: ✅ TEMPLATE VALIDADO

