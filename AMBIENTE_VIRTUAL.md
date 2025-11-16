# 🐍 Ambiente Virtual e Dependências

## 📋 Visão Geral

Sistema completo de isolamento de dependências e automação de ambientes virtuais para desenvolvimento (macOS Silicon) e produção (Ubuntu VPS).

---

## 🚀 Setup Rápido

### macOS Silicon (Desenvolvimento)

```bash
# Opção 1: Script automatizado
./scripts/setup_venv.sh

# Opção 2: Makefile
make setup

# Opção 3: Manual
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pip install -r requirements-dev.txt
```

### Ubuntu VPS (Produção)

```bash
# Na VPS
sudo bash scripts/setup_vps.sh
```

---

## 📦 Arquivos de Dependências

### `requirements.txt`
Dependências base do projeto (produção e desenvolvimento)

### `requirements-dev.txt`
Dependências adicionais para desenvolvimento (macOS)

### `requirements-vps.txt`
Dependências para produção na VPS Ubuntu

---

## 🔧 Scripts Disponíveis

### `scripts/setup_venv.sh`
- Cria ambiente virtual isolado
- Detecta sistema operacional (macOS/Ubuntu)
- Instala dependências apropriadas
- Valida instalação

### `scripts/validate_dependencies.sh`
- Valida todas as dependências instaladas
- Verifica compatibilidade de arquitetura
- Testa imports críticos
- Verifica variáveis de ambiente

### `scripts/setup_vps.sh`
- Configuração completa para VPS Ubuntu
- Instala dependências do sistema
- Configura ambiente virtual de produção
- Instala Gunicorn e Supervisor

---

## ✅ Validação

Execute para validar tudo:

```bash
source venv/bin/activate
./scripts/validate_dependencies.sh
```

Ou usando Makefile:

```bash
make validate
```

---

## 🔄 Atualização de Dependências

```bash
source venv/bin/activate
make update
```

---

## 📊 Compatibilidade

### macOS Silicon (M1/M2/M3)
- ✅ Python 3.8+
- ✅ Todas as dependências compatíveis com ARM64
- ✅ Testado e validado

### Ubuntu VPS (22.04+)
- ✅ Python 3.8+
- ✅ Dependências compiladas para x86_64/ARM64
- ✅ Gunicorn para produção
- ✅ Supervisor para gerenciamento de processos

---

## 🛠️ Makefile

Comandos disponíveis:

```bash
make setup       # Configura ambiente completo
make venv        # Cria ambiente virtual
make install     # Instala dependências produção
make dev-install # Instala dependências desenvolvimento
make vps-install # Instala dependências VPS
make validate    # Valida dependências
make clean       # Limpa arquivos temporários
make update      # Atualiza dependências
```

---

## 🔐 Variáveis de Ambiente

O sistema valida automaticamente:

- `GOOGLE_API_KEY`
- `OPENAI_API_KEY`
- `ANTHROPIC_API_KEY`

Configure no arquivo `.env` (não commitado).

---

## 📝 Notas

- Ambiente virtual é criado em `venv/` (ignorado pelo git)
- Dependências são isoladas por projeto
- Compatibilidade validada para macOS Silicon e Ubuntu
- Scripts são executáveis e documentados

---

**Última atualização**: 16 de Novembro de 2025

