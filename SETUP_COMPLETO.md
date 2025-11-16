# 🚀 Setup Completo - GEM Expert Viagem Uruguai

## ✅ Sistema de Ambiente Virtual e Dependências

Sistema completo automatizado para isolamento de dependências e configuração de ambientes virtuais.

---

## 📋 Pré-requisitos

- Python 3.8 ou superior
- pip (geralmente incluído com Python)
- Git (para clonar repositório)

---

## 🍎 macOS Silicon (Desenvolvimento)

### Setup Automatizado

```bash
# Clone o repositório (se ainda não tiver)
git clone https://github.com/senal88/gem_viagem_uruguai.git
cd gem_viagem_uruguai

# Execute o setup automatizado
./scripts/setup_venv.sh

# Ou use o Makefile
make setup
```

### Validação

```bash
source venv/bin/activate
./scripts/validate_dependencies.sh
# ou
make validate
```

### Verificação de Compatibilidade

```bash
source venv/bin/activate
./scripts/check_compatibility.sh
```

---

## 🐧 Ubuntu VPS (Produção)

### Setup na VPS

```bash
# Conecte-se na VPS
ssh usuario@senamfo.com.br

# Clone o repositório
git clone https://github.com/senal88/gem_viagem_uruguai.git
cd gem_viagem_uruguai

# Execute o setup da VPS
sudo bash scripts/setup_vps.sh
```

### Configuração Manual (Alternativa)

```bash
# Instalar dependências do sistema
sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-venv nginx supervisor

# Criar ambiente virtual
python3 -m venv venv
source venv/bin/activate

# Instalar dependências de produção
pip install --upgrade pip
pip install -r requirements-vps.txt
```

---

## 📦 Estrutura de Dependências

### `requirements.txt`
Dependências base (comum a todos os ambientes):
- Flask, Flask-CORS
- OpenAI, Anthropic, Google Generative AI
- Requests, HTTPX
- pdfplumber, PyPDF2
- python-dotenv, python-dateutil, psutil

### `requirements-dev.txt`
Dependências adicionais para desenvolvimento:
- pytest, pytest-cov (testes)
- black, flake8, mypy (qualidade de código)
- ipython, ipdb (desenvolvimento interativo)

### `requirements-vps.txt`
Dependências para produção na VPS:
- Todas as dependências base
- Gunicorn (servidor WSGI)
- Supervisor (gerenciamento de processos)

---

## 🔧 Scripts Disponíveis

| Script | Descrição |
|--------|-----------|
| `setup_venv.sh` | Cria ambiente virtual e instala dependências |
| `validate_dependencies.sh` | Valida todas as dependências instaladas |
| `check_compatibility.sh` | Verifica compatibilidade completa |
| `setup_vps.sh` | Configuração completa para VPS Ubuntu |

---

## ✅ Validação Completa

Execute todos os testes:

```bash
source venv/bin/activate

# 1. Validar dependências
./scripts/validate_dependencies.sh

# 2. Verificar compatibilidade
./scripts/check_compatibility.sh

# 3. Testar imports críticos
python3 -c "from flask import Flask; print('✅ Flask OK')"
python3 -c "import openai; print('✅ OpenAI OK')"
python3 -c "import anthropic; print('✅ Anthropic OK')"
python3 -c "import google.generativeai; print('✅ Google AI OK')"
```

---

## 🔄 Atualização

### Atualizar Dependências

```bash
source venv/bin/activate
make update
# ou
pip install --upgrade -r requirements.txt
```

### Recriar Ambiente Virtual

```bash
rm -rf venv
./scripts/setup_venv.sh
```

---

## 📊 Compatibilidade Verificada

### ✅ macOS Silicon (M1/M2/M3)
- Python 3.8+
- ARM64 (Apple Silicon)
- Todas as dependências compatíveis
- Testado e validado

### ✅ Ubuntu VPS (22.04+)
- Python 3.8+
- x86_64 / ARM64
- Gunicorn para produção
- Supervisor para processos
- Nginx para proxy reverso

---

## 🛠️ Makefile

Comandos rápidos:

```bash
make setup       # Setup completo
make venv        # Criar venv
make install     # Instalar produção
make dev-install # Instalar desenvolvimento
make vps-install # Instalar VPS
make validate    # Validar dependências
make clean       # Limpar temporários
make update      # Atualizar dependências
```

---

## 🔐 Variáveis de Ambiente

Configure no arquivo `.env`:

```bash
GOOGLE_API_KEY=sua_chave_aqui
OPENAI_API_KEY=sua_chave_aqui
ANTHROPIC_API_KEY=sua_chave_aqui
```

O sistema valida automaticamente essas variáveis.

---

## 📝 Notas Importantes

1. **Ambiente Virtual**: Sempre ative antes de trabalhar:
   ```bash
   source venv/bin/activate
   ```

2. **Git**: O diretório `venv/` está no `.gitignore` e não será commitado

3. **Compatibilidade**: Todas as dependências são compatíveis com macOS Silicon e Ubuntu

4. **Produção**: Use `requirements-vps.txt` na VPS para incluir Gunicorn e Supervisor

---

## 🎯 Status

✅ Sistema completo e testado  
✅ Compatível macOS Silicon e Ubuntu VPS  
✅ Scripts automatizados funcionando  
✅ Validação completa implementada  

---

**Última atualização**: 16 de Novembro de 2025

