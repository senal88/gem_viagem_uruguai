# 🎯 Template GEM Ideal de Viagem

## Sistema de Consulta em Tempo Real para Viajantes

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | GEM_STRUCTURE |
| **Prioridade** | REFERENCIA |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Uso** | Template para criar novos GEMs |

---

## 🎯 PROPÓSITO

Este documento serve como **template completo** para criação de novos GEMs de viagem, seguindo as melhores práticas e estrutura padronizada.

---

## 1. NOME

### Convenção

```
gem_concierge_[INICIAIS_VIAJANTES]_[DESTINO_PRINCIPAL]_[DATA_INICIO_MES]_[DATA_FIM_MES]_[ANO]
```

### Exemplo

```
gem_concierge_al_luiz_montevideu_puntadeleste_nov18_nov25_2025
```

### Componentes

- **gem_**: Prefixo obrigatório (GEM = Guided Expert Module)
- **concierge_**: Tipo de expert (concierge, guia, planejador)
- **[INICIAIS]**: Primeiras letras dos nomes (al_luiz para Aline & Luiz)
- **[DESTINO]**: Principais cidades visitadas
- **[DATA]**: Período da viagem

---

## 2. DESCRIÇÃO

### Template

```markdown
**GEM Concierge:** Assistente de viagem pessoal para [NOMES],
especializado em viagens sofisticadas ao [DESTINO(S)].

**Período:** [DATA_INICIO] a [DATA_FIM], [TOTAL_DIAS] dias.

**Perfil de Viagem:** [TIPO: Casal/Solo/Grupo],
foco em [ATIVIDADES_PRINCIPAIS].

**Especialidades do GEM:**
- Eventos obrigatórios: [LISTA]
- Experiências de alto padrão: [DESCRIÇÃO]
- Suporte dinâmico: clima, trânsito, câmbio, disponibilidade em tempo real
- Logística fluida: transporte, horários, dicas práticas

**Objetivo Principal:** Executar roteiro com perfeição,
adaptando-se a circunstâncias dinâmicas e oferecendo suporte 24/7 proativo.

**Status:** ✅ OPERACIONAL | Atualizado: [DATA]
```

---

## 3. INSTRUÇÕES

### Estrutura

1. **Identidade e Missão**
2. **Protocolo de Atuação**
3. **Gatilhos Obrigatórios para Busca Web**
4. **Regras de Resposta**
5. **Prioridades Operacionais**
6. **Exemplos de Interação**

### Template Completo

Ver arquivo: `03_WORKFLOWS/02_instrucoes_gem_formatadas.md`

---

## 4. CONHECIMENTO

### Estrutura Recomendada

1. **Memória Fixa: Itinerário Completo** (JSON estruturado)
2. **Fontes Validadas** (por tipo de informação)
3. **Informações Críticas Pré-Viagem**
4. **Protocolo de Busca Dinâmica**
5. **Contexto por Dia** (Quick Reference)
6. **Dicionário de Termos**

### Template JSON

```json
{
  "metadata": {
    "gem_id": "[USE NOME DA SEÇÃO 1]",
    "viajantes": ["[NOME_1]", "[NOME_2]"],
    "destinos": ["[DESTINO_1]", "[DESTINO_2]"],
    "data_inicio": "YYYY-MM-DD",
    "data_fim": "YYYY-MM-DD",
    "total_dias": 0,
    "timezone": "UTC-3"
  },
  "itinerario": [
    {
      "dia": 1,
      "data": "YYYY-MM-DD",
      "dia_semana": "Terça",
      "titulo": "[TITULO_DIA]",
      "tipo": "chegada|livre|evento|saida",
      "atividades": [
        {
          "hora": "HH:MM",
          "atividade": "[DESCRICAO]",
          "local": "[LOCAL]",
          "status": "reservado|sugestao|livre",
          "duracao_minutos": 0,
          "contato": "[TELEFONE/EMAIL]",
          "dress_code": "[se evento]",
          "custo_local": "[moeda valor]"
        }
      ]
    }
  ],
  "reservas_criticas": [
    {
      "data": "YYYY-MM-DD",
      "hora": "HH:MM",
      "evento": "[NOME]",
      "local": "[ENDERECO]",
      "confirmacao_id": "[ID]",
      "contato": "[TELEFONE]",
      "tipo": "evento|tour|almoço|show",
      "dress_code": "[se aplicavel]",
      "transferencia": true|false
    }
  ]
}
```

---

## 📋 CHECKLIST DE QUALIDADE

- [ ] Nome segue convenção
- [ ] Descrição é clara e visual
- [ ] Instruções cobrem protocolo completo
- [ ] Conhecimento é estruturado (JSON ou similar)
- [ ] Fontes são validadas
- [ ] Dados críticos (eventos, reservas) estão completos
- [ ] Contatos estão verificados
- [ ] Gatilhos de busca estão definidos
- [ ] Exemplos de interação testados
- [ ] Status é claro (OPERACIONAL?)

---

## 🚀 PRÓXIMOS PASSOS

1. **Importar em plataforma:** Copiar JSON em backend
2. **Carregar Memória:** Inicializar concierge com Dossiê
3. **Ativar Busca:** Conectar search_web
4. **Testar:** 10+ interações de validação
5. **Deploy:** Publicar em produção

---

## 🔗 REFERÊNCIAS CRUZADAS

- **Nomenclatura:** `00_nomenclatura_e_melhores_praticas.md`
- **Instruções Formatadas:** `03_WORKFLOWS/02_instrucoes_gem_formatadas.md`
- **Guia Importação:** `03_WORKFLOWS/03_guia_importacao_gem_completo.md`
- **Exemplo Real:** `03_WORKFLOWS/01_workflow_concierge_principal.json`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ TEMPLATE PRONTO PARA USO
