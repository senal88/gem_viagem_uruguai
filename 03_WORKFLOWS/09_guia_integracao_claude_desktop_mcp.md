# 🖥️ Guia de Integração: Claude Desktop + MCP Servers
## Configuração Completa do GEM Expert para Claude Desktop

---

## 📋 METADADOS DO DOCUMENTO

| Campo | Valor |
|-------|-------|
| **Tipo** | WORKFLOW |
| **Prioridade** | CRÍTICO |
| **Última Atualização** | 2025-11-16 |
| **Versão** | 1.0.0 |
| **Dependências** | Claude Desktop instalado, MCP Servers configurados |

---

## 🎯 OBJETIVO

Este guia fornece instruções completas para integrar o GEM Expert no Claude Desktop usando MCP (Model Context Protocol) Servers, permitindo acesso dinâmico à base de conhecimento e busca web em tempo real.

---

## 📚 PRÉ-REQUISITOS

### Software Necessário

- ✅ Claude Desktop instalado
- ✅ Node.js instalado (para MCP servers)
- ✅ Acesso à internet (para busca web)
- ✅ Git instalado (para clonar repositório se necessário)

### MCP Servers Recomendados

1. **@modelcontextprotocol/server-filesystem** - Acesso ao sistema de arquivos
2. **@modelcontextprotocol/server-web-search** - Busca web em tempo real
3. **@modelcontextprotocol/server-git** - Integração com Git (opcional)

---

## 🚀 PROCESSO DE CONFIGURAÇÃO

### FASE 1: Instalação do Claude Desktop

#### 1.1. Download e Instalação

1. Acesse: https://claude.ai/download
2. Baixe Claude Desktop para seu sistema operacional
3. Instale seguindo as instruções do instalador

#### 1.2. Verificação

- [ ] Claude Desktop instalado e funcionando
- [ ] Conta Claude criada e logada
- [ ] Interface funcionando corretamente

---

### FASE 2: Configuração do Arquivo de Configuração

#### 2.1. Localização do Arquivo de Configuração

**macOS:**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Windows:**
```
%APPDATA%\Claude\claude_desktop_config.json
```

**Linux:**
```
~/.config/Claude/claude_desktop_config.json
```

#### 2.2. Estrutura do Arquivo de Configuração

Crie ou edite o arquivo `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/luiz.sena88/gem_viagem_uruguai"
      ]
    },
    "web-search": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-web-search"
      ],
      "env": {
        "WEB_SEARCH_API_KEY": "sua_api_key_aqui"
      }
    },
    "git": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-git",
        "/Users/luiz.sena88/gem_viagem_uruguai"
      ]
    }
  }
}
```

#### 2.3. Personalização do Caminho

**IMPORTANTE**: Substitua `/Users/luiz.sena88/gem_viagem_uruguai` pelo caminho absoluto do seu repositório.

**Como encontrar o caminho:**

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

---

### FASE 3: Instalação dos MCP Servers

#### 3.1. Instalação via NPX (Recomendado)

Os servidores serão instalados automaticamente na primeira execução usando `npx -y`.

**Vantagens:**
- ✅ Sem instalação manual
- ✅ Sempre versão mais recente
- ✅ Gerenciamento automático

#### 3.2. Instalação Manual (Opcional)

Se preferir instalação manual:

```bash
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-web-search
npm install -g @modelcontextprotocol/server-git
```

---

### FASE 4: Configuração de Busca Web

#### 4.1. Opções de Busca Web

**Opção 1: Google Search API (Recomendado)**

1. Obter API Key do Google Custom Search
2. Configurar no arquivo de configuração:

```json
"web-search": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-web-search"
  ],
  "env": {
    "GOOGLE_API_KEY": "sua_google_api_key",
    "GOOGLE_CSE_ID": "seu_custom_search_engine_id"
  }
}
```

**Opção 2: DuckDuckGo (Gratuito, sem API)**

```json
"web-search": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-web-search"
  ],
  "env": {
    "SEARCH_PROVIDER": "duckduckgo"
  }
}
```

**Opção 3: Tavily (Alternativa)**

```json
"web-search": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-web-search"
  ],
  "env": {
    "TAVILY_API_KEY": "sua_tavily_api_key"
  }
}
```

---

### FASE 5: Configuração do Prompt do Sistema

#### 5.1. Criar Prompt do Sistema

Crie um arquivo com o prompt do sistema: `03_WORKFLOWS/10_prompt_sistema_claude.md`

**Conteúdo**: Copiar de `06_instrucoes_gemini_2.5_pro_completas.md` e adaptar para Claude.

#### 5.2. Configurar no Claude Desktop

1. Abra Claude Desktop
2. Vá em Settings → Custom Instructions
3. Cole o conteúdo do prompt do sistema
4. Salve

---

### FASE 6: Configuração de Acesso aos Arquivos

#### 6.1. Estrutura de Acesso

O MCP server filesystem terá acesso a:

```
/Users/luiz.sena88/gem_viagem_uruguai/
├── 01_BASE_CONHECIMENTO/     ✅ Acesso completo
├── 02_CONTEXTO_DINAMICO/     ✅ Acesso completo
├── 03_WORKFLOWS/             ✅ Acesso completo
└── ...
```

#### 6.2. Permissões

**macOS:**
- Verificar permissões de acesso ao diretório
- Claude Desktop precisa de permissão para acessar arquivos

**Windows:**
- Verificar permissões de leitura/escrita
- Antivírus pode bloquear acesso

**Linux:**
- Verificar permissões do usuário
- Verificar SELinux se aplicável

---

## ✅ CHECKLIST DE CONFIGURAÇÃO

### Pré-Configuração

- [ ] Claude Desktop instalado
- [ ] Node.js instalado e funcionando
- [ ] Repositório clonado/localizado
- [ ] Caminho absoluto do repositório identificado

### Configuração

- [ ] Arquivo `claude_desktop_config.json` criado/editado
- [ ] Caminho do repositório configurado corretamente
- [ ] MCP servers configurados (filesystem, web-search, git)
- [ ] API keys configuradas (se necessário)
- [ ] Permissões de acesso verificadas

### Validação

- [ ] Claude Desktop reiniciado após configuração
- [ ] MCP servers aparecem na interface
- [ ] Teste de acesso a arquivos funcionando
- [ ] Teste de busca web funcionando
- [ ] Prompt do sistema configurado

---

## 🧪 TESTES DE VALIDAÇÃO

### Teste 1: Acesso a Arquivos

**Prompt para Claude:**
```
"Leia o arquivo 01_BASE_CONHECIMENTO/01_dossie_viagem_completo.md e me diga qual é o período da viagem."
```

**Resultado Esperado:**
- Claude deve conseguir ler o arquivo
- Deve responder com o período correto (18-25 Nov 2025)

### Teste 2: Busca Web

**Prompt para Claude:**
```
"Busque na web a previsão do tempo para Punta del Este hoje."
```

**Resultado Esperado:**
- Claude deve usar o MCP server de busca web
- Deve retornar informações sobre o clima

### Teste 3: Contexto Completo

**Prompt para Claude:**
```
"Baseado no itinerário da viagem, qual a previsão do tempo para o casamento no Fasano no dia 22/11?"
```

**Resultado Esperado:**
- Claude deve ler o itinerário
- Deve buscar previsão do tempo
- Deve contextualizar com o evento

---

## 📝 EXEMPLO DE USO

### Exemplo 1: Consulta sobre Itinerário

**Usuário**: "Que horas é o casamento no Fasano?"

**Claude (com MCP)**:
1. Lê `01_BASE_CONHECIMENTO/02_itinerario_detalhado.md`
2. Identifica evento: Casamento Fasano
3. Responde: "O casamento é no dia 22/11 (Sábado) às 16:30 no Hotel Fasano Las Piedras."

### Exemplo 2: Busca Dinâmica

**Usuário**: "Qual a previsão do tempo para hoje?"

**Claude (com MCP)**:
1. Identifica data atual
2. Consulta itinerário para ver eventos do dia
3. Usa busca web para obter previsão
4. Contextualiza resposta com eventos do dia

---

## 🔧 TROUBLESHOOTING

### Problema 1: MCP Servers Não Aparecem

**Solução:**
1. Verificar se arquivo de configuração está no local correto
2. Verificar sintaxe JSON (usar validador JSON)
3. Reiniciar Claude Desktop
4. Verificar logs do Claude Desktop

### Problema 2: Erro de Permissão de Arquivo

**Solução:**
1. Verificar permissões do diretório
2. Verificar se caminho está correto
3. Tentar caminho absoluto completo
4. Verificar antivírus/firewall

### Problema 3: Busca Web Não Funciona

**Solução:**
1. Verificar API keys configuradas
2. Verificar variáveis de ambiente
3. Testar com provider alternativo (DuckDuckGo)
4. Verificar conexão com internet

### Problema 4: Claude Não Lê Arquivos

**Solução:**
1. Verificar se MCP server filesystem está ativo
2. Verificar caminho do repositório
3. Tentar com caminho relativo vs absoluto
4. Verificar logs do MCP server

---

## 📊 ESTRUTURA DE CONFIGURAÇÃO FINAL

```
Claude Desktop Config:
├── mcpServers/
│   ├── filesystem/          ✅ Acesso ao repositório
│   ├── web-search/          ✅ Busca web em tempo real
│   └── git/                 ✅ Integração Git (opcional)
└── Custom Instructions/     ✅ Prompt do sistema
```

---

## 🔗 REFERÊNCIAS

### Documentação Oficial

- **Claude Desktop**: https://claude.ai/download
- **MCP Protocol**: https://modelcontextprotocol.io
- **MCP Servers**: https://github.com/modelcontextprotocol/servers

### Documentos Relacionados

- **Instruções Claude**: `10_instrucoes_claude_desktop_completas.md`
- **Prompt Sistema**: `10_prompt_sistema_claude.md`
- **Config Exemplo**: `11_claude_desktop_config_exemplo.json`

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0  
**Status**: ✅ GUIA COMPLETO PARA CLAUDE DESKTOP + MCP

