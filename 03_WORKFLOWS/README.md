# 📁 Workflows - Concierge de Viagem Elite

Esta pasta contém todos os arquivos necessários para criar e importar o GEM (Google's Generative Experience Model) do Concierge de Viagem Elite para Aline e Luiz Fernando.

---

## 📋 Estrutura de Arquivos

### 1. `01_workflow_concierge_principal.json`
**Formato:** JSON completo do workflow
**Uso:** Arquivo de referência completo com todas as configurações em formato JSON
**Quando usar:** Para referência técnica ou importação direta em sistemas que aceitam JSON

---

### 2. `02_instrucoes_gem_formatadas.md` ⭐ **PRINCIPAL**
**Formato:** Markdown formatado
**Uso:** **Copiar e colar diretamente na seção "Instruções" do GEM**
**Conteúdo:**
- Identidade do concierge
- Protocolo de atuação
- Gatilhos para busca web
- Princípios de execução
- Regras de interação
- Exemplos práticos

**Como usar:**
1. Abrir este arquivo
2. Copiar TODO o conteúdo
3. Colar na seção "Instruções" do GEM

---

### 3. `03_guia_importacao_gem_completo.md` 📖 **GUIA COMPLETO**
**Formato:** Guia detalhado passo a passo
**Uso:** Referência completa para importação na GEM
**Conteúdo:**
- Todos os campos necessários (Nome, Descrição, Ferramentas)
- Checklist completo de importação
- Ordem de prioridade dos arquivos
- Testes de validação
- Troubleshooting

**Quando usar:** 
- Primeira vez importando na GEM
- Quando precisar de referência detalhada
- Para validar se tudo foi importado corretamente

---

### 4. `04_campos_essenciais_gem.md` ⚡ **RÁPIDO**
**Formato:** Resumo executivo
**Uso:** Referência rápida com apenas os campos essenciais
**Conteúdo:**
- Nome do GEM
- Descrição
- Ferramenta
- Lista de arquivos de conhecimento
- Checklist rápido

**Quando usar:**
- Quando já conhece o processo e precisa apenas dos campos
- Para consulta rápida durante a importação

---

## 🚀 Fluxo de Importação Recomendado

### Para Iniciantes (Primeira Vez)

1. **Ler primeiro:** `03_guia_importacao_gem_completo.md`
2. **Seguir passo a passo:** Checklist completo
3. **Copiar instruções:** De `02_instrucoes_gem_formatadas.md`
4. **Importar conhecimento:** Arquivos em `01_BASE_CONHECIMENTO/`
5. **Validar:** Testes sugeridos no guia

### Para Usuários Experientes

1. **Consultar:** `04_campos_essenciais_gem.md`
2. **Copiar instruções:** De `02_instrucoes_gem_formatadas.md`
3. **Importar conhecimento:** Arquivos em `01_BASE_CONHECIMENTO/`

---

## 📚 Arquivos de Conhecimento (Base de Dados)

Os arquivos de conhecimento estão em `../01_BASE_CONHECIMENTO/`:

| Arquivo | Prioridade | Descrição |
|---------|------------|-----------|
| `01_dossie_viagem_completo.md` | ⚠️ CRÍTICO | Informações gerais, voos, hospedagem, contatos |
| `02_itinerario_detalhado.md` | ⚠️ CRÍTICO | Roteiro dia a dia completo |
| `03_reservas_confirmadas.md` | ⚠️ CRÍTICO | Todas as reservas com detalhes |
| `04_logistica_transporte.md` | ⚠️ CRÍTICO | Aluguel de carro, rotas, regras |
| `05_perfil_viajantes.md` | ✅ IMPORTANTE | Perfil e preferências dos viajantes |

**Ordem de Importação:** Importar nesta ordem exata (do mais crítico ao importante)

---

## ✅ Checklist Rápido

- [ ] Nome: `concierge_pro_uruguai_aline_luiz_2025`
- [ ] Descrição copiada
- [ ] Ferramenta `google:search` adicionada
- [ ] Instruções copiadas de `02_instrucoes_gem_formatadas.md`
- [ ] 5 arquivos de conhecimento importados
- [ ] Testes realizados

---

## 🔄 Atualizações

Quando atualizar os arquivos:

1. **Atualizar arquivo de conhecimento** em `01_BASE_CONHECIMENTO/`
2. **Reimportar na GEM** o arquivo atualizado
3. **Testar** se as mudanças foram aplicadas

---

## 📞 Suporte

Para dúvidas sobre a estrutura ou importação, consultar:
- `03_guia_importacao_gem_completo.md` (guia completo)
- `00_GEM_STRUCTURE/` (documentação da estrutura)

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0

