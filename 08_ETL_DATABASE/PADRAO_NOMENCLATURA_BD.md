# 📐 Padrão de Nomenclatura - Banco de Dados

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | DATA_GOVERNANCE |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 2.0.0 |
| **Baseado em** | `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md` |

---

## 🎯 OBJETIVO

Estender o padrão de nomenclatura de arquivos para o banco de dados SQLite, garantindo consistência, governança de dados e facilidade de manutenção.

---

## 📐 PADRÃO DE NOMENCLATURA

### 1. Tabelas

**Formato**: `tbl_[categoria]_[entidade]`

**Categorias**:
- `core_` = Entidades principais do domínio (viajantes, voos, hotéis, reservas)
- `ref_` = Tabelas de referência (contatos, aeroportos, moedas)
- `meta_` = Metadados e controle (documentos processados, itinerário, logs)

**Exemplos**:
- ✅ `tbl_core_viajantes`
- ✅ `tbl_core_voos`
- ✅ `tbl_ref_contatos`
- ✅ `tbl_meta_documentos_processados`
- ❌ `viajantes` (sem prefixo `tbl_`)
- ❌ `users` (sem categoria)

---

### 2. Colunas

**Formato**: `[prefixo]_[nome_descritivo]`

**Prefixos de Colunas**:

| Prefixo | Significado | Uso | Exemplo |
|---------|-------------|-----|---------|
| `pk_` | Primary Key | Chaves primárias | `pk_viajante_id` |
| `fk_` | Foreign Key | Chaves estrangeiras | `fk_viajante_id` |
| `doc_` | Documento/Texto | Números, códigos, textos descritivos | `doc_cpf`, `doc_nome_completo` |
| `num_` | Numérico | Valores numéricos | `num_valor`, `num_dias` |
| `data_` | Data | Campos DATE | `data_nascimento`, `data_partida` |
| `hora_` | Hora | Campos TIME | `hora_partida`, `hora_evento` |
| `loc_` | Localização | Endereços, cidades, locais | `loc_cidade`, `loc_endereco` |
| `contato_` | Contato | Email, telefone | `contato_email`, `contato_telefone` |
| `cat_` | Categoria | Tipos, categorias | `cat_tipo`, `cat_tipo_evento` |
| `flag_` | Flag/Boolean | Valores booleanos | `flag_transfer_incluido` |
| `meta_` | Metadados | Status, timestamps, controle | `meta_status`, `meta_criado_em` |
| `moeda_` | Moeda | Códigos de moeda | `moeda_codigo` |

**Exemplos**:
- ✅ `doc_cpf` (documento CPF)
- ✅ `data_nascimento` (data de nascimento)
- ✅ `num_valor_total` (valor numérico)
- ✅ `loc_cidade` (localização cidade)
- ✅ `meta_status` (metadado status)
- ❌ `cpf` (sem prefixo)
- ❌ `birth_date` (inglês, sem prefixo)

---

### 3. Chaves Primárias (PK)

**Formato**: `pk_[entidade]_id`

**Exemplos**:
- ✅ `pk_viajante_id`
- ✅ `pk_voo_id`
- ✅ `pk_hotel_id`
- ❌ `id` (genérico demais)
- ❌ `viajante_id` (sem prefixo `pk_`)

---

### 4. Chaves Estrangeiras (FK)

**Formato**: `fk_[entidade]_id`

**Exemplos**:
- ✅ `fk_viajante_id` (referencia `tbl_core_viajantes.pk_viajante_id`)
- ✅ `fk_reserva_id` (referencia `tbl_core_reservas.doc_codigo_reserva`)
- ❌ `viajante_id` (sem prefixo `fk_`)

---

### 5. Índices

**Formato**: `idx_[tabela]_[coluna(s)]`

**Exemplos**:
- ✅ `idx_core_viajantes_cpf`
- ✅ `idx_core_voos_data_partida`
- ✅ `idx_core_reservas_status`
- ❌ `idx_cpf` (sem tabela)
- ❌ `index_viajantes` (sem prefixo `idx_`)

---

## 🏗️ CATEGORIAS DE TABELAS

### CORE (Entidades Principais)

Tabelas que representam entidades principais do domínio da viagem:

- `tbl_core_viajantes` - Viajantes
- `tbl_core_voos` - Voos
- `tbl_core_hoteis` - Hotéis
- `tbl_core_reservas` - Reservas/Atividades
- `tbl_core_alugueis_carros` - Aluguel de carros
- `tbl_core_seguros` - Seguros de viagem

### REF (Tabelas de Referência)

Tabelas que armazenam dados de referência e lookup:

- `tbl_ref_contatos` - Contatos essenciais
- `tbl_ref_aeroportos` - Aeroportos (futuro)
- `tbl_ref_moedas` - Moedas (futuro)

### META (Metadados e Controle)

Tabelas que armazenam metadados, logs e controle:

- `tbl_meta_documentos_processados` - Controle de documentos ETL
- `tbl_meta_itinerario` - Itinerário detalhado
- `tbl_meta_logs` - Logs de sistema (futuro)

---

## 🔐 GOVERNANÇA DE DADOS

### PII (Personally Identifiable Information)

**Colunas marcadas como PII** devem ser tratadas com cuidado especial:

- ✅ Criptografia em produção
- ✅ Controle de acesso baseado em roles
- ✅ Logging de acessos
- ✅ Mascaramento em logs
- ✅ Conformidade com LGPD

**Identificação de PII**:
- CPF, Passaporte, RG
- Data de Nascimento
- Filiação (Mãe/Pai)
- Email, Telefone
- Endereço completo
- Nome completo

---

## 📊 EXEMPLOS COMPLETOS

### Tabela: `tbl_core_viajantes`

```sql
CREATE TABLE tbl_core_viajantes (
    pk_viajante_id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_nome_completo TEXT NOT NULL,
    doc_cpf TEXT, -- PII
    doc_passaporte_numero TEXT, -- PII
    doc_data_nascimento DATE, -- PII
    contato_email TEXT, -- PII
    meta_status TEXT DEFAULT 'ativo',
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Tabela: `tbl_core_voos`

```sql
CREATE TABLE tbl_core_voos (
    pk_voo_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fk_viajante_id INTEGER NOT NULL,
    doc_numero_voo TEXT NOT NULL,
    data_partida DATE NOT NULL,
    hora_partida TIME NOT NULL,
    loc_aeroporto_origem TEXT NOT NULL,
    FOREIGN KEY (fk_viajante_id) REFERENCES tbl_core_viajantes(pk_viajante_id)
);
```

---

## ✅ CHECKLIST DE CONFORMIDADE

Antes de criar uma nova tabela ou coluna:

- [ ] Nome da tabela segue padrão `tbl_[categoria]_[entidade]`
- [ ] Todas as colunas têm prefixo apropriado
- [ ] Chave primária usa formato `pk_[entidade]_id`
- [ ] Chaves estrangeiras usam formato `fk_[entidade]_id`
- [ ] Índices usam formato `idx_[tabela]_[coluna]`
- [ ] Colunas PII estão identificadas e documentadas
- [ ] Campos de auditoria (`meta_criado_em`, `meta_atualizado_em`) estão presentes
- [ ] CHECK constraints para valores enumerados
- [ ] Comentários SQL explicando propósito

---

## 🔗 REFERÊNCIAS

- **Padrão de Arquivos**: `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md`
- **Schema SQL**: `08_ETL_DATABASE/schema.sql`
- **Dicionário de Dados**: `08_ETL_DATABASE/DATA_DICTIONARY.md`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 2.0.0
**Status**: ✅ APROVADO PARA USO

