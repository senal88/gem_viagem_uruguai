# ⭐ Melhores Práticas: Engenharia de Contexto
## Princípios e Práticas Consolidadas para GEM Expert

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | PROMPTS_MELHORES_PRATICAS |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | `02_guias/01_guia_engenharia_contexto.md` |

---

## 🎯 OBJETIVO

Este documento consolida as melhores práticas de engenharia de contexto aplicadas ao GEM Expert, servindo como referência rápida para criação e manutenção de documentos.

---

## ⭐ PRÁTICAS ESSENCIAIS

### 1. Separação Estático vs Dinâmico

**✅ FAZER:**
- Separar claramente conhecimento estático de dinâmico
- Colocar estático em `01_BASE_CONHECIMENTO/`
- Colocar dinâmico em `02_CONTEXTO_DINAMICO/`
- Documentar quando buscar vs quando consultar

**❌ EVITAR:**
- Misturar informações estáticas e dinâmicas no mesmo documento
- Buscar informações que já estão no conhecimento estático
- Consultar conhecimento estático para informações dinâmicas

**Exemplo:**

**Bom:**
```
01_BASE_CONHECIMENTO/03_reservas_confirmadas.md
→ "O casamento é no dia 22/11 às 16h30" (estático)

02_CONTEXTO_DINAMICO/01_protocolo_busca_web.md
→ "Buscar previsão do tempo para 22/11" (dinâmico)
```

**Ruim:**
```
01_BASE_CONHECIMENTO/03_reservas_confirmadas.md
→ "Buscar previsão do tempo para o casamento" (misturado)
```

---

### 2. Hierarquia de Importância

**✅ FAZER:**
- Usar prefixos numéricos para ordem (00_, 01_, 02_...)
- Documentos críticos primeiro (00_, 01_)
- Documentos de suporte depois (04_, 05_)
- Mapear dependências claramente

**❌ EVITAR:**
- Criar documentos sem pensar na ordem
- Misturar níveis de importância
- Ignorar dependências

**Exemplo:**

**Bom:**
```
00_GEM_STRUCTURE/ (1ª Fase - Estrutura)
01_BASE_CONHECIMENTO/ (2ª Fase - Crítico)
02_CONTEXTO_DINAMICO/ (3ª Fase - Importante)
```

**Ruim:**
```
01_BASE_CONHECIMENTO/ (sem estrutura primeiro)
99_REFERENCIAS/ (misturado com crítico)
```

---

### 3. Granularidade Adequada

**✅ FAZER:**
- Um conceito por arquivo
- Tamanho ideal: 200-2000 linhas
- Dividir arquivos muito grandes
- Consolidar arquivos muito pequenos

**❌ EVITAR:**
- Arquivos "catch-all" com múltiplos conceitos
- Arquivos muito grandes (>3000 linhas)
- Arquivos muito pequenos (<100 linhas) sem necessidade

**Exemplo:**

**Bom:**
```
01_dossie_viagem_completo.md (~500 linhas)
02_itinerario_detalhado.md (~400 linhas)
03_reservas_confirmadas.md (~300 linhas)
```

**Ruim:**
```
01_tudo_junto.md (~5000 linhas) ❌
01_info_geral.md (~50 linhas) ⚠️
```

---

### 4. Metadados Completos

**✅ FAZER:**
- Sempre incluir seção de metadados
- Preencher todos os campos obrigatórios
- Atualizar versão quando mudar
- Documentar dependências

**❌ EVITAR:**
- Criar documentos sem metadados
- Deixar campos obrigatórios vazios
- Esquecer de atualizar versão
- Ignorar dependências

**Template Obrigatório:**

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

### 5. Referências Cruzadas

**✅ FAZER:**
- Documentar todos os relacionamentos
- Usar caminhos relativos
- Manter referências atualizadas
- Verificar se arquivos referenciados existem

**❌ EVITAR:**
- Criar documentos isolados sem referências
- Usar caminhos absolutos
- Deixar referências desatualizadas
- Referenciar arquivos que não existem

**Formato:**

```markdown
## 🔗 REFERÊNCIAS CRUZADAS

- **Depende de**: `../01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md`
- **Usado por**: `02_gatilhos_validacao.md`
- **Relacionado a**: `03_categorias_perguntas.md`
```

---

### 6. Validação Contínua

**✅ FAZER:**
- Validar antes de cada commit
- Usar checklist completo
- Verificar nomenclatura
- Validar estrutura e conteúdo

**❌ EVITAR:**
- Commitar sem validar
- Pular etapas de validação
- Ignorar problemas encontrados

**Checklist Mínimo:**

- [ ] Nomenclatura correta
- [ ] Metadados completos
- [ ] Estrutura hierárquica clara
- [ ] Referências funcionais
- [ ] Sem erros de formatação

---

### 7. Versionamento Consistente

**✅ FAZER:**
- Usar formato MAJOR.MINOR.PATCH
- Incrementar versão quando mudar
- Documentar mudanças no changelog
- Manter histórico de versões

**❌ EVITAR:**
- Não versionar documentos
- Esquecer de atualizar versão
- Não documentar mudanças

**Quando Incrementar:**

- **MAJOR**: Mudanças estruturais significativas
- **MINOR**: Adição de novas seções
- **PATCH**: Correções e ajustes

---

### 8. Nomenclatura Consistente

**✅ FAZER:**
- Seguir padrão: `[PREFIXO]_[CATEGORIA]_[DESCRICAO].[EXT]`
- Usar prefixos numéricos de 2 dígitos
- Ser descritivo nas descrições
- Manter consistência dentro da categoria

**❌ EVITAR:**
- Criar nomes sem padrão
- Usar espaços ou caracteres especiais
- Criar nomes genéricos
- Não seguir convenções estabelecidas

**Padrão:**

```
✅ 01_dossie_viagem_completo.md
✅ 02_protocolo_busca_web.md
❌ dossie.md (sem prefixo e categoria)
❌ Dossie Viagem.md (espaços e maiúsculas)
```

---

## 🎓 CHECKLIST RÁPIDO

### Antes de Criar Documento

- [ ] Nomenclatura definida seguindo padrão
- [ ] Localização escolhida (pasta correta)
- [ ] Template selecionado
- [ ] Dependências mapeadas

### Durante Criação

- [ ] Metadados completos
- [ ] Estrutura hierárquica clara
- [ ] Conteúdo completo e preciso
- [ ] Referências cruzadas documentadas

### Antes de Commit

- [ ] Validação completa executada
- [ ] Nomenclatura verificada
- [ ] Metadados atualizados
- [ ] Versão definida
- [ ] Referências verificadas

---

## 🔗 REFERÊNCIAS

- **Guia Engenharia de Contexto**: `../02_guias/01_guia_engenharia_contexto.md`
- **Guia Nomenclatura**: `../02_guias/02_guia_nomenclatura.md`
- **Template Validação**: `../01_templates/03_template_validacao.md`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ PRÁTICAS CONSOLIDADAS

