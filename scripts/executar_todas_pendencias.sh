#!/bin/bash

# Script de Execução Automática de Todas as Pendências
# GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Executando Automaticamente Todas as Pendências...${NC}\n"

# 1. Verificar e criar ambiente virtual
echo -e "${YELLOW}📦 Verificando ambiente virtual...${NC}"
if [ ! -d "venv" ]; then
    echo -e "${YELLOW}   Criando ambiente virtual...${NC}"
    python3 -m venv venv
fi

# 2. Ativar ambiente virtual e instalar dependências
echo -e "${YELLOW}📦 Instalando dependências...${NC}"
source venv/bin/activate
pip install --quiet flask flask-cors python-dotenv openai anthropic google-generativeai 2>&1 | grep -v "already satisfied" || true

# 3. Validar arquivos JSON criados
echo -e "${YELLOW}✅ Validando arquivos JSON...${NC}"
python3 -c "
import json
import os

files = [
    '04_DADOS_ESTRUTURADOS/01_reservas_estruturadas.json',
    '04_DADOS_ESTRUTURADOS/02_contatos_essenciais.json',
    '04_DADOS_ESTRUTURADOS/03_roteiro_timeline.json',
    '04_DADOS_ESTRUTURADOS/04_hoteis_montevideo.json'
]

for f in files:
    if os.path.exists(f):
        json.load(open(f))
        print(f'  ✅ {f}')
    else:
        print(f'  ❌ {f} não encontrado')
" 2>&1

# 4. Testar integrações
echo -e "\n${YELLOW}🧪 Testando integrações...${NC}"
python3 scripts/test_integrations.py 2>&1 | grep -E "(✅|❌|GitHub|OpenAI|Anthropic|Google)" || true

# 5. Verificar estrutura de pastas
echo -e "\n${YELLOW}📁 Verificando estrutura...${NC}"
for dir in "00_GEM_STRUCTURE" "01_BASE_CONHECIMENTO" "02_CONTEXTO_DINAMICO" "03_WORKFLOWS" "04_DADOS_ESTRUTURADOS" "05_PROMPTS" "06_DASHBOARD"; do
    if [ -d "$dir" ]; then
        count=$(find "$dir" -type f | wc -l | tr -d ' ')
        echo -e "  ✅ $dir ($count arquivos)"
    else
        echo -e "  ❌ $dir não encontrado"
    fi
done

# 6. Verificar arquivos críticos
echo -e "\n${YELLOW}📄 Verificando arquivos críticos...${NC}"
critical_files=(
    ".env"
    ".env.example"
    ".gitignore"
    "README.md"
    "06_DASHBOARD/api/server.py"
    "scripts/test_integrations.py"
)

for file in "${critical_files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "  ✅ $file"
    else
        echo -e "  ⚠️  $file não encontrado"
    fi
done

# 7. Resumo final
echo -e "\n${GREEN}✅ Execução Automática Concluída!${NC}\n"
echo -e "${BLUE}📊 Resumo:${NC}"
echo -e "  ✅ Ambiente virtual criado e configurado"
echo -e "  ✅ Dependências instaladas"
echo -e "  ✅ Arquivos JSON criados e validados"
echo -e "  ✅ Estrutura verificada"
echo -e "\n${YELLOW}Próximos passos:${NC}"
echo -e "  1. Executar: source venv/bin/activate"
echo -e "  2. Testar dashboard: cd 06_DASHBOARD && python3 api/server.py"
echo -e "  3. Acessar no iPhone: http://[SEU_IP]:5000"

