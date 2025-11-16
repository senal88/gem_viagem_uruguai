# ⚡ Quick Start: Claude Desktop + MCP Servers

## Configuração Rápida em 10 Minutos

---

## 🚀 CONFIGURAÇÃO RÁPIDA (10 MINUTOS)

### Passo 1: Instalar Claude Desktop (2 min)

1. Acesse: <https://claude.ai/download>
2. Baixe e instale Claude Desktop
3. Faça login com sua conta Claude

### Passo 2: Localizar Arquivo de Configuração (1 min)

**macOS:**

```bash
open ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

**Windows:**

```
%APPDATA%\Claude\claude_desktop_config.json
```

**Linux:**

```bash
~/.config/Claude/claude_desktop_config.json
```

### Passo 3: Obter Caminho do Repositório (1 min)

**macOS/Linux:**

```bash
cd /Users/luiz.sena88/gem_viagem_uruguai
pwd
```

**Windows:**

```cmd
cd C:\caminho\para\gem_viagem_uruguai
cd
```

### Passo 4: Criar/Editar Arquivo de Configuração (3 min)

Copie o conteúdo de `11_claude_desktop_config_exemplo.json` e:

1. **Substitua o caminho** pelo caminho do seu repositório
2. **Escolha provider de busca**:
   - DuckDuckGo (gratuito, sem API): `"SEARCH_PROVIDER": "duckduckgo"`
   - Google (requer API): Configure `GOOGLE_API_KEY` e `GOOGLE_CSE_ID`
   - Tavily (alternativa): Configure `TAVILY_API_KEY`

### Passo 5: Configurar Custom Instructions (2 min)

1. Abra Claude Desktop
2. Vá em Settings → Custom Instructions
3. Copie TODO o conteúdo de `10_instrucoes_claude_desktop_completas.md`
4. Cole nas Custom Instructions
5. Salve

### Passo 6: Reiniciar Claude Desktop (1 min)

1. Feche completamente Claude Desktop
2. Abra novamente
3. Verifique se MCP servers aparecem na interface

---

## ✅ CHECKLIST RÁPIDO

- [ ] Claude Desktop instalado e funcionando
- [ ] Arquivo de configuração criado/editado
- [ ] Caminho do repositório configurado corretamente
- [ ] Provider de busca configurado
- [ ] Custom Instructions configuradas
- [ ] Claude Desktop reiniciado
- [ ] MCP servers aparecem na interface

---

## 🧪 TESTE RÁPIDO

**Pergunta para Claude:**

```
"Leia o arquivo 01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md e me diga qual é o período da viagem."
```

**Resposta Esperada:**

- Claude deve conseguir ler o arquivo
- Deve responder: "18 a 25 de novembro de 2025"

---

## 🔧 TROUBLESHOOTING RÁPIDO

### MCP Servers Não Aparecem?

1. Verificar sintaxe JSON (usar validador)
2. Verificar caminho do repositório
3. Reiniciar Claude Desktop
4. Verificar logs do Claude Desktop

### Erro ao Ler Arquivos?

1. Verificar permissões do diretório
2. Verificar se caminho está correto
3. Tentar caminho absoluto completo

### Busca Web Não Funciona?

1. Verificar API keys (se usando Google/Tavily)
2. Tentar DuckDuckGo (sem API)
3. Verificar conexão com internet

---

## 📚 DOCUMENTAÇÃO COMPLETA

Para detalhes completos, consulte:

- **Guia Completo**: `09_guia_integracao_claude_desktop_mcp.md`
- **Instruções Completas**: `10_instrucoes_claude_desktop_completas.md`
- **Config Exemplo**: `11_claude_desktop_config_exemplo.json`

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 1.0.0
**Status**: ✅ QUICK START PRONTO
