# 🔍 Validador de Ofertas Comparativas - Aluguel de Carros
## Sistema de Validação e Comparação Automática

---

## 🎯 OBJETIVO

Validar e comparar ofertas de aluguel de carros de diferentes provedores para encontrar a melhor opção baseada em critérios específicos da viagem.

---

## 📋 FUNCIONALIDADES

### 1. Parser de URLs
- ✅ Extrai informações de URLs do Booking.com
- ✅ Extrai informações de URLs do Livelo/Budget
- ✅ Detecta automaticamente o provedor
- ✅ Valida formato da URL

### 2. Validação de Ofertas
- ✅ Valida datas de retirada/devolução
- ✅ Valida localização (aeroporto)
- ✅ Valida idade do motorista
- ✅ Verifica moeda (BRL preferencial)
- ✅ Pontuação automática

### 3. Comparação
- ✅ Compara múltiplas ofertas
- ✅ Ranking por score
- ✅ Identifica melhor oferta
- ✅ Gera relatório comparativo

### 4. API REST
- ✅ Endpoints para adicionar ofertas
- ✅ Endpoints para comparar
- ✅ Endpoints para relatórios
- ✅ Integração com dashboard

---

## 🚀 COMO USAR

### Opção 1: Via Python

```python
from validador_ofertas import ValidadorOfertasCarros

validador = ValidadorOfertasCarros()

# Adicionar ofertas
validador.adicionar_oferta("https://cars.booking.com/...")
validador.adicionar_oferta("https://abglac.com/livelo-budget/...")

# Comparar
comparacao = validador.comparar_ofertas()

# Gerar relatório
relatorio = validador.gerar_relatorio()
print(relatorio)
```

### Opção 2: Via API REST

```bash
# Adicionar oferta
curl -X POST http://localhost:5000/api/car-rental/ofertas \
  -H "Content-Type: application/json" \
  -d '{"url": "https://cars.booking.com/..."}'

# Comparar todas
curl http://localhost:5000/api/car-rental/comparar

# Gerar relatório
curl http://localhost:5000/api/car-rental/relatorio
```

### Opção 3: Via Dashboard

1. Acesse o dashboard
2. Vá em "Aluguel de Carros"
3. Cole as URLs das ofertas
4. Veja comparação automática

---

## 📊 CRITÉRIOS DE VALIDAÇÃO

### Datas (10 pontos)
- ✅ Data de retirada: 18/11/2025
- ✅ Data de devolução: 25/11/2025
- ⚠️ Aviso se diferente

### Localização (5 pontos)
- ✅ Aeroporto Internacional de Carrasco (MVD)
- ⚠️ Aviso se diferente

### Provedor (10 pontos)
- ✅ Booking.com: +10 pontos
- ✅ Livelo/Budget: +8 pontos
- ✅ Outros: +5 pontos

### Moeda (3 pontos)
- ✅ BRL: +3 pontos
- ⚠️ Outras: 0 pontos

### Idade do Motorista
- ❌ < 25 anos: Erro crítico
- ✅ ≥ 25 anos: OK

---

## 📈 EXEMPLO DE USO

### Input (URLs)

```
1. https://cars.booking.com/search-results?puDay=18&puMonth=11...
2. https://abglac.com/livelo-budget/step2/Budget/...
```

### Output (Comparação)

```json
{
  "total": 2,
  "melhor_oferta": {
    "provider": "Booking.com",
    "score": 18,
    "validacao": {
      "valida": true,
      "erros": [],
      "avisos": []
    }
  },
  "todas_ofertas": [...]
}
```

---

## 🔧 INTEGRAÇÃO COM DASHBOARD

### Adicionar ao server.py

```python
from api.integrations.car_rental.api_endpoints import bp as car_rental_bp
app.register_blueprint(car_rental_bp)
```

### Frontend (JavaScript)

```javascript
// Adicionar oferta
async function adicionarOferta(url) {
    const response = await fetch('/api/car-rental/ofertas', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ url: url })
    });
    return await response.json();
}

// Comparar ofertas
async function compararOfertas() {
    const response = await fetch('/api/car-rental/comparar');
    return await response.json();
}
```

---

## ✅ CHECKLIST

- [x] Parser de URLs implementado
- [x] Validador de ofertas implementado
- [x] Comparador implementado
- [x] API REST criada
- [ ] Integração com dashboard
- [ ] Interface visual criada
- [ ] Testes realizados

---

## 🎯 PRÓXIMOS PASSOS

1. **Integrar com Dashboard**
   - Adicionar componente visual
   - Formulário para inserir URLs
   - Tabela comparativa

2. **Melhorar Parser**
   - Scraping de preços (se possível)
   - Extrair mais detalhes
   - Validação de disponibilidade

3. **Adicionar Mais Provedores**
   - Rentalcars.com
   - Localiza
   - Hertz
   - Avis

---

**Última atualização**: 16 de Novembro de 2025  
**Versão**: 1.0.0

