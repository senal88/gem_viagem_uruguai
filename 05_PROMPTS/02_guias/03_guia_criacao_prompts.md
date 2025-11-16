# ✍️ Guia: Criação de Prompts Eficazes
## Como Criar Prompts que Geram Resultados Consistentes

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | PROMPTS_GUIA |
| **Prioridade** | IMPORTANTE |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | Nenhuma |

---

## 🎯 OBJETIVO

Este guia fornece diretrizes práticas para criar prompts eficazes que geram resultados consistentes e de alta qualidade para o GEM Expert.

---

## 🧠 PRINCÍPIOS FUNDAMENTAIS

### 1. Clareza

**Conceito**: Instruções claras e específicas geram melhores resultados.

**Boas Práticas:**
- ✅ Use linguagem direta e específica
- ✅ Evite ambiguidade
- ✅ Seja explícito sobre o que você quer
- ❌ Evite instruções vagas
- ❌ Evite múltiplas interpretações possíveis

**Exemplo:**

**Ruim:**
```
"Melhore o documento"
```

**Bom:**
```
"Reestruture o documento seguindo o template de engenharia de contexto:
1. Adicione seção de metadados completa
2. Organize conteúdo em seções hierárquicas
3. Adicione referências cruzadas
4. Valide nomenclatura antes de finalizar"
```

---

### 2. Contexto

**Conceito**: Sempre fornecer contexto suficiente para o modelo entender a tarefa.

**Elementos de Contexto:**

1. **Objetivo**: O que você quer alcançar
2. **Contexto do Projeto**: Informações sobre o projeto
3. **Padrões Estabelecidos**: Padrões que devem ser seguidos
4. **Exemplos**: Exemplos de saída esperada
5. **Restrições**: Limitações e regras

**Template de Contexto:**

```
OBJETIVO: [O que você quer alcançar]

CONTEXTO DO PROJETO:
- Projeto: GEM Expert - Viagem Aline & Luiz Fernando
- Tipo: Sistema de conhecimento estruturado
- Padrões: Seguir nomenclatura [PREFIXO]_[CATEGORIA]_[DESCRICAO].md

PADRÕES ESTABELECIDOS:
- [Padrão 1]
- [Padrão 2]
- [Padrão 3]

EXEMPLOS:
- [Exemplo 1]
- [Exemplo 2]

RESTRIÇÕES:
- [Restrição 1]
- [Restrição 2]
```

---

### 3. Estrutura

**Conceito**: Prompts estruturados são mais fáceis de processar.

**Estrutura Recomendada:**

```
1. CONTEXTO E OBJETIVO
   - Situação atual
   - O que precisa ser feito
   - Por que é importante

2. INSTRUÇÕES ESPECÍFICAS
   - Passo 1: [Instrução clara]
   - Passo 2: [Instrução clara]
   - Passo 3: [Instrução clara]

3. CRITÉRIOS DE VALIDAÇÃO
   - Critério 1: [Como validar]
   - Critério 2: [Como validar]

4. FORMATO DE SAÍDA ESPERADO
   - Formato: [Descrição]
   - Exemplo: [Exemplo concreto]
```

---

### 4. Validação

**Conceito**: Incluir critérios de validação no prompt.

**Critérios de Validação:**

- ✅ Checklist de validação
- ✅ Critérios de qualidade
- ✅ Exemplos de saída esperada
- ✅ Pontos de verificação

**Exemplo:**

```
CRITÉRIOS DE VALIDAÇÃO:
- [ ] Nomenclatura segue padrão [PREFIXO]_[CATEGORIA]_[DESCRICAO].md
- [ ] Metadados completos e corretos
- [ ] Estrutura hierárquica clara
- [ ] Referências cruzadas funcionais
- [ ] Versão atualizada
```

---

### 5. Iteração

**Conceito**: Prompts devem permitir refinamento iterativo.

**Estratégias:**

1. **Começar Amplo**: Prompt inicial mais geral
2. **Refinar Progressivamente**: Adicionar detalhes conforme necessário
3. **Validar Resultados**: Verificar se atende critérios
4. **Ajustar Prompt**: Refinar baseado em resultados

---

## 📝 TEMPLATES DE PROMPTS

### Template 1: Criação de Documento

```
Crie um novo documento [TIPO] para o GEM Expert seguindo os padrões estabelecidos.

CONTEXTO:
- Projeto: GEM Expert - Viagem Aline & Luiz Fernando
- Localização: [PASTA]/[NOME_ARQUIVO].md
- Tipo: [BASE_CONHECIMENTO / CONTEXTO_DINAMICO / etc.]

REQUISITOS:
1. Nomenclatura: [PREFIXO]_[CATEGORIA]_[DESCRICAO].md
2. Estrutura: Seguir template de engenharia de contexto
3. Metadados: Completos e corretos
4. Conteúdo: [Descrição do conteúdo necessário]

VALIDAÇÃO:
- [ ] Nomenclatura correta
- [ ] Metadados completos
- [ ] Estrutura hierárquica clara
- [ ] Referências cruzadas documentadas
```

---

### Template 2: Refatoração de Documento

```
Refatore o documento [ARQUIVO] seguindo os padrões atualizados do repositório.

DOCUMENTO ATUAL:
- Caminho: [CAMINHO]
- Versão atual: [VERSÃO]
- Problemas identificados: [LISTA]

MUDANÇAS NECESSÁRIAS:
1. [Mudança 1]
2. [Mudança 2]
3. [Mudança 3]

PADRÕES A APLICAR:
- [Padrão 1]
- [Padrão 2]

VALIDAÇÃO:
- [ ] Padrões aplicados
- [ ] Versão incrementada
- [ ] Referências atualizadas
- [ ] Changelog documentado
```

---

### Template 3: Validação de Documento

```
Valide o documento [ARQUIVO] usando o checklist completo de validação.

DOCUMENTO:
- Caminho: [CAMINHO]
- Tipo: [TIPO]

CHECKLIST:
1. Nomenclatura: [Validar padrão]
2. Metadados: [Validar completude]
3. Estrutura: [Validar hierarquia]
4. Conteúdo: [Validar qualidade]
5. Referências: [Validar funcionamento]

RELATÓRIO:
- Problemas encontrados: [LISTA]
- Recomendações: [LISTA]
- Status: [APROVADO / PENDENTE / REJEITADO]
```

---

## 🎓 EXEMPLOS PRÁTICOS

### Exemplo 1: Criar Documento de Base de Conhecimento

**Prompt:**

```
Crie um novo documento de base de conhecimento para o GEM Expert.

CONTEXTO:
- Projeto: GEM Expert - Viagem Aline & Luiz Fernando
- Localização: 01_BASE_CONHECIMENTO/06_preferencias_gastronomicas.md
- Tipo: BASE_CONHECIMENTO
- Prioridade: IMPORTANTE

CONTEÚDO NECESSÁRIO:
- Preferências gastronômicas de Aline e Luiz
- Restaurantes preferidos
- Tipos de comida favoritos
- Restrições alimentares (se houver)
- Orçamento para refeições

ESTRUTURA:
1. Metadados completos
2. Seção de preferências individuais
3. Seção de preferências do casal
4. Restaurantes recomendados
5. Referências cruzadas

VALIDAÇÃO:
- [ ] Nomenclatura: 06_preferencias_gastronomicas.md
- [ ] Metadados completos
- [ ] Estrutura hierárquica clara
- [ ] Referências cruzadas documentadas
```

---

### Exemplo 2: Refatorar Documento Existente

**Prompt:**

```
Refatore o documento 01_dossie_viagem_completo.md aplicando os padrões atualizados.

MUDANÇAS NECESSÁRIAS:
1. Adicionar seção de preferências gastronômicas
2. Atualizar metadados (versão 1.0.0 → 1.1.0)
3. Adicionar referências cruzadas para novo documento
4. Reorganizar seção de informações financeiras

PADRÕES A APLICAR:
- Template de engenharia de contexto atualizado
- Metadados completos
- Referências cruzadas bidirecionais

VALIDAÇÃO:
- [ ] Mudanças aplicadas
- [ ] Versão atualizada (1.1.0)
- [ ] Referências atualizadas
- [ ] Changelog documentado
```

---

## 🔗 REFERÊNCIAS

- **Template Criação**: `../01_templates/02_template_criacao_documento.md`
- **Template Validação**: `../01_templates/03_template_validacao.md`
- **Guia Engenharia de Contexto**: `01_guia_engenharia_contexto.md`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ GUIA COMPLETO

