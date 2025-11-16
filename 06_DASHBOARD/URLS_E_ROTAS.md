# 🔗 URLs e Rotas - Dashboard GEM Expert
## Documentação Completa de Todas as Rotas

---

## 📱 URL PRINCIPAL

**Dashboard:** http://senamfo.com.br:8081/gem/

---

## 🗺️ ROTAS PRINCIPAIS

### Páginas HTML

| Rota | Descrição | Acesso |
|------|-----------|--------|
| `/` | Dashboard principal | http://senamfo.com.br:8081/gem/ |
| `/gem` | Dashboard principal (alternativa) | http://senamfo.com.br:8081/gem |
| `/gem/analise-carros` | Análise comparativa de carros | http://senamfo.com.br:8081/gem/analise-carros |

---

## 🔌 ENDPOINTS DA API

### Base Path
- **Desenvolvimento**: `/api/`
- **Produção**: `/gem/api/`

### Chat

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | `/api/chat` | Chat com GEM Expert |
| POST | `/gem/api/chat` | Chat com GEM Expert (produção) |

**Payload:**
```json
{
  "message": "Sua mensagem",
  "provider": "gemini|openai|anthropic",
  "history": []
}
```

---

### Reservas

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/reservas` | Lista todas as reservas |
| GET | `/gem/api/reservas` | Lista todas as reservas (produção) |

**Resposta:**
```json
{
  "reservations": [...],
  "total": 6
}
```

---

### Itinerário

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/itinerario` | Itinerário detalhado |
| GET | `/gem/api/itinerario` | Itinerário detalhado (produção) |

**Resposta:**
```json
{
  "days": [...],
  "total_days": 7
}
```

---

### Clima

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/weather/current` | Clima atual |
| GET | `/gem/api/weather/current` | Clima atual (produção) |
| GET | `/api/weather/forecast` | Previsão do tempo |
| GET | `/gem/api/weather/forecast` | Previsão do tempo (produção) |

---

### Câmbio

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/exchange/rate` | Taxa de câmbio BRL/UYU |
| GET | `/gem/api/exchange/rate` | Taxa de câmbio BRL/UYU (produção) |
| GET | `/api/exchange/convert?amount=100&from=BRL&to=UYU` | Conversor |
| GET | `/gem/api/exchange/convert?amount=100&from=BRL&to=UYU` | Conversor (produção) |

---

### Mapas

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/maps/geocode?address=Montevideo` | Geocodificação |
| GET | `/gem/api/maps/geocode?address=Montevideo` | Geocodificação (produção) |
| GET | `/api/maps/route?origin=X&destination=Y` | Rota entre pontos |
| GET | `/gem/api/maps/route?origin=X&destination=Y` | Rota entre pontos (produção) |

---

### Aluguel de Carros

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | `/api/car-rental/ofertas` | Adicionar oferta via URL |
| GET | `/api/car-rental/comparar` | Comparar ofertas |
| GET | `/api/car-rental/analise-completa` | Análise completa Kwid vs Onix |
| POST | `/api/car-rental/adicionar-oferta-detalhada` | Adicionar oferta detalhada |
| GET | `/api/car-rental/melhor-oferta/<veiculo>` | Melhor oferta por veículo |
| GET | `/api/car-rental/relatorio-markdown` | Relatório em Markdown |

**Produção (com `/gem`):**
- `/gem/api/car-rental/analise-completa`
- `/gem/api/car-rental/adicionar-oferta-detalhada`

---

## 📂 ARQUIVOS ESTÁTICOS

### CSS
- `/gem/static/css/dashboard.css` - Estilos principais

### JavaScript
- `/gem/static/js/dashboard.js` - Lógica do dashboard
- `/gem/static/js/chat.js` - Lógica do chat
- `/gem/static/js/sidebar.js` - Navegação sidebar

---

## 🎯 SEÇÕES DO DASHBOARD

### 1. Dashboard (#dashboard)
- Próxima atividade
- Clima atual
- Câmbio BRL/UYU
- Aluguel de carro (resumo)
- Preview de reservas

### 2. Chat (#chat)
- Conversação com GEM Expert
- Seleção de provider (Gemini, OpenAI, Anthropic)
- Histórico de mensagens

### 3. Reservas (#reservas)
- Lista completa de reservas
- Detalhes de cada reserva
- Status e confirmações

### 4. Itinerário (#itinerario)
- Cronograma dia a dia
- Atividades por dia
- Horários e locais

### 5. Análise Carros (#carros)
- Comparação Kwid vs Onix
- Interface completa de análise
- Formulário para adicionar ofertas

### 6. Clima (#clima)
- Previsão do tempo
- Montevidéu e Punta del Este
- Dados em tempo real

### 7. Câmbio (#cambio)
- Taxa BRL/UYU
- Conversor de moedas
- Atualização automática

### 8. Mapas (#mapas)
- Principais rotas
- Distâncias e tempos
- Informações de navegação

---

## 🔄 NAVEGAÇÃO

### Via Sidebar
- Clique nos itens do menu lateral
- Navegação suave entre seções
- Auto-carregamento de dados

### Via URL Hash
- `#dashboard` - Dashboard principal
- `#chat` - Chat
- `#reservas` - Reservas
- `#itinerario` - Itinerário
- `#carros` - Análise de carros
- `#clima` - Clima
- `#cambio` - Câmbio
- `#mapas` - Mapas

---

## 📱 RESPONSIVIDADE

### Desktop (> 768px)
- Sidebar sempre visível
- Layout em grid
- Navegação completa

### Mobile (≤ 768px)
- Sidebar oculta por padrão
- Toggle button no topo
- Layout em coluna única
- Sidebar sobrepõe conteúdo quando aberta

---

## 🔐 AUTENTICAÇÃO

Atualmente não há autenticação. Todas as rotas são públicas.

---

## ⚡ AUTO-REFRESH

- **Clima**: Atualizado a cada 5 minutos
- **Câmbio**: Atualizado a cada 5 minutos
- **Reservas**: Carregadas ao acessar seção
- **Itinerário**: Carregado ao acessar seção

---

## 🐛 DEBUGGING

### Verificar se API está respondendo:
```bash
curl http://senamfo.com.br:8081/gem/api/reservas
```

### Verificar logs do serviço:
```bash
ssh root@147.79.81.59
journalctl -u gemexpert -f
```

---

**Última atualização**: 16 de Novembro de 2025
**Versão**: 2.0.0 (com Sidebar)

