# 📅 Integração Booking.com
## Verificação de Reservas e Disponibilidade

---

## 🎯 OBJETIVO

Integrar com Booking.com para verificar reservas existentes, disponibilidade e informações atualizadas de hotéis.

---

## 📋 FUNCIONALIDADES

### 1. Verificar Reservas
- Buscar reserva por número de confirmação
- Status da reserva
- Detalhes completos

### 2. Disponibilidade
- Verificar disponibilidade de hotéis
- Preços atualizados
- Comparar opções

### 3. Informações do Hotel
- Fotos atualizadas
- Avaliações recentes
- Serviços disponíveis
- Localização e contato

---

## 🔑 CONFIGURAÇÃO

### Opção 1: Booking.com Affiliate API

1. Acesse: https://www.booking.com/affiliate-program/
2. Cadastre-se como afiliado
3. Obtenha credenciais de API
4. Configure no projeto

### Opção 2: Web Scraping (Limitado)

⚠️ **Nota**: Web scraping pode violar termos de serviço. Use com cuidado.

### Opção 3: Integração Manual

Manter dados atualizados manualmente via dashboard.

---

## 💻 IMPLEMENTAÇÃO

### Estrutura de Dados

```json
{
  "reservations": [
    {
      "booking_number": "6417055860",
      "hotel_name": "Barradas Parque Hotel & Spa",
      "check_in": "2025-11-20",
      "check_out": "2025-11-23",
      "status": "confirmed",
      "pin": "2921",
      "location": {
        "address": "Punta del Este",
        "coordinates": { "lat": -34.9475, "lng": -54.9336 }
      }
    }
  ]
}
```

### API Endpoint

```python
@app.route('/api/booking/reservation/<booking_number>')
def get_reservation(booking_number):
    # Buscar reserva
    reservation = find_reservation(booking_number)
    if reservation:
        return jsonify(reservation)
    return jsonify({'error': 'Reservation not found'}), 404
```

---

## 🔗 ALTERNATIVAS

### 1. Integração com Email
- Ler emails de confirmação do Booking.com
- Extrair informações automaticamente
- Atualizar dashboard

### 2. Webhook (Se Disponível)
- Configurar webhook do Booking.com
- Receber atualizações automáticas

### 3. Manual com Interface
- Formulário para inserir dados
- Validação e armazenamento
- Atualização manual quando necessário

---

## ✅ CHECKLIST

- [ ] Método de integração escolhido
- [ ] Credenciais obtidas (se API)
- [ ] Estrutura de dados definida
- [ ] Endpoints criados
- [ ] Interface de atualização criada
- [ ] Testes realizados

---

**Última atualização**: 16 de Novembro de 2025

