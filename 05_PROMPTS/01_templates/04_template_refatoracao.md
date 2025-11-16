# 🔄 Template: Refatoração de Documentos
## Guia para Refatorar Documentos Existentes

---

## 🎯 QUANDO USAR ESTE TEMPLATE

Use este template ao refatorar documentos existentes no repositório.

**Aplicável para:**
- ✅ Atualizar documentos para novos padrões
- ✅ Reorganizar estrutura de documentos
- ✅ Consolidar informações dispersas
- ✅ Melhorar organização e clareza

---

## 📋 PROCESSO DE REFATORAÇÃO

### PASSO 1: Análise do Documento Atual

**Checklist de Análise:**

- [ ] Identificar problemas estruturais
- [ ] Identificar informações desatualizadas
- [ ] Identificar padrões não seguidos
- [ ] Mapear dependências
- [ ] Identificar oportunidades de melhoria

**Documentar:**

```markdown
## 📊 ANÁLISE DO DOCUMENTO ATUAL

### Problemas Identificados
1. [Problema 1]
2. [Problema 2]
3. [Problema 3]

### Informações Desatualizadas
- [Item 1]
- [Item 2]

### Padrões Não Seguidos
- [Padrão 1]
- [Padrão 2]

### Dependências
- Depende de: [arquivo1.md]
- Usado por: [arquivo2.md, arquivo3.md]
```

---

### PASSO 2: Planejamento da Refatoração

**Definir:**

1. **Objetivos da Refatoração**
   - O que se quer alcançar
   - Por que é necessário

2. **Mudanças Planejadas**
   - Lista de mudanças específicas
   - Ordem de execução

3. **Impacto Esperado**
   - Documentos afetados
   - Referências a atualizar

**Template:**

```markdown
## 🎯 PLANEJAMENTO DA REFATORAÇÃO

### Objetivos
1. [Objetivo 1]
2. [Objetivo 2]

### Mudanças Planejadas
1. [Mudança 1]
2. [Mudança 2]
3. [Mudança 3]

### Impacto Esperado
- Documentos afetados: [LISTA]
- Referências a atualizar: [LISTA]
- Versão nova: [X.Y.Z]
```

---

### PASSO 3: Execução da Refatoração

**Ordem Recomendada:**

1. **Backup** (se necessário)
2. **Atualizar Metadados**
3. **Reorganizar Estrutura**
4. **Atualizar Conteúdo**
5. **Atualizar Referências**
6. **Validar Mudanças**

**Checklist de Execução:**

- [ ] Backup criado (se necessário)
- [ ] Metadados atualizados
- [ ] Estrutura reorganizada
- [ ] Conteúdo atualizado
- [ ] Referências atualizadas
- [ ] Validação executada

---

### PASSO 4: Atualização de Referências

**Processo:**

1. **Identificar Referências**
   - Documentos que referenciam este
   - Documentos referenciados por este

2. **Atualizar Referências**
   - Atualizar caminhos se necessário
   - Atualizar conteúdo das referências
   - Verificar funcionamento

3. **Validar**
   - Todas as referências funcionais
   - Nenhuma referência quebrada

**Template:**

```markdown
## 🔗 ATUALIZAÇÃO DE REFERÊNCIAS

### Referências a Atualizar
- [arquivo1.md]: Atualizar caminho de [antigo] para [novo]
- [arquivo2.md]: Atualizar menção de [antigo] para [novo]

### Status
- [ ] Todas as referências atualizadas
- [ ] Nenhuma referência quebrada
- [ ] Validação completa executada
```

---

### PASSO 5: Documentação de Mudanças

**Changelog:**

```markdown
## 📝 CHANGELOG

### [Versão Nova] - [Data]
- **Refatorado**: [O que foi refatorado]
- **Adicionado**: [O que foi adicionado]
- **Modificado**: [O que foi modificado]
- **Removido**: [O que foi removido]
- **Corrigido**: [O que foi corrigido]

### Mudanças Detalhadas
1. [Mudança detalhada 1]
2. [Mudança detalhada 2]
3. [Mudança detalhada 3]
```

---

## ✅ CHECKLIST DE REFATORAÇÃO

### Pré-Refatoração

- [ ] Análise completa do documento atual
- [ ] Planejamento detalhado
- [ ] Impacto mapeado
- [ ] Backup criado (se necessário)

### Durante Refatoração

- [ ] Metadados atualizados
- [ ] Estrutura reorganizada
- [ ] Conteúdo atualizado
- [ ] Referências atualizadas
- [ ] Validação contínua

### Pós-Refatoração

- [ ] Validação completa executada
- [ ] Changelog documentado
- [ ] Versão atualizada
- [ ] Referências verificadas
- [ ] Commit com mensagem descritiva

---

## 📝 EXEMPLO COMPLETO

### Exemplo: Refatorar Documento de Base de Conhecimento

**Documento Original:**
```
01_BASE_CONHECIMENTO/01_dossie_viagem.md
Versão: 1.0.0
```

**Análise:**

```markdown
## 📊 ANÁLISE DO DOCUMENTO ATUAL

### Problemas Identificados
1. Nome não segue padrão completo (falta "completo")
2. Falta seção de preferências gastronômicas
3. Referências cruzadas incompletas
4. Versão desatualizada

### Mudanças Planejadas
1. Renomear: 01_dossie_viagem.md → 01_dossie_viagem_completo.md
2. Adicionar seção de preferências gastronômicas
3. Completar referências cruzadas
4. Atualizar versão: 1.0.0 → 1.1.0
```

**Execução:**

1. Renomear arquivo
2. Adicionar seção de preferências
3. Atualizar referências cruzadas
4. Atualizar metadados (versão 1.1.0)
5. Validar

**Changelog:**

```markdown
### 1.1.0 - 2025-11-16
- **Adicionado**: Seção de preferências gastronômicas
- **Modificado**: Referências cruzadas completadas
- **Refatorado**: Nome do arquivo para padrão completo
```

---

## 🔗 REFERÊNCIAS

- **Template Validação**: `03_template_validacao.md`
- **Guia Manutenção**: `../02_guias/04_guia_manutencao_repositorio.md`
- **Melhores Práticas**: `../04_melhores_praticas/01_praticas_engenharia_contexto.md`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ TEMPLATE VALIDADO

