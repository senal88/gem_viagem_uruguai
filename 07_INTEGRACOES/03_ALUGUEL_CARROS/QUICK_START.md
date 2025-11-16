# ⚡ Quick Start - Validador de Ofertas
## Como Usar em 2 Minutos

---

## 🚀 USO RÁPIDO

### 1. Adicionar Ofertas

```python
from validador_ofertas import ValidadorOfertasCarros

validador = ValidadorOfertasCarros()

# Adicionar ofertas das URLs compartilhadas
validador.adicionar_oferta("https://cars.booking.com/search-results?...")
validador.adicionar_oferta("https://abglac.com/livelo-budget/...")
```

### 2. Comparar

```python
comparacao = validador.comparar_ofertas()
melhor = comparacao[0]  # Melhor oferta (maior score)
```

### 3. Ver Relatório

```python
relatorio = validador.gerar_relatorio()
print(relatorio)
```

---

## 📊 RESULTADO DO TESTE

Com as URLs fornecidas:

**Melhor Oferta**: Booking.com
- ✅ Score: 18/18
- ✅ Datas corretas
- ✅ Localização correta
- ✅ Moeda BRL

**Segunda Oferta**: Livelo/Budget
- ⚠️ Score: 5/18
- ⚠️ Requer validação manual

---

## 🌐 VIA API

### Adicionar Oferta

```bash
curl -X POST http://senamfo.com.br:8081/gem/api/car-rental/ofertas \
  -H "Content-Type: application/json" \
  -d '{"url": "https://cars.booking.com/..."}'
```

### Comparar

```bash
curl http://senamfo.com.br:8081/gem/api/car-rental/comparar
```

---

## 📱 NO DASHBOARD

1. Acesse: http://senamfo.com.br:8081/gem/
2. Vá em "Aluguel de Carros"
3. Cole as URLs das ofertas
4. Veja comparação automática

---

**Última atualização**: 16 de Novembro de 2025

