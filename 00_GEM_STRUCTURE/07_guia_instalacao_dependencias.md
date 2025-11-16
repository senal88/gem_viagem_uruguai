# 📦 Guia de Instalação de Dependências

## GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | GEM_STRUCTURE |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | Nenhuma |

---

## 🎯 OBJETIVO

Este guia fornece instruções completas para instalar todas as dependências necessárias para o GEM Expert, incluindo ferramentas, SDKs e configurações para todas as integrações.

---

## 📚 DEPENDÊNCIAS PRINCIPAIS

### 1. Ferramentas Base

#### Node.js e NPM

**macOS:**

```bash
# Via Homebrew (recomendado)
brew install node

# Verificar instalação
node --version
npm --version
```

**Windows:**

```bash
# Download do site oficial
# https://nodejs.org/

# Verificar instalação
node --version
npm --version
```

**Linux:**

```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verificar instalação
node --version
npm --version
```

#### Git

**macOS:**

```bash
# Via Homebrew
brew install git

# Verificar instalação
git --version
```

**Windows:**

```bash
# Download do site oficial
# https://git-scm.com/download/win

# Verificar instalação
git --version
```

**Linux:**

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install git

# Verificar instalação
git --version
```

---

### 2. MCP Servers (Claude Desktop)

#### Instalação via NPX (Recomendado)

Os servidores serão instalados automaticamente na primeira execução:

```bash
# Testar instalação automática
npx -y @modelcontextprotocol/server-filesystem --help
npx -y @modelcontextprotocol/server-web-search --help
npx -y @modelcontextprotocol/server-git --help
```

#### Instalação Global (Opcional)

```bash
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-web-search
npm install -g @modelcontextprotocol/server-git
```

---

### 3. Python (Para Scripts e Automação)

**macOS:**

```bash
brew install python@3.11

# Verificar instalação
python3 --version
pip3 --version
```

**Windows:**

```bash
# Download do site oficial
# https://www.python.org/downloads/

# Verificar instalação
python --version
pip --version
```

**Linux:**

```bash
sudo apt-get update
sudo apt-get install python3 python3-pip

# Verificar instalação
python3 --version
pip3 --version
```

---

### 4. SDKs e Bibliotecas

#### OpenAI Python SDK

```bash
pip3 install openai

# Verificar instalação
python3 -c "import openai; print(openai.__version__)"
```

#### Anthropic Python SDK

```bash
pip3 install anthropic

# Verificar instalação
python3 -c "import anthropic; print(anthropic.__version__)"
```

#### Google Generative AI SDK

```bash
pip3 install google-generativeai

# Verificar instalação
python3 -c "import google.generativeai as genai; print('OK')"
```

---

## 🔧 CONFIGURAÇÃO DE VARIÁVEIS DE AMBIENTE

### Criar Arquivo .env

Crie um arquivo `.env` na raiz do repositório:

```bash
# Criar arquivo .env
touch .env
```

### Template de .env

```bash
# GitHub
GITHUB_TOKEN=seu_github_token_aqui
GITHUB_USERNAME=senal88
GITHUB_REPO=gem_viagem_uruguai
GITHUB_OWNER=senal88

# OpenAI
OPENAI_API_KEY=sua_openai_api_key_aqui
OPENAI_MODEL=gpt-4-turbo-preview

# Anthropic (Claude)
ANTHROPIC_API_KEY=sua_anthropic_api_key_aqui
ANTHROPIC_MODEL=claude-3-5-sonnet-20241022

# Google (Gemini)
GOOGLE_API_KEY=sua_google_api_key_aqui
GOOGLE_MODEL=gemini-2.5-pro

# Busca Web
GOOGLE_CSE_ID=seu_google_cse_id_aqui
TAVILY_API_KEY=sua_tavily_api_key_aqui
SEARCH_PROVIDER=duckduckgo

# Configurações
NODE_ENV=development
LOG_LEVEL=info
```

### Adicionar ao .gitignore

```bash
# Adicionar ao .gitignore
echo ".env" >> .gitignore
```

---

## 📝 SCRIPT DE INSTALAÇÃO AUTOMATIZADA

### Script para macOS/Linux

Crie `scripts/install_dependencies.sh`:

```bash
#!/bin/bash

echo "🚀 Instalando dependências do GEM Expert..."

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não encontrado. Instalando..."
    brew install node  # macOS
    # sudo apt-get install nodejs npm  # Linux
fi

# Verificar Git
if ! command -v git &> /dev/null; then
    echo "❌ Git não encontrado. Instalando..."
    brew install git  # macOS
    # sudo apt-get install git  # Linux
fi

# Verificar Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 não encontrado. Instalando..."
    brew install python@3.11  # macOS
    # sudo apt-get install python3 python3-pip  # Linux
fi

# Instalar SDKs Python
echo "📦 Instalando SDKs Python..."
pip3 install openai anthropic google-generativeai

# Testar MCP Servers
echo "🧪 Testando MCP Servers..."
npx -y @modelcontextprotocol/server-filesystem --help > /dev/null 2>&1
npx -y @modelcontextprotocol/server-web-search --help > /dev/null 2>&1
npx -y @modelcontextprotocol/server-git --help > /dev/null 2>&1

echo "✅ Instalação concluída!"
```

### Script para Windows

Crie `scripts/install_dependencies.ps1`:

```powershell
Write-Host "🚀 Instalando dependências do GEM Expert..." -ForegroundColor Green

# Verificar Node.js
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js não encontrado. Instale manualmente de https://nodejs.org/" -ForegroundColor Red
}

# Verificar Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git não encontrado. Instale manualmente de https://git-scm.com/" -ForegroundColor Red
}

# Verificar Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Python não encontrado. Instale manualmente de https://www.python.org/" -ForegroundColor Red
}

# Instalar SDKs Python
Write-Host "📦 Instalando SDKs Python..." -ForegroundColor Yellow
pip install openai anthropic google-generativeai

Write-Host "✅ Instalação concluída!" -ForegroundColor Green
```

---

## ✅ CHECKLIST DE INSTALAÇÃO

### Ferramentas Base

- [ ] Node.js instalado (v18+)
- [ ] NPM instalado
- [ ] Git instalado
- [ ] Python 3.11+ instalado
- [ ] Pip instalado

### MCP Servers

- [ ] Filesystem server testado
- [ ] Web Search server testado
- [ ] Git server testado

### SDKs Python

- [ ] OpenAI SDK instalado
- [ ] Anthropic SDK instalado
- [ ] Google Generative AI SDK instalado

### Variáveis de Ambiente

- [ ] Arquivo .env criado
- [ ] GitHub token configurado
- [ ] OpenAI API key configurada (se usar)
- [ ] Anthropic API key configurada (se usar)
- [ ] Google API key configurada (se usar)
- [ ] .env adicionado ao .gitignore

---

## 🔗 REFERÊNCIAS

### Documentação Oficial

- **Node.js**: <https://nodejs.org/>
- **Git**: <https://git-scm.com/>
- **Python**: <https://www.python.org/>
- **MCP Protocol**: <https://modelcontextprotocol.io>
- **OpenAI**: <https://platform.openai.com/>
- **Anthropic**: <https://www.anthropic.com/>
- **Google AI**: <https://ai.google.dev/>

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ GUIA COMPLETO
