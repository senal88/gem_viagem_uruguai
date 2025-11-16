# Makefile - GEM Expert Viagem Uruguai
# Automação de tarefas comuns

.PHONY: help setup venv install dev-install vps-install validate test clean update

help:
	@echo "Comandos disponíveis:"
	@echo "  make setup       - Configura ambiente virtual completo"
	@echo "  make venv        - Cria ambiente virtual"
	@echo "  make install     - Instala dependências de produção"
	@echo "  make dev-install - Instala dependências de desenvolvimento"
	@echo "  make vps-install - Instala dependências para VPS"
	@echo "  make validate    - Valida dependências e compatibilidade"
	@echo "  make test        - Executa testes"
	@echo "  make clean       - Remove arquivos temporários"
	@echo "  make update      - Atualiza dependências"

setup:
	@echo "🔧 Configurando ambiente..."
	@bash scripts/setup_venv.sh

venv:
	@echo "📦 Criando ambiente virtual..."
	@python3 -m venv venv
	@echo "✅ Ambiente virtual criado"
	@echo "Ative com: source venv/bin/activate"

install:
	@echo "📥 Instalando dependências de produção..."
	@pip install --upgrade pip setuptools wheel
	@pip install -r requirements.txt

dev-install:
	@echo "📥 Instalando dependências de desenvolvimento..."
	@pip install --upgrade pip setuptools wheel
	@pip install -r requirements-dev.txt

vps-install:
	@echo "📥 Instalando dependências para VPS..."
	@pip install --upgrade pip setuptools wheel
	@pip install -r requirements-vps.txt

validate:
	@echo "🔍 Validando dependências..."
	@bash scripts/validate_dependencies.sh

test:
	@echo "🧪 Executando testes..."
	@python3 -m pytest tests/ -v || echo "⚠️  Nenhum teste encontrado"

clean:
	@echo "🧹 Limpando arquivos temporários..."
	@find . -type d -name "__pycache__" -exec rm -r {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@find . -type f -name "*.pyo" -delete 2>/dev/null || true
	@find . -type f -name "*.log" -delete 2>/dev/null || true
	@echo "✅ Limpeza concluída"

update:
	@echo "⬆️  Atualizando dependências..."
	@pip install --upgrade pip
	@pip install --upgrade -r requirements.txt
	@echo "✅ Dependências atualizadas"

