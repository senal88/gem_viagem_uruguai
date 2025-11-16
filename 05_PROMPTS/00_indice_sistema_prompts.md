# 📚 Índice do Sistema de Prompts
## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | PROMPTS_INDICE |
| **Prioridade** | IMPORTANTE |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | Nenhuma |

---

## 🎯 OBJETIVO

Este documento serve como índice mestre do sistema de prompts, facilitando navegação e localização rápida de templates, guias e melhores práticas.

---

## 📁 ESTRUTURA COMPLETA

### 01_templates/ - Templates Reutilizáveis

| Arquivo | Descrição | Quando Usar |
|---------|-----------|-------------|
| `01_template_engenharia_contexto.md` | Template para documentos de contexto | Criar documentos de base/contexto |
| `02_template_criacao_documento.md` | Template geral para novos documentos | Criar qualquer novo documento |
| `03_template_validacao.md` | Checklist de validação | Validar antes de commit |
| `04_template_refatoracao.md` | Guia de refatoração | Refatorar documentos existentes |

---

### 02_guias/ - Guias de Referência

| Arquivo | Descrição | Quando Consultar |
|---------|-----------|------------------|
| `01_guia_engenharia_contexto.md` | Princípios de engenharia de contexto | Entender fundamentos |
| `02_guia_nomenclatura.md` | Padrões de nomenclatura | Criar/renomear arquivos |
| `03_guia_criacao_prompts.md` | Como criar prompts eficazes | Criar novos prompts |

---

### 03_exemplos/ - Exemplos Práticos

| Arquivo | Descrição | Quando Consultar |
|---------|-----------|------------------|
| `01_exemplo_criacao_base_conhecimento.md` | Exemplo completo de criação | Criar base de conhecimento |
| `02_exemplo_criacao_contexto_dinamico.md` | Exemplo de contexto dinâmico | Criar contexto dinâmico |
| `03_exemplo_refatoracao.md` | Exemplo de refatoração | Refatorar documentos |
| `04_exemplo_validacao.md` | Exemplo de validação | Validar documentos |

---

### 04_melhores_praticas/ - Práticas Consolidadas

| Arquivo | Descrição | Quando Consultar |
|---------|-----------|------------------|
| `01_praticas_engenharia_contexto.md` | Práticas essenciais | Referência rápida |

---

## 🚀 FLUXOS DE TRABALHO

### Fluxo 1: Criar Novo Documento

1. **Consultar**: `02_guias/02_guia_nomenclatura.md` (nomenclatura)
2. **Usar**: `01_templates/02_template_criacao_documento.md` (template)
3. **Seguir**: `04_melhores_praticas/01_praticas_engenharia_contexto.md` (práticas)
4. **Validar**: `01_templates/03_template_validacao.md` (validação)

---

### Fluxo 2: Refatorar Documento Existente

1. **Analisar**: Documento atual
2. **Usar**: `01_templates/04_template_refatoracao.md` (processo)
3. **Aplicar**: `04_melhores_praticas/01_praticas_engenharia_contexto.md` (práticas)
4. **Validar**: `01_templates/03_template_validacao.md` (validação)

---

### Fluxo 3: Criar Prompt Eficaz

1. **Ler**: `02_guias/03_guia_criacao_prompts.md` (fundamentos)
2. **Usar**: Templates em `01_templates/` (estrutura)
3. **Aplicar**: `04_melhores_praticas/01_praticas_engenharia_contexto.md` (práticas)
4. **Validar**: Resultado gerado

---

## 📊 MAPA DE RELACIONAMENTOS

```
README.md (Índice Geral)
    ↓
00_indice_sistema_prompts.md (Este documento)
    ↓
├── 01_templates/
│   ├── 01_template_engenharia_contexto.md
│   ├── 02_template_criacao_documento.md
│   ├── 03_template_validacao.md
│   └── 04_template_refatoracao.md
│
├── 02_guias/
│   ├── 01_guia_engenharia_contexto.md
│   ├── 02_guia_nomenclatura.md
│   └── 03_guia_criacao_prompts.md
│
├── 03_exemplos/
│   └── (a criar conforme necessidade)
│
└── 04_melhores_praticas/
    └── 01_praticas_engenharia_contexto.md
```

---

## 🎓 QUICK REFERENCE

### Nomenclatura Rápida

**Padrão**: `[PREFIXO]_[CATEGORIA]_[DESCRICAO].[EXT]`

**Prefixos**: 00_ (estrutura), 01_ (base), 02_ (dinâmico), 03_ (workflows), 04_ (dados), 05_ (prompts), 99_ (referências)

### Validação Rápida

- [ ] Nomenclatura correta
- [ ] Metadados completos
- [ ] Estrutura hierárquica clara
- [ ] Referências funcionais
- [ ] Versão atualizada

### Versionamento Rápido

**Formato**: `MAJOR.MINOR.PATCH`
- **MAJOR**: Mudanças estruturais
- **MINOR**: Novas seções
- **PATCH**: Correções

---

## 🔗 REFERÊNCIAS EXTERNAS

- **Nomenclatura Principal**: `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md`
- **Índice Mestre**: `00_GEM_STRUCTURE/01_indice_mestre_importacao.md`
- **Checklist Validação**: `00_GEM_STRUCTURE/02_checklist_validacao.md`

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0  
**Status**: ✅ ÍNDICE COMPLETO

