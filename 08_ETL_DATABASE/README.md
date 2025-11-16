# 🔄 Sistema ETL e Banco de Dados

Sistema completo de Extração, Transformação e Carga (ETL) para processar documentos da viagem e manter dados estruturados sincronizados.

## 📋 Estrutura

```
08_ETL_DATABASE/
├── schema.sql              # Schema do banco de dados SQLite
├── etl_extractor.py        # Extração de dados de PDFs
├── etl_loader.py           # Carregamento de dados estruturados
├── etl_validator.py        # Validação e verificação de consistência
├── etl_updater.py          # Atualização de documentos Markdown/JSON
├── run_etl.py              # Script principal (executa pipeline completo)
├── viagem_uruguai.db      # Banco de dados SQLite (gerado)
└── README.md               # Este arquivo
```

## 🗄️ Schema do Banco de Dados

### Tabelas Principais

- **travelers**: Viajantes (Aline e Luiz Fernando)
- **flights**: Voos e cartões de embarque
- **hotels**: Reservas de hotéis
- **reservations**: Reservas de atividades/tours/eventos
- **car_rentals**: Aluguel de carros
- **insurances**: Seguros de viagem
- **itinerary**: Itinerário detalhado dia a dia
- **contacts**: Contatos essenciais
- **processed_documents**: Documentos PDF processados

## 🚀 Uso

### Instalação de Dependências

```bash
pip install pdfplumber sqlite3
# ou
pip install PyPDF2 sqlite3
```

### Executar Pipeline Completo

```bash
cd 08_ETL_DATABASE
python run_etl.py
```

### Executar Etapas Individuais

```bash
# 1. Extrair dados de PDFs
python etl_extractor.py

# 2. Carregar dados estruturados
python etl_loader.py

# 3. Validar dados
python etl_validator.py

# 4. Atualizar documentos
python etl_updater.py
```

## 📊 Fluxo de Dados

```
PDFs (Documentos)
    ↓
[Extractor] → Extrai texto e dados
    ↓
[Loader] → Carrega no banco SQLite
    ↓
[Validator] → Valida consistência
    ↓
[Updater] → Atualiza JSONs e Markdown
```

## 🔍 Validações Realizadas

1. **Completude**: Verifica se todos os dados necessários estão presentes
2. **Consistência**: Valida datas, períodos, números de confirmação
3. **Referências**: Verifica se reservas referenciadas existem
4. **Timeline**: Valida sequência temporal dos eventos

## 📝 Documentos Processados

O sistema processa automaticamente:

- ✅ Cartões de embarque (PDF)
- ✅ Reservas de hotéis (PDF)
- ✅ Aluguel de carro (PDF)
- ✅ Seguro viagem (PDF)
- ✅ Passagens aéreas (PDF)

## 🔄 Sincronização

O sistema mantém sincronizados:

- `04_DADOS_ESTRUTURADOS/01_reservas_estruturadas.json`
- `04_DADOS_ESTRUTURADOS/03_roteiro_timeline.json`
- `04_DADOS_ESTRUTURADOS/04_hoteis_montevideo.json`
- `01_BASE_CONHECIMENTO/03_reservas_confirmadas.md` (atualização manual recomendada)

## ⚠️ Notas

- O banco de dados SQLite é criado automaticamente na primeira execução
- Documentos já processados são identificados por hash e não são reprocessados
- Validações podem identificar problemas que requerem atenção manual

## 📊 Relatórios

Após a execução, são gerados:

- `validation_report.json`: Relatório completo de validação
- Estatísticas no console: Resumo dos dados processados

