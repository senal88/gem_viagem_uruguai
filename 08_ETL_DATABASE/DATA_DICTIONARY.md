# 📊 Dicionário de Dados - GEM Expert Viagem Uruguai

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | DATA_GOVERNANCE |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 2.0.0 |
| **Padrão de Nomenclatura** | Baseado em `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md` |

---

## 🎯 VISÃO GERAL

Este dicionário de dados documenta todas as tabelas, colunas e relacionamentos do banco de dados `viagem_uruguai.db`, seguindo padrões rigorosos de nomenclatura e governança de dados.

---

## 📐 CONVENÇÕES DE NOMENCLATURA

### Prefixos de Colunas

| Prefixo | Significado | Exemplo |
|---------|-------------|---------|
| `pk_` | Primary Key (Chave Primária) | `pk_viajante_id` |
| `fk_` | Foreign Key (Chave Estrangeira) | `fk_viajante_id` |
| `doc_` | Documento/Número/Texto Descritivo | `doc_cpf`, `doc_nome_completo` |
| `num_` | Valor Numérico | `num_valor`, `num_dias` |
| `data_` | Data (DATE) | `data_nascimento`, `data_partida` |
| `hora_` | Hora/Time (TIME) | `hora_partida`, `hora_evento` |
| `loc_` | Localização/Endereço | `loc_cidade`, `loc_endereco_completo` |
| `contato_` | Informações de Contato | `contato_email`, `contato_telefone` |
| `cat_` | Categoria/Tipo | `cat_tipo`, `cat_tipo_evento` |
| `flag_` | Boolean/Flag | `flag_transfer_incluido` |
| `meta_` | Metadados/Controle | `meta_status`, `meta_criado_em` |
| `moeda_` | Moeda | `moeda_codigo` |

### Categorias de Tabelas

| Categoria | Significado | Exemplo |
|-----------|-------------|---------|
| `core_` | Entidades Principais do Domínio | `tbl_core_viajantes` |
| `ref_` | Tabelas de Referência | `tbl_ref_contatos` |
| `meta_` | Metadados e Controle | `tbl_meta_documentos_processados` |

---

## 🔐 PII (PERSONALLY IDENTIFIABLE INFORMATION)

**⚠️ ATENÇÃO**: Colunas marcadas como **PII** contêm informações pessoais identificáveis e devem ser tratadas com cuidado especial conforme LGPD e boas práticas de segurança.

---

## 📊 TABELAS E COLUNAS

### CATEGORIA: CORE (Entidades Principais)

---

#### `tbl_core_viajantes`

**Descrição**: Armazena informações dos viajantes (Aline Torres e Luiz Fernando Sena).

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_viajante_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `doc_nome_completo` | TEXT | Nome completo do viajante | Sim | NOT NULL |
| `doc_nome_sobrenome` | TEXT | Sobrenome | Sim | Ex: "MOREIRA SENA" |
| `doc_nome_primeiro` | TEXT | Primeiro nome | Sim | Ex: "LUIZ FERNANDO" |
| `doc_cpf` | TEXT | CPF do viajante | **Sim** | Formato: XXX.XXX.XXX-XX |
| `doc_passaporte_numero` | TEXT | Número do passaporte | **Sim** | Ex: "GM519922" |
| `doc_passaporte_pais_emissor` | TEXT | País emissor do passaporte | Não | Default: 'BRA' |
| `doc_passaporte_data_expedicao` | DATE | Data de expedição do passaporte | Não | |
| `doc_passaporte_data_validade` | DATE | Data de validade do passaporte | Não | |
| `doc_data_nascimento` | DATE | Data de nascimento | **Sim** | |
| `doc_sexo` | TEXT | Sexo (M/F/O) | **Sim** | CHECK constraint |
| `doc_naturalidade_cidade` | TEXT | Cidade de naturalidade | Sim | Ex: "VITORIA" |
| `doc_naturalidade_estado` | TEXT | Estado de naturalidade | Sim | Ex: "ES" |
| `doc_nacionalidade` | TEXT | Nacionalidade | Não | Default: 'BRASILEIRO(A)' |
| `doc_filiacao_mae` | TEXT | Filiação - Mãe | **Sim** | Ex: "MARIA PENHA SENA DA SILVA" |
| `doc_filiacao_pai` | TEXT | Filiação - Pai | **Sim** | Ex: "LUIZ ANTONIO MOREIRA DA SILVA" |
| `contato_email` | TEXT | Email do viajante | **Sim** | |
| `contato_telefone` | TEXT | Telefone do viajante | **Sim** | |
| `meta_status` | TEXT | Status do registro | Não | Default: 'ativo' |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Relacionamentos**:
- `tbl_core_voos.fk_viajante_id` → `pk_viajante_id`
- `tbl_core_seguros.fk_viajante_id` → `pk_viajante_id`

**Índices**:
- `idx_core_viajantes_cpf` (doc_cpf)
- `idx_core_viajantes_passaporte` (doc_passaporte_numero)
- `idx_core_viajantes_status` (meta_status)

---

#### `tbl_core_voos`

**Descrição**: Armazena informações de voos dos viajantes.

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_voo_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `fk_viajante_id` | INTEGER | Chave Estrangeira para viajante | Não | NOT NULL, FK → tbl_core_viajantes |
| `doc_numero_voo` | TEXT | Número do voo | Não | NOT NULL, Ex: "LA4537" |
| `doc_companhia_aerea` | TEXT | Companhia aérea | Não | NOT NULL, Ex: "LATAM" |
| `doc_referencia_reserva` | TEXT | Código de reserva | Não | Ex: "DYYFYZ" |
| `doc_numero_compra` | TEXT | Número da compra | Não | Ex: "LA9574174NEOG" |
| `data_partida` | DATE | Data de partida | Não | NOT NULL |
| `hora_partida` | TIME | Hora de partida | Não | NOT NULL |
| `loc_aeroporto_origem` | TEXT | Código do aeroporto de origem | Não | NOT NULL, Ex: "VIX" |
| `loc_cidade_origem` | TEXT | Cidade de origem | Não | NOT NULL |
| `data_chegada` | DATE | Data de chegada | Não | NOT NULL |
| `hora_chegada` | TIME | Hora de chegada | Não | NOT NULL |
| `loc_aeroporto_destino` | TEXT | Código do aeroporto de destino | Não | NOT NULL, Ex: "MVD" |
| `loc_cidade_destino` | TEXT | Cidade de destino | Não | NOT NULL |
| `doc_assento` | TEXT | Número do assento | Não | |
| `doc_bagagem_descricao` | TEXT | Descrição da bagagem | Não | |
| `num_valor` | REAL | Valor do voo | Não | |
| `moeda_codigo` | TEXT | Código da moeda | Não | Default: 'BRL' |
| `meta_status` | TEXT | Status do voo | Não | Default: 'confirmado' |
| `doc_caminho_arquivo` | TEXT | Caminho do documento PDF | Não | |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Relacionamentos**:
- `fk_viajante_id` → `tbl_core_viajantes.pk_viajante_id`

**Índices**:
- `idx_core_voos_viajante` (fk_viajante_id)
- `idx_core_voos_data_partida` (data_partida)
- `idx_core_voos_status` (meta_status)
- `idx_core_voos_numero` (doc_numero_voo)

---

#### `tbl_core_hoteis`

**Descrição**: Armazena reservas de hotéis.

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_hotel_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `doc_nome_hotel` | TEXT | Nome do hotel | Não | NOT NULL |
| `loc_cidade` | TEXT | Cidade do hotel | Não | NOT NULL |
| `loc_bairro` | TEXT | Bairro do hotel | Não | |
| `loc_endereco_completo` | TEXT | Endereço completo | Não | |
| `data_checkin` | DATE | Data de check-in | Não | NOT NULL |
| `data_checkout` | DATE | Data de check-out | Não | NOT NULL |
| `num_noites` | INTEGER | Número de noites | Não | |
| `doc_numero_reserva` | TEXT | Número da reserva | Não | |
| `doc_codigo_pin` | TEXT | Código PIN da reserva | Não | |
| `doc_codigo_confirmacao` | TEXT | Código de confirmação | Não | |
| `num_valor` | REAL | Valor da hospedagem | Não | |
| `moeda_codigo` | TEXT | Código da moeda | Não | Default: 'BRL' |
| `meta_status` | TEXT | Status da reserva | Não | Default: 'pendente' |
| `doc_caminho_arquivo` | TEXT | Caminho do documento PDF | Não | |
| `meta_observacoes` | TEXT | Observações | Não | |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Índices**:
- `idx_core_hoteis_checkin` (data_checkin)
- `idx_core_hoteis_status` (meta_status)
- `idx_core_hoteis_reserva` (doc_numero_reserva)

---

#### `tbl_core_reservas`

**Descrição**: Armazena reservas de atividades, tours, eventos e restaurantes.

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_reserva_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `doc_codigo_reserva` | TEXT | Código único da reserva | Não | UNIQUE, NOT NULL, Ex: "RES001" |
| `doc_nome_atividade` | TEXT | Nome da atividade | Não | NOT NULL |
| `cat_tipo` | TEXT | Tipo de atividade | Não | NOT NULL, CHECK: tour/evento/restaurante/atividade/show/museu |
| `data_evento` | DATE | Data do evento | Não | NOT NULL |
| `hora_evento` | TIME | Hora do evento | Não | |
| `loc_cidade` | TEXT | Cidade do evento | Não | NOT NULL |
| `loc_endereco` | TEXT | Endereço do evento | Não | |
| `num_valor_pessoa` | REAL | Valor por pessoa | Não | |
| `num_valor_total` | REAL | Valor total | Não | |
| `moeda_codigo` | TEXT | Código da moeda | Não | Default: 'BRL' |
| `meta_status` | TEXT | Status da reserva | Não | Default: 'pendente' |
| `doc_codigo_confirmacao` | TEXT | Código de confirmação | Não | |
| `contato_telefone` | TEXT | Telefone de contato | Não | |
| `contato_email` | TEXT | Email de contato | Não | |
| `flag_transfer_incluido` | BOOLEAN | Transfer incluído | Não | Default: 0 |
| `hora_transfer_saida` | TIME | Hora de saída do transfer | Não | |
| `loc_transfer_saida` | TEXT | Local de saída do transfer | Não | |
| `hora_transfer_retorno` | TIME | Hora de retorno do transfer | Não | |
| `doc_dress_code` | TEXT | Dress code | Não | |
| `meta_observacoes` | TEXT | Observações | Não | |
| `doc_caminho_arquivo` | TEXT | Caminho do documento PDF | Não | |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Relacionamentos**:
- `tbl_meta_itinerario.fk_reserva_id` → `doc_codigo_reserva`

**Índices**:
- `idx_core_reservas_data` (data_evento)
- `idx_core_reservas_status` (meta_status)
- `idx_core_reservas_tipo` (cat_tipo)
- `idx_core_reservas_codigo` (doc_codigo_reserva)

---

#### `tbl_core_alugueis_carros`

**Descrição**: Armazena informações de aluguel de carros.

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_aluguel_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `doc_locadora` | TEXT | Nome da locadora | Não | NOT NULL, Ex: "Budget" |
| `doc_numero_confirmacao` | TEXT | Número de confirmação | Não | UNIQUE, NOT NULL, Ex: "35328815BR4" |
| `data_retirada` | DATE | Data de retirada | Não | NOT NULL |
| `hora_retirada` | TIME | Hora de retirada | Não | NOT NULL |
| `loc_retirada` | TEXT | Local de retirada | Não | NOT NULL |
| `loc_retirada_endereco` | TEXT | Endereço de retirada | Não | |
| `data_devolucao` | DATE | Data de devolução | Não | NOT NULL |
| `hora_devolucao` | TIME | Hora de devolução | Não | NOT NULL |
| `loc_devolucao` | TEXT | Local de devolução | Não | NOT NULL |
| `loc_devolucao_endereco` | TEXT | Endereço de devolução | Não | |
| `num_dias` | INTEGER | Número de dias | Não | |
| `doc_modelo_carro` | TEXT | Modelo do carro | Não | |
| `num_valor` | REAL | Valor do aluguel | Não | |
| `moeda_codigo` | TEXT | Código da moeda | Não | Default: 'BRL' |
| `meta_status` | TEXT | Status do aluguel | Não | Default: 'pendente' |
| `flag_seguro_incluido` | BOOLEAN | Seguro incluído | Não | Default: 0 |
| `flag_telepeaje_incluido` | BOOLEAN | Telepeaje incluído | Não | Default: 0 |
| `doc_politica_combustivel` | TEXT | Política de combustível | Não | |
| `doc_caminho_arquivo` | TEXT | Caminho do documento PDF | Não | |
| `meta_observacoes` | TEXT | Observações | Não | |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Índices**:
- `idx_core_alugueis_data_retirada` (data_retirada)
- `idx_core_alugueis_status` (meta_status)
- `idx_core_alugueis_confirmacao` (doc_numero_confirmacao)

---

#### `tbl_core_seguros`

**Descrição**: Armazena informações de seguros de viagem.

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_seguro_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `fk_viajante_id` | INTEGER | Chave Estrangeira para viajante | Não | NOT NULL, FK → tbl_core_viajantes |
| `doc_seguradora` | TEXT | Nome da seguradora | Não | NOT NULL |
| `doc_numero_apolice` | TEXT | Número da apólice | Não | UNIQUE, NOT NULL |
| `doc_numero_certificado` | TEXT | Número do certificado | Não | |
| `data_cobertura_inicio` | DATE | Início da cobertura | Não | NOT NULL |
| `data_cobertura_fim` | DATE | Fim da cobertura | Não | NOT NULL |
| `num_valor` | REAL | Valor do seguro | Não | |
| `moeda_codigo` | TEXT | Código da moeda | Não | Default: 'BRL' |
| `meta_status` | TEXT | Status do seguro | Não | Default: 'confirmado' |
| `doc_caminho_arquivo` | TEXT | Caminho do documento PDF | Não | |
| `meta_observacoes` | TEXT | Observações | Não | |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Relacionamentos**:
- `fk_viajante_id` → `tbl_core_viajantes.pk_viajante_id`

**Índices**:
- `idx_core_seguros_viajante` (fk_viajante_id)
- `idx_core_seguros_cobertura_inicio` (data_cobertura_inicio)

---

### CATEGORIA: REF (Tabelas de Referência)

---

#### `tbl_ref_contatos`

**Descrição**: Armazena contatos essenciais (hotéis, restaurantes, tours, emergência).

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_contato_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `doc_nome` | TEXT | Nome do contato | Não | NOT NULL |
| `cat_tipo` | TEXT | Tipo de contato | Não | NOT NULL, CHECK: hotel/restaurante/tour/emergencia/aluguel_carro/companhia_aerea/seguradora/outro |
| `contato_telefone` | TEXT | Telefone | Não | |
| `contato_email` | TEXT | Email | Não | |
| `loc_endereco` | TEXT | Endereço | Não | |
| `meta_observacoes` | TEXT | Observações | Não | |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Índices**:
- `idx_ref_contatos_tipo` (cat_tipo)

---

### CATEGORIA: META (Metadados e Controle)

---

#### `tbl_meta_documentos_processados`

**Descrição**: Controla documentos PDF processados pelo ETL.

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_documento_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `doc_caminho_arquivo` | TEXT | Caminho completo do arquivo | Não | UNIQUE, NOT NULL |
| `cat_tipo_documento` | TEXT | Tipo do documento | Não | NOT NULL, CHECK: cartao_embarque/reserva_hotel/seguro/passagem_aerea/aluguel_carro/passaporte/outro |
| `doc_hash_sha256` | TEXT | Hash SHA256 do arquivo | Não | |
| `meta_status_extracao` | TEXT | Status da extração | Não | Default: 'pendente' |
| `data_extracao` | TIMESTAMP | Data da extração | Não | |
| `doc_dados_extraidos` | TEXT | Dados extraídos em JSON | Não | |
| `meta_status_validacao` | TEXT | Status da validação | Não | Default: 'pendente' |
| `meta_notas_validacao` | TEXT | Notas da validação | Não | |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Índices**:
- `idx_meta_documentos_status_extracao` (meta_status_extracao)
- `idx_meta_documentos_tipo` (cat_tipo_documento)
- `idx_meta_documentos_hash` (doc_hash_sha256)

---

#### `tbl_meta_itinerario`

**Descrição**: Armazena o itinerário detalhado dia a dia da viagem.

| Coluna | Tipo | Descrição | PII | Notas |
|--------|------|-----------|-----|-------|
| `pk_itinerario_id` | INTEGER | Chave Primária | Não | AUTOINCREMENT |
| `num_dia` | INTEGER | Número do dia (1-8) | Não | NOT NULL |
| `data_evento` | DATE | Data do evento | Não | NOT NULL |
| `doc_dia_semana` | TEXT | Dia da semana | Não | Ex: "Terça-feira" |
| `loc_cidade` | TEXT | Cidade do evento | Não | NOT NULL |
| `hora_evento` | TIME | Hora do evento | Não | |
| `cat_tipo_evento` | TEXT | Tipo de evento | Não | CHECK: chegada/partida/reserva/atividade/refeicao/logistica/livre |
| `doc_titulo` | TEXT | Título do evento | Não | NOT NULL |
| `doc_detalhes` | TEXT | Detalhes do evento | Não | |
| `meta_status` | TEXT | Status do evento | Não | Default: 'pendente' |
| `fk_reserva_id` | TEXT | Chave Estrangeira para reserva | Não | FK → tbl_core_reservas.doc_codigo_reserva |
| `meta_observacoes` | TEXT | Observações | Não | |
| `meta_criado_em` | TIMESTAMP | Data de criação | Não | DEFAULT CURRENT_TIMESTAMP |
| `meta_atualizado_em` | TIMESTAMP | Data de atualização | Não | DEFAULT CURRENT_TIMESTAMP |

**Relacionamentos**:
- `fk_reserva_id` → `tbl_core_reservas.doc_codigo_reserva`

**Índices**:
- `idx_meta_itinerario_data` (data_evento)
- `idx_meta_itinerario_dia` (num_dia)
- `idx_meta_itinerario_status` (meta_status)
- `idx_meta_itinerario_reserva` (fk_reserva_id)

---

## 🔐 RESUMO DE PII (PERSONALLY IDENTIFIABLE INFORMATION)

### Tabela: `tbl_core_viajantes`

**Colunas PII**:
- `doc_cpf` - CPF
- `doc_passaporte_numero` - Número do Passaporte
- `doc_data_nascimento` - Data de Nascimento
- `doc_sexo` - Sexo
- `doc_naturalidade_cidade` - Naturalidade
- `doc_naturalidade_estado` - Naturalidade
- `doc_filiacao_mae` - Filiação
- `doc_filiacao_pai` - Filiação
- `contato_email` - Email
- `contato_telefone` - Telefone
- `doc_nome_completo` - Nome Completo
- `doc_nome_sobrenome` - Sobrenome
- `doc_nome_primeiro` - Primeiro Nome

**Recomendações de Segurança**:
- ✅ Criptografar colunas PII em produção
- ✅ Implementar controle de acesso baseado em roles
- ✅ Logar acessos a dados PII
- ✅ Implementar mascaramento de dados em logs
- ✅ Conformidade com LGPD

---

## 📊 RELACIONAMENTOS ENTRE TABELAS

```
tbl_core_viajantes (1)
    ├── tbl_core_voos (N) [fk_viajante_id]
    └── tbl_core_seguros (N) [fk_viajante_id]

tbl_core_reservas (1)
    └── tbl_meta_itinerario (N) [fk_reserva_id]
```

---

## 🔍 ÍNDICES E PERFORMANCE

### Índices por Tabela

**tbl_core_viajantes**: 3 índices
- CPF, Passaporte, Status

**tbl_core_voos**: 4 índices
- Viajante, Data Partida, Status, Número Voo

**tbl_core_hoteis**: 3 índices
- Check-in, Status, Reserva

**tbl_core_reservas**: 4 índices
- Data, Status, Tipo, Código

**tbl_core_alugueis_carros**: 3 índices
- Data Retirada, Status, Confirmação

**tbl_core_seguros**: 2 índices
- Viajante, Cobertura Início

**tbl_ref_contatos**: 1 índice
- Tipo

**tbl_meta_documentos_processados**: 3 índices
- Status Extração, Tipo, Hash

**tbl_meta_itinerario**: 4 índices
- Data, Dia, Status, Reserva

**Total**: 27 índices

---

## 📝 NOTAS DE GOVERNANÇA

1. **Versionamento**: Schema versão 2.0.0
2. **Padrão de Nomenclatura**: Baseado em `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md`
3. **PII**: Todas as colunas PII identificadas e documentadas
4. **Integridade Referencial**: Foreign Keys definidas com CASCADE apropriado
5. **Auditoria**: Campos `meta_criado_em` e `meta_atualizado_em` em todas as tabelas
6. **Validação**: CHECK constraints para valores enumerados

---

## 🔗 REFERÊNCIAS CRUZADAS

- **Padrão de Nomenclatura**: `00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md`
- **Dossiê Completo**: `01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md`
- **Schema SQL**: `08_ETL_DATABASE/schema.sql`
- **ETL Loader**: `08_ETL_DATABASE/etl_loader.py`

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 2.0.0  
**Status**: ✅ APROVADO PARA PRODUÇÃO

