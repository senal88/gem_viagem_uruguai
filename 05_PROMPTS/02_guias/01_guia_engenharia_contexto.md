# 🏗️ Guia: Engenharia de Contexto
## Princípios e Práticas Fundamentais para GEM Expert

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

Este guia apresenta os princípios fundamentais de engenharia de contexto aplicados ao GEM Expert, fornecendo diretrizes práticas para criação, organização e manutenção de conhecimento estruturado.

---

## 🧠 PRINCÍPIOS FUNDAMENTAIS

### 1. Separação de Responsabilidades

**Conceito**: Separar claramente conhecimento estático de conhecimento dinâmico.

**Conhecimento Estático** (`01_BASE_CONHECIMENTO/`):
- Informações imutáveis durante a viagem
- Itinerário fixo, reservas confirmadas, contatos
- Não requer validação em tempo real
- Exemplo: "O casamento é no dia 22/11 às 16h30"

**Conhecimento Dinâmico** (`02_CONTEXTO_DINAMICO/`):
- Informações que mudam frequentemente
- Clima, trânsito, câmbio, disponibilidade
- Requer validação em tempo real via busca web
- Exemplo: "Qual a previsão do tempo para hoje?"

**Benefícios:**
- ✅ Eficiência: Não buscar o que já sabemos
- ✅ Precisão: Validar apenas o necessário
- ✅ Performance: Reduzir chamadas desnecessárias
- ✅ Manutenibilidade: Organização clara

---

### 2. Hierarquia de Importância

**Conceito**: Organizar documentos por nível de importância e dependência.

**Níveis:**

1. **CRÍTICO** (00_, 01_)
   - Essencial para funcionamento
   - Deve ser importado primeiro
   - Exemplo: Dossiê completo, itinerário

2. **IMPORTANTE** (02_, 03_)
   - Importante mas não bloqueante
   - Pode ser importado depois
   - Exemplo: Contexto dinâmico, workflows

3. **SUPORTE** (04_, 05_)
   - Documentação de apoio
   - Útil mas não essencial
   - Exemplo: Dados estruturados, prompts

**Aplicação:**
- Prefixos numéricos indicam ordem
- Dependências mapeadas claramente
- Importação sequencial respeitada

---

### 3. Granularidade Adequada

**Conceito**: Um conceito por arquivo, tamanho ideal 200-2000 linhas.

**Princípios:**

**Um Conceito por Arquivo:**
- ✅ Cada arquivo tem propósito único e claro
- ✅ Facilita manutenção e atualização
- ✅ Permite importação independente
- ❌ Evitar arquivos "catch-all"

**Tamanho Ideal:**
- ✅ 200-2000 linhas por arquivo
- ✅ Arquivos muito pequenos: considerar consolidação
- ✅ Arquivos muito grandes: considerar divisão
- ❌ Evitar arquivos >3000 linhas

**Exemplos:**

**Bom:**
```
01_dossie_viagem_completo.md        (~500 linhas)
02_itinerario_detalhado.md          (~400 linhas)
03_reservas_confirmadas.md          (~300 linhas)
```

**Ruim:**
```
01_tudo_junto.md                    (~5000 linhas) ❌
01_info_geral.md                    (~50 linhas)   ⚠️ (muito pequeno)
```

---

### 4. Validação Contínua

**Conceito**: Sempre validar antes de commitar.

**Processo:**

1. **Validação de Nomenclatura**
   - Verificar padrão de nome
   - Confirmar prefixo e categoria

2. **Validação de Estrutura**
   - Metadados completos
   - Hierarquia lógica
   - Referências funcionais

3. **Validação de Conteúdo**
   - Informações precisas
   - Sem contradições
   - Dados atualizados

4. **Validação de Consistência**
   - Alinhado com padrões
   - Consistente com outros documentos
   - Referências cruzadas corretas

**Ferramentas:**
- Checklist de validação (`03_template_validacao.md`)
- Validação manual
- Revisão por pares (quando aplicável)

---

### 5. Referências Cruzadas

**Conceito**: Documentar relacionamentos entre documentos.

**Tipos de Relacionamentos:**

1. **Dependência** (depende de)
   - Documento A depende de Documento B
   - B deve ser importado antes de A

2. **Uso** (usado por)
   - Documento A é usado por Documento B
   - B referencia informações de A

3. **Relacionamento** (relacionado a)
   - Documentos relacionados mas independentes
   - Podem ser importados em qualquer ordem

**Formato:**
```markdown
## 🔗 REFERÊNCIAS CRUZADAS

- **Depende de**: `../01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md`
- **Usado por**: `02_gatilhos_validacao.md`
- **Relacionado a**: `03_categorias_perguntas.md`
```

**Benefícios:**
- ✅ Rastreabilidade clara
- ✅ Manutenção facilitada
- ✅ Ordem de importação definida
- ✅ Impacto de mudanças visível

---

## 📐 PRÁTICAS ESPECÍFICAS

### Prática 1: Estrutura de Documentos

**Template Padrão:**
```markdown
# Título Principal
## Subtítulo | Contexto

## 📋 METADADOS
## 🎯 OBJETIVO
## [CONTEÚDO PRINCIPAL]
## 🔗 REFERÊNCIAS CRUZADAS
## 📝 CHANGELOG (quando aplicável)
```

**Benefícios:**
- Consistência entre documentos
- Facilita navegação
- Metadados sempre presentes

---

### Prática 2: Nomenclatura Consistente

**Padrão**: `[PREFIXO]_[CATEGORIA]_[DESCRICAO].[EXT]`

**Exemplos:**
```
00_nomenclatura_e_melhores_praticas.md
01_dossie_viagem_completo.md
02_protocolo_busca_web.md
```

**Regras:**
- Prefixos numéricos para ordem
- Categorias descritivas
- Descrições específicas
- Extensões padronizadas

---

### Prática 3: Versionamento

**Formato**: `MAJOR.MINOR.PATCH`

**Quando Incrementar:**

- **MAJOR**: Mudanças estruturais significativas
  - Reorganização completa
  - Mudança de formato
  - Remoção de seções importantes

- **MINOR**: Adição de novas seções ou informações
  - Nova seção adicionada
  - Novas informações importantes
  - Expansão de conteúdo

- **PATCH**: Correções e ajustes menores
  - Correção de erros
  - Ajustes de formatação
  - Atualizações menores

**Exemplo:**
```
1.0.0 → 1.1.0 (nova seção adicionada)
1.1.0 → 1.1.1 (correção de typo)
1.1.1 → 2.0.0 (reestruturação completa)
```

---

### Prática 4: Metadados Completos

**Metadados Obrigatórios:**

| Campo | Descrição | Exemplo |
|-------|-----------|---------|
| **Tipo** | Categoria do documento | BASE_CONHECIMENTO |
| **Prioridade** | Nível de importância | CRÍTICO |
| **Última Atualização** | Data da última atualização | 2025-11-16 |
| **Versão** | Versão do documento | 1.0.0 |
| **Dependências** | Arquivos relacionados | `../01_dossie.md` |

**Benefícios:**
- Rastreabilidade
- Gestão de versões
- Mapeamento de dependências
- Histórico de mudanças

---

## 🎓 CASOS DE USO

### Caso 1: Criar Novo Documento de Base de Conhecimento

**Processo:**

1. Definir nomenclatura (`01_BASE_CONHECIMENTO/XX_nome.md`)
2. Usar template de engenharia de contexto
3. Preencher metadados completos
4. Desenvolver conteúdo estruturado
5. Documentar referências cruzadas
6. Validar antes de commit

**Resultado:**
- Documento bem estruturado
- Metadados completos
- Referências mapeadas
- Pronto para importação

---

### Caso 2: Refatorar Documento Existente

**Processo:**

1. Analisar estrutura atual
2. Identificar melhorias necessárias
3. Aplicar padrões atualizados
4. Atualizar metadados (versão)
5. Validar referências cruzadas
6. Documentar mudanças no changelog

**Resultado:**
- Documento atualizado
- Padrões aplicados
- Histórico preservado
- Versão incrementada

---

### Caso 3: Adicionar Novo Contexto Dinâmico

**Processo:**

1. Identificar necessidade de busca dinâmica
2. Criar documento em `02_CONTEXTO_DINAMICO/`
3. Definir gatilhos de busca
4. Documentar fontes validadas
5. Incluir exemplos práticos
6. Integrar com protocolo existente

**Resultado:**
- Contexto dinâmico documentado
- Gatilhos definidos
- Fontes validadas
- Integrado ao sistema

---

## 🔗 REFERÊNCIAS

- **Nomenclatura e Práticas**: `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md`
- **Template Engenharia de Contexto**: `../01_templates/01_template_engenharia_contexto.md`
- **Melhores Práticas**: `../04_melhores_praticas/01_praticas_engenharia_contexto.md`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ GUIA COMPLETO

