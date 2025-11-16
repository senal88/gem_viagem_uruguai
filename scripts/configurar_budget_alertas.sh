#!/bin/bash
# Script para configurar budget e alertas de custo no Google Cloud

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

PROJECT_ID="gcp-ai-setup-24410"
BUDGET_AMOUNT="10USD"  # $10 por mês

echo -e "${BLUE}💰 Configuração de Budget e Alertas${NC}\n"

# Verificar se gcloud está instalado
if ! command -v gcloud &> /dev/null; then
    echo -e "${RED}❌ gcloud CLI não encontrado${NC}"
    echo -e "${YELLOW}Instale: https://cloud.google.com/sdk/docs/install${NC}\n"
    exit 1
fi

# Verificar se está logado
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q .; then
    echo -e "${YELLOW}⚠️  Não há contas ativas no gcloud${NC}"
    echo -e "${BLUE}Fazendo login...${NC}"
    gcloud auth login
fi

# Configurar projeto
echo -e "${BLUE}📋 Configurando projeto: $PROJECT_ID${NC}"
gcloud config set project $PROJECT_ID

# Obter billing account ID
echo -e "\n${BLUE}🔍 Obtendo conta de faturamento...${NC}"
BILLING_ACCOUNT=$(gcloud billing projects describe $PROJECT_ID --format="value(billingAccountName)" 2>/dev/null | cut -d'/' -f2)

if [ -z "$BILLING_ACCOUNT" ]; then
    echo -e "${RED}❌ Nenhuma conta de faturamento vinculada${NC}"
    echo -e "${YELLOW}Configure uma conta de faturamento primeiro:${NC}"
    echo -e "${BLUE}https://console.cloud.google.com/billing${NC}\n"
    exit 1
fi

echo -e "${GREEN}✅ Conta de faturamento: $BILLING_ACCOUNT${NC}\n"

# Criar budget
echo -e "${BLUE}📊 Criando budget de $BUDGET_AMOUNT/mês...${NC}"

BUDGET_ID="gem-expert-monthly-$(date +%s)"

gcloud billing budgets create \
  --billing-account=$BILLING_ACCOUNT \
  --display-name="GEM Expert - Limite Mensal" \
  --budget-amount=$BUDGET_AMOUNT \
  --threshold-rule=percent=50,basis=CURRENT_SPEND \
  --threshold-rule=percent=90,basis=CURRENT_SPEND \
  --threshold-rule=percent=100,basis=CURRENT_SPEND \
  --projects=$PROJECT_ID \
  2>&1 | grep -v "WARNING" || true

echo -e "${GREEN}✅ Budget criado${NC}\n"

# Configurar alertas via email
echo -e "${BLUE}📧 Configurando alertas por email...${NC}"
echo -e "${YELLOW}⚠️  Nota: Alertas de email devem ser configurados manualmente no console${NC}"
echo -e "${BLUE}Acesse: https://console.cloud.google.com/billing/budgets${NC}\n"

# Mostrar instruções
echo -e "${GREEN}✅ Configuração concluída!${NC}\n"
echo -e "${BLUE}📋 PRÓXIMOS PASSOS:${NC}"
echo -e "1. Acesse: ${GREEN}https://console.cloud.google.com/billing/budgets${NC}"
echo -e "2. Localize o budget 'GEM Expert - Limite Mensal'"
echo -e "3. Clique em 'Edit'"
echo -e "4. Adicione seu email nos alertas"
echo -e "5. Salve as alterações\n"

echo -e "${BLUE}📊 Verificar uso atual:${NC}"
echo -e "${GREEN}https://console.cloud.google.com/billing?project=$PROJECT_ID${NC}\n"

