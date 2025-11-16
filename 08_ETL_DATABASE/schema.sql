-- ============================================================================
-- SCHEMA DO BANCO DE DADOS - GEM Expert Viagem Uruguai
-- Padrão de Nomenclatura: Governança de Dados e Data Governance
-- Baseado em: 00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md
-- ============================================================================

-- ============================================================================
-- CATEGORIA: CORE (Entidades Principais)
-- ============================================================================

-- Tabela: Viajantes (Entidade Core)
CREATE TABLE IF NOT EXISTS tbl_core_viajantes (
    pk_viajante_id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_nome_completo TEXT NOT NULL,
    doc_nome_sobrenome TEXT,
    doc_nome_primeiro TEXT,
    doc_cpf TEXT, -- PII: CPF
    doc_passaporte_numero TEXT, -- PII: Número do Passaporte
    doc_passaporte_pais_emissor TEXT DEFAULT 'BRA',
    doc_passaporte_data_expedicao DATE,
    doc_passaporte_data_validade DATE,
    doc_data_nascimento DATE, -- PII: Data de Nascimento
    doc_sexo TEXT CHECK(doc_sexo IN ('M', 'F', 'O')),
    doc_naturalidade_cidade TEXT,
    doc_naturalidade_estado TEXT,
    doc_nacionalidade TEXT DEFAULT 'BRASILEIRO(A)',
    doc_filiacao_mae TEXT, -- PII: Filiação
    doc_filiacao_pai TEXT, -- PII: Filiação
    contato_email TEXT, -- PII: Email
    contato_telefone TEXT, -- PII: Telefone
    meta_status TEXT DEFAULT 'ativo' CHECK(meta_status IN ('ativo', 'inativo', 'arquivado')),
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela: Voos (Entidade Core)
CREATE TABLE IF NOT EXISTS tbl_core_voos (
    pk_voo_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fk_viajante_id INTEGER NOT NULL,
    doc_numero_voo TEXT NOT NULL,
    doc_companhia_aerea TEXT NOT NULL,
    doc_referencia_reserva TEXT,
    doc_numero_compra TEXT,
    data_partida DATE NOT NULL,
    hora_partida TIME NOT NULL,
    loc_aeroporto_origem TEXT NOT NULL,
    loc_cidade_origem TEXT NOT NULL,
    data_chegada DATE NOT NULL,
    hora_chegada TIME NOT NULL,
    loc_aeroporto_destino TEXT NOT NULL,
    loc_cidade_destino TEXT NOT NULL,
    doc_assento TEXT,
    doc_bagagem_descricao TEXT,
    num_valor REAL,
    moeda_codigo TEXT DEFAULT 'BRL',
    meta_status TEXT DEFAULT 'confirmado' CHECK(meta_status IN ('confirmado', 'pendente', 'cancelado', 'concluido')),
    doc_caminho_arquivo TEXT,
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_viajante_id) REFERENCES tbl_core_viajantes(pk_viajante_id)
);

-- Tabela: Hotéis (Entidade Core)
CREATE TABLE IF NOT EXISTS tbl_core_hoteis (
    pk_hotel_id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_nome_hotel TEXT NOT NULL,
    loc_cidade TEXT NOT NULL,
    loc_bairro TEXT,
    loc_endereco_completo TEXT,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    num_noites INTEGER,
    doc_numero_reserva TEXT,
    doc_codigo_pin TEXT,
    doc_codigo_confirmacao TEXT,
    num_valor REAL,
    moeda_codigo TEXT DEFAULT 'BRL',
    meta_status TEXT DEFAULT 'pendente' CHECK(meta_status IN ('pendente', 'confirmado', 'cancelado', 'concluido')),
    doc_caminho_arquivo TEXT,
    meta_observacoes TEXT,
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela: Reservas/Atividades (Entidade Core)
CREATE TABLE IF NOT EXISTS tbl_core_reservas (
    pk_reserva_id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_codigo_reserva TEXT UNIQUE NOT NULL,
    doc_nome_atividade TEXT NOT NULL,
    cat_tipo TEXT NOT NULL CHECK(cat_tipo IN ('tour', 'evento', 'restaurante', 'atividade', 'show', 'museu')),
    data_evento DATE NOT NULL,
    hora_evento TIME,
    loc_cidade TEXT NOT NULL,
    loc_endereco TEXT,
    num_valor_pessoa REAL,
    num_valor_total REAL,
    moeda_codigo TEXT DEFAULT 'BRL',
    meta_status TEXT DEFAULT 'pendente' CHECK(meta_status IN ('pendente', 'confirmado', 'cancelado', 'concluido')),
    doc_codigo_confirmacao TEXT,
    contato_telefone TEXT,
    contato_email TEXT,
    flag_transfer_incluido BOOLEAN DEFAULT 0,
    hora_transfer_saida TIME,
    loc_transfer_saida TEXT,
    hora_transfer_retorno TIME,
    doc_dress_code TEXT,
    meta_observacoes TEXT,
    doc_caminho_arquivo TEXT,
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela: Aluguel de Carros (Entidade Core)
CREATE TABLE IF NOT EXISTS tbl_core_alugueis_carros (
    pk_aluguel_id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_locadora TEXT NOT NULL,
    doc_numero_confirmacao TEXT UNIQUE NOT NULL,
    data_retirada DATE NOT NULL,
    hora_retirada TIME NOT NULL,
    loc_retirada TEXT NOT NULL,
    loc_retirada_endereco TEXT,
    data_devolucao DATE NOT NULL,
    hora_devolucao TIME NOT NULL,
    loc_devolucao TEXT NOT NULL,
    loc_devolucao_endereco TEXT,
    num_dias INTEGER,
    doc_modelo_carro TEXT,
    num_valor REAL,
    moeda_codigo TEXT DEFAULT 'BRL',
    meta_status TEXT DEFAULT 'pendente' CHECK(meta_status IN ('pendente', 'confirmado', 'cancelado', 'concluido')),
    flag_seguro_incluido BOOLEAN DEFAULT 0,
    flag_telepeaje_incluido BOOLEAN DEFAULT 0,
    doc_politica_combustivel TEXT,
    doc_caminho_arquivo TEXT,
    meta_observacoes TEXT,
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela: Seguros Viagem (Entidade Core)
CREATE TABLE IF NOT EXISTS tbl_core_seguros (
    pk_seguro_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fk_viajante_id INTEGER NOT NULL,
    doc_seguradora TEXT NOT NULL,
    doc_numero_apolice TEXT UNIQUE NOT NULL,
    doc_numero_certificado TEXT,
    data_cobertura_inicio DATE NOT NULL,
    data_cobertura_fim DATE NOT NULL,
    num_valor REAL,
    moeda_codigo TEXT DEFAULT 'BRL',
    meta_status TEXT DEFAULT 'confirmado' CHECK(meta_status IN ('pendente', 'confirmado', 'cancelado', 'expirado')),
    doc_caminho_arquivo TEXT,
    meta_observacoes TEXT,
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_viajante_id) REFERENCES tbl_core_viajantes(pk_viajante_id)
);

-- ============================================================================
-- CATEGORIA: REF (Tabelas de Referência)
-- ============================================================================

-- Tabela: Contatos Essenciais (Referência)
CREATE TABLE IF NOT EXISTS tbl_ref_contatos (
    pk_contato_id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_nome TEXT NOT NULL,
    cat_tipo TEXT NOT NULL CHECK(cat_tipo IN ('hotel', 'restaurante', 'tour', 'emergencia', 'aluguel_carro', 'companhia_aerea', 'seguradora', 'outro')),
    contato_telefone TEXT,
    contato_email TEXT,
    loc_endereco TEXT,
    meta_observacoes TEXT,
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- CATEGORIA: META (Metadados e Controle)
-- ============================================================================

-- Tabela: Documentos Processados (Metadados ETL)
CREATE TABLE IF NOT EXISTS tbl_meta_documentos_processados (
    pk_documento_id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_caminho_arquivo TEXT UNIQUE NOT NULL,
    cat_tipo_documento TEXT NOT NULL CHECK(cat_tipo_documento IN ('cartao_embarque', 'reserva_hotel', 'seguro', 'passagem_aerea', 'aluguel_carro', 'passaporte', 'outro')),
    doc_hash_sha256 TEXT,
    meta_status_extracao TEXT DEFAULT 'pendente' CHECK(meta_status_extracao IN ('pendente', 'sucesso', 'falhou', 'parcial')),
    data_extracao TIMESTAMP,
    doc_dados_extraidos TEXT, -- JSON com dados extraídos
    meta_status_validacao TEXT DEFAULT 'pendente' CHECK(meta_status_validacao IN ('pendente', 'valido', 'invalido', 'requer_revisao')),
    meta_notas_validacao TEXT,
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela: Itinerário Detalhado (Metadados de Planejamento)
CREATE TABLE IF NOT EXISTS tbl_meta_itinerario (
    pk_itinerario_id INTEGER PRIMARY KEY AUTOINCREMENT,
    num_dia INTEGER NOT NULL,
    data_evento DATE NOT NULL,
    doc_dia_semana TEXT,
    loc_cidade TEXT NOT NULL,
    hora_evento TIME,
    cat_tipo_evento TEXT CHECK(cat_tipo_evento IN ('chegada', 'partida', 'reserva', 'atividade', 'refeicao', 'logistica', 'livre')),
    doc_titulo TEXT NOT NULL,
    doc_detalhes TEXT,
    meta_status TEXT DEFAULT 'pendente' CHECK(meta_status IN ('confirmado', 'pendente', 'sugestao', 'livre')),
    fk_reserva_id TEXT,
    meta_observacoes TEXT,
    meta_criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    meta_atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_reserva_id) REFERENCES tbl_core_reservas(doc_codigo_reserva)
);

-- ============================================================================
-- ÍNDICES PARA PERFORMANCE
-- Padrão: idx_[tabela]_[coluna(s)]
-- ============================================================================

-- Índices: Viajantes
CREATE INDEX IF NOT EXISTS idx_core_viajantes_cpf ON tbl_core_viajantes(doc_cpf);
CREATE INDEX IF NOT EXISTS idx_core_viajantes_passaporte ON tbl_core_viajantes(doc_passaporte_numero);
CREATE INDEX IF NOT EXISTS idx_core_viajantes_status ON tbl_core_viajantes(meta_status);

-- Índices: Voos
CREATE INDEX IF NOT EXISTS idx_core_voos_viajante ON tbl_core_voos(fk_viajante_id);
CREATE INDEX IF NOT EXISTS idx_core_voos_data_partida ON tbl_core_voos(data_partida);
CREATE INDEX IF NOT EXISTS idx_core_voos_status ON tbl_core_voos(meta_status);
CREATE INDEX IF NOT EXISTS idx_core_voos_numero ON tbl_core_voos(doc_numero_voo);

-- Índices: Hotéis
CREATE INDEX IF NOT EXISTS idx_core_hoteis_checkin ON tbl_core_hoteis(data_checkin);
CREATE INDEX IF NOT EXISTS idx_core_hoteis_status ON tbl_core_hoteis(meta_status);
CREATE INDEX IF NOT EXISTS idx_core_hoteis_reserva ON tbl_core_hoteis(doc_numero_reserva);

-- Índices: Reservas
CREATE INDEX IF NOT EXISTS idx_core_reservas_data ON tbl_core_reservas(data_evento);
CREATE INDEX IF NOT EXISTS idx_core_reservas_status ON tbl_core_reservas(meta_status);
CREATE INDEX IF NOT EXISTS idx_core_reservas_tipo ON tbl_core_reservas(cat_tipo);
CREATE INDEX IF NOT EXISTS idx_core_reservas_codigo ON tbl_core_reservas(doc_codigo_reserva);

-- Índices: Alugueis
CREATE INDEX IF NOT EXISTS idx_core_alugueis_data_retirada ON tbl_core_alugueis_carros(data_retirada);
CREATE INDEX IF NOT EXISTS idx_core_alugueis_status ON tbl_core_alugueis_carros(meta_status);
CREATE INDEX IF NOT EXISTS idx_core_alugueis_confirmacao ON tbl_core_alugueis_carros(doc_numero_confirmacao);

-- Índices: Seguros
CREATE INDEX IF NOT EXISTS idx_core_seguros_viajante ON tbl_core_seguros(fk_viajante_id);
CREATE INDEX IF NOT EXISTS idx_core_seguros_cobertura_inicio ON tbl_core_seguros(data_cobertura_inicio);

-- Índices: Contatos
CREATE INDEX IF NOT EXISTS idx_ref_contatos_tipo ON tbl_ref_contatos(cat_tipo);

-- Índices: Documentos Processados
CREATE INDEX IF NOT EXISTS idx_meta_documentos_status_extracao ON tbl_meta_documentos_processados(meta_status_extracao);
CREATE INDEX IF NOT EXISTS idx_meta_documentos_tipo ON tbl_meta_documentos_processados(cat_tipo_documento);
CREATE INDEX IF NOT EXISTS idx_meta_documentos_hash ON tbl_meta_documentos_processados(doc_hash_sha256);

-- Índices: Itinerário
CREATE INDEX IF NOT EXISTS idx_meta_itinerario_data ON tbl_meta_itinerario(data_evento);
CREATE INDEX IF NOT EXISTS idx_meta_itinerario_dia ON tbl_meta_itinerario(num_dia);
CREATE INDEX IF NOT EXISTS idx_meta_itinerario_status ON tbl_meta_itinerario(meta_status);
CREATE INDEX IF NOT EXISTS idx_meta_itinerario_reserva ON tbl_meta_itinerario(fk_reserva_id);

-- ============================================================================
-- COMENTÁRIOS DE GOVERNANÇA DE DADOS
-- ============================================================================

-- NOTA: Este schema segue o padrão de nomenclatura definido em:
-- 00_GEM_STRUCTURE/00_nomenclatura_e_melhores_praticas.md
--
-- PADRÃO DE NOMENCLATURA:
-- - Tabelas: tbl_[categoria]_[entidade] (ex: tbl_core_viajantes)
-- - Colunas: [prefixo]_[nome] (ex: pk_viajante_id, doc_cpf, data_nascimento)
-- - Chaves Primárias: pk_[entidade]_id
-- - Chaves Estrangeiras: fk_[entidade]_id
-- - Índices: idx_[tabela]_[coluna]
--
-- PREFIXOS DE COLUNAS:
-- - pk_ = Primary Key
-- - fk_ = Foreign Key
-- - doc_ = Documento/Número/Texto descritivo
-- - num_ = Valor numérico
-- - data_ = Data
-- - hora_ = Hora/Time
-- - loc_ = Localização/Endereço
-- - contato_ = Informações de contato
-- - cat_ = Categoria/Tipo
-- - flag_ = Boolean/Flag
-- - meta_ = Metadados/Controle
-- - moeda_ = Moeda
--
-- CATEGORIAS DE TABELAS:
-- - core_ = Entidades principais do domínio
-- - ref_ = Tabelas de referência
-- - meta_ = Metadados e controle
--
-- PII (Personally Identifiable Information):
-- Todas as colunas marcadas como PII devem ser tratadas com cuidado especial
-- conforme LGPD e boas práticas de segurança de dados.
