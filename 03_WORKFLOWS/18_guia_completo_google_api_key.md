# 🔑 Guia Completo: Google API Key
## Como Gerar ou Buscar sua Chave de API do Google

---

## 📋 ÍNDICE

1. [O que é Google API Key?](#o-que-é)
2. [Como Gerar uma Nova API Key](#gerar-nova)
3. [Como Encontrar uma API Key Existente](#encontrar-existente)
4. [Como Configurar no Projeto](#configurar-projeto)
5. [Verificar se Está Funcionando](#verificar)
6. [Troubleshooting](#troubleshooting)

---

## 🎯 O QUE É GOOGLE API KEY?

A Google API Key é uma chave de autenticação que permite que sua aplicação use os serviços da Google, como:
- **Gemini AI** (Google Generative AI)
- **Google Maps API**
- **Google Cloud Services**
- **YouTube Data API**
- Entre outros

Para o projeto GEM Expert, usamos para acessar o **Gemini 2.5 Pro**.

---

## 🆕 COMO GERAR UMA NOVA API KEY

### Passo 1: Acessar Google AI Studio

1. Abra seu navegador
2. Acesse: **https://aistudio.google.com/**
3. Faça login com sua conta Google

### Passo 2: Criar Nova API Key

1. No menu lateral, clique em **"Get API Key"** ou **"Obter chave de API"**
2. Se aparecer uma lista de projetos, selecione um existente ou:
   - Clique em **"Create API Key"** ou **"Criar chave de API"**
   - Ou clique em **"Create API Key in New Project"** para criar em um projeto novo

### Passo 3: Escolher Projeto Google Cloud

1. Se você já tem projetos Google Cloud:
   - Selecione o projeto desejado na lista
   - Clique em **"Create API Key in Selected Project"**
2. Se não tem projetos:
   - Clique em **"Create API Key in New Project"**
   - Digite um nome para o projeto (ex: "gem-expert-uruguai")
   - Clique em **"Create"**

### Passo 4: Copiar a API Key

1. Após criar, você verá uma tela com sua API Key
2. **IMPORTANTE**: Copie a chave imediatamente! Ela só aparece uma vez
3. A chave terá formato: `AIzaSy...` (cerca de 39 caracteres)

### Passo 5: Configurar Restrições (Recomendado)

1. Na mesma tela, clique em **"Restrict API Key"** ou **"Restringir chave de API"**
2. **Restrições de Aplicativo**:
   - Selecione **"IP addresses"** para VPS
   - Adicione o IP da sua VPS: `147.79.81.59`
   - Ou selecione **"None"** para desenvolvimento local
3. **Restrições de API**:
   - Selecione **"Restrict key"**
   - Marque apenas: **"Generative Language API"**
4. Clique em **"Save"** ou **"Salvar"**

---

## 🔍 COMO ENCONTRAR UMA API KEY EXISTENTE

### Método 1: Google AI Studio (Mais Fácil)

1. Acesse: **https://aistudio.google.com/**
2. Faça login
3. No menu lateral, clique em **"Get API Key"**
4. Você verá todas as suas API Keys ativas
5. Clique na chave desejada para copiar

### Método 2: Google Cloud Console

1. Acesse: **https://console.cloud.google.com/**
2. Faça login
3. Selecione seu projeto (ou crie um novo)
4. No menu lateral, vá em **"APIs & Services"** → **"Credentials"**
5. Na seção **"API Keys"**, você verá todas as chaves
6. Clique na chave desejada para ver detalhes e copiar

### Método 3: Verificar no Projeto Atual

Se você já configurou antes, pode estar em:

#### No Mac (desenvolvimento local):

```bash
cd ~/gem_viagem_uruguai
cat .env | grep GOOGLE_API_KEY
```

#### Na VPS:

```bash
ssh root@147.79.81.59
cat /opt/gem_viagem_uruguai/06_DASHBOARD/.env | grep GOOGLE_API_KEY
```

#### No 1Password (se salvou):

1. Abra o 1Password
2. Procure por: **"GEMINI_API_KEY"** ou **"Google API"**
3. Veja o campo **"credential"** ou **"api_key"**

---

## ⚙️ COMO CONFIGURAR NO PROJETO

### Opção 1: Configurar Localmente (Mac)

```bash
cd ~/gem_viagem_uruguai

# Editar arquivo .env
nano .env

# Adicionar ou atualizar:
GOOGLE_API_KEY=sua_chave_aqui
```

### Opção 2: Configurar na VPS

```bash
# Conectar na VPS
ssh root@147.79.81.59

# Editar arquivo .env
nano /opt/gem_viagem_uruguai/06_DASHBOARD/.env

# Adicionar ou atualizar:
GOOGLE_API_KEY=sua_chave_aqui

# Reiniciar serviço
systemctl restart gemexpert
```

### Opção 3: Via Terminal (Mac)

```bash
cd ~/gem_viagem_uruguai

# Adicionar ao .env
echo "GOOGLE_API_KEY=sua_chave_aqui" >> .env

# Ou substituir se já existe
sed -i '' 's/GOOGLE_API_KEY=.*/GOOGLE_API_KEY=sua_chave_aqui/' .env
```

### Opção 4: Via Terminal (VPS)

```bash
ssh root@147.79.81.59

# Adicionar ao .env
echo "GOOGLE_API_KEY=sua_chave_aqui" >> /opt/gem_viagem_uruguai/06_DASHBOARD/.env

# Ou substituir se já existe
sed -i 's/GOOGLE_API_KEY=.*/GOOGLE_API_KEY=sua_chave_aqui/' /opt/gem_viagem_uruguai/06_DASHBOARD/.env

# Reiniciar serviço
systemctl restart gemexpert
```

---

## ✅ VERIFICAR SE ESTÁ FUNCIONANDO

### Teste 1: Verificar Variável de Ambiente

#### No Mac:

```bash
cd ~/gem_viagem_uruguai
source venv/bin/activate
python3 -c "import os; from dotenv import load_dotenv; load_dotenv(); print('GOOGLE_API_KEY:', os.getenv('GOOGLE_API_KEY')[:10] + '...' if os.getenv('GOOGLE_API_KEY') else 'NÃO CONFIGURADA')"
```

#### Na VPS:

```bash
ssh root@147.79.81.59
cd /opt/gem_viagem_uruguai/06_DASHBOARD
source venv/bin/activate
python3 -c "import os; from dotenv import load_dotenv; load_dotenv(); print('GOOGLE_API_KEY:', os.getenv('GOOGLE_API_KEY')[:10] + '...' if os.getenv('GOOGLE_API_KEY') else 'NÃO CONFIGURADA')"
```

### Teste 2: Testar Conexão com Gemini

#### No Mac:

```bash
cd ~/gem_viagem_uruguai
source venv/bin/activate
python3 << 'EOF'
import os
from dotenv import load_dotenv
import google.generativeai as genai

load_dotenv()
api_key = os.getenv('GOOGLE_API_KEY')

if not api_key:
    print("❌ GOOGLE_API_KEY não configurada")
    exit(1)

try:
    genai.configure(api_key=api_key)
    model = genai.GenerativeModel('gemini-2.5-pro')
    response = model.generate_content("Diga apenas 'OK' se você está funcionando")
    print(f"✅ Gemini funcionando! Resposta: {response.text}")
except Exception as e:
    print(f"❌ Erro: {e}")
EOF
```

#### Na VPS:

```bash
ssh root@147.79.81.59
cd /opt/gem_viagem_uruguai/06_DASHBOARD
source venv/bin/activate
python3 << 'EOF'
import os
from dotenv import load_dotenv
import google.generativeai as genai

load_dotenv()
api_key = os.getenv('GOOGLE_API_KEY')

if not api_key:
    print("❌ GOOGLE_API_KEY não configurada")
    exit(1)

try:
    genai.configure(api_key=api_key)
    model = genai.GenerativeModel('gemini-2.5-pro')
    response = model.generate_content("Diga apenas 'OK' se você está funcionando")
    print(f"✅ Gemini funcionando! Resposta: {response.text}")
except Exception as e:
    print(f"❌ Erro: {e}")
EOF
```

### Teste 3: Testar no Dashboard

1. Acesse: http://senamfo.com.br:8081/gem/
2. No chat, selecione **"Gemini 2.5 Pro"** no dropdown
3. Digite uma mensagem de teste
4. Se funcionar, você receberá uma resposta do Gemini

---

## 🐛 TROUBLESHOOTING

### Erro: "API keys are not supported"

**Causa**: Você está usando uma API Key, mas o serviço requer OAuth2.

**Solução**:
- Use a API Key diretamente do Google AI Studio (https://aistudio.google.com/)
- Não use Service Account JSON

### Erro: "API key not valid"

**Causas possíveis**:
1. Chave copiada incorretamente
2. Chave com espaços extras
3. Chave de outro projeto

**Solução**:
```bash
# Verificar formato da chave (deve começar com AIzaSy)
grep GOOGLE_API_KEY .env

# Remover espaços extras
sed -i '' 's/GOOGLE_API_KEY= *\(.*\)/GOOGLE_API_KEY=\1/' .env
```

### Erro: "Quota exceeded"

**Causa**: Limite de uso da API atingido.

**Solução**:
1. Verifique seu uso em: https://console.cloud.google.com/apis/dashboard
2. Aguarde reset (geralmente diário)
3. Ou aumente o limite no Google Cloud Console

### Erro: "Permission denied"

**Causa**: API Key sem permissões ou restrições muito restritivas.

**Solução**:
1. Acesse Google Cloud Console
2. Vá em "APIs & Services" → "Credentials"
3. Clique na sua API Key
4. Verifique se "Generative Language API" está habilitada
5. Ajuste restrições de IP se necessário

### Chave Não Aparece no .env

**Solução**:
```bash
# Verificar se arquivo existe
ls -la .env

# Criar se não existe
touch .env

# Adicionar chave
echo "GOOGLE_API_KEY=sua_chave_aqui" >> .env
```

---

## 📝 RESUMO RÁPIDO

### Para Gerar Nova:

1. Acesse: https://aistudio.google.com/
2. Clique em "Get API Key"
3. Crie em projeto novo ou existente
4. Copie a chave (formato: `AIzaSy...`)

### Para Encontrar Existente:

1. https://aistudio.google.com/ → "Get API Key"
2. Ou: https://console.cloud.google.com/ → "APIs & Services" → "Credentials"
3. Ou: Verificar `.env` no projeto

### Para Configurar:

```bash
# Mac
echo "GOOGLE_API_KEY=sua_chave" >> ~/gem_viagem_uruguai/.env

# VPS
ssh root@147.79.81.59
echo "GOOGLE_API_KEY=sua_chave" >> /opt/gem_viagem_uruguai/06_DASHBOARD/.env
systemctl restart gemexpert
```

---

## 🔗 LINKS ÚTEIS

- **Google AI Studio**: https://aistudio.google.com/
- **Google Cloud Console**: https://console.cloud.google.com/
- **Documentação Gemini**: https://ai.google.dev/docs
- **Gerenciar API Keys**: https://console.cloud.google.com/apis/credentials

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0

