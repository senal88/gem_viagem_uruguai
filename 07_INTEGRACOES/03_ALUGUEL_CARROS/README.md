# 🚗 Integração Aluguel de Carros
## Verificação de Reservas e Informações

---

## 🎯 OBJETIVO

Integrar com locadoras de carros para verificar reservas, localização de retirada/devolução e informações do veículo.

---

## 📋 FUNCIONALIDADES

### 1. Verificar Reserva
- Buscar reserva por número
- Status da reserva
- Detalhes do veículo

### 2. Localização
- Ponto de retirada
- Ponto de devolução
- Mapas integrados

### 3. Informações do Veículo
- Modelo e categoria
- Combustível
- Seguros incluídos
- Contatos de emergência

### 4. Regras e Documentos
- Documentos necessários
- Regras de condução
- Telepeaje (tag de pedágio)

---

## 🔑 LOCADORAS PRINCIPAIS

### 1. Booking.com Car Rentals
- API disponível para afiliados
- Integração via Booking.com

### 2. Rentalcars.com
- API para parceiros
- Integração similar

### 3. Localiza / Hertz / Avis
- APIs próprias (se disponíveis)
- Integração direta

---

## 💻 IMPLEMENTAÇÃO

### Estrutura de Dados

```json
{
  "car_rental": {
    "reservation_number": "BC123456789",
    "provider": "Booking.com",
    "pickup": {
      "location": "Aeroporto Carrasco",
      "date": "2025-11-18",
      "time": "11:00",
      "address": "Aeroporto Carrasco, Montevidéu",
      "coordinates": { "lat": -34.8384, "lng": -56.0308 }
    },
    "dropoff": {
      "location": "Aeroporto Carrasco",
      "date": "2025-11-24",
      "time": "23:30",
      "address": "Aeroporto Carrasco, Montevidéu"
    },
    "vehicle": {
      "category": "Econômico",
      "model": "A ser definido",
      "transmission": "Automático",
      "fuel": "Gasolina",
      "seats": 5
    },
    "insurance": {
      "basic": true,
      "full_coverage": false,
      "telepeaje": "Verificar na retirada"
    },
    "documents": [
      "CNH válida",
      "Cartão de crédito",
      "Passaporte ou RG"
    ],
    "rules": [
      "Faróis obrigatórios 24/7",
      "Tolerância ZERO para álcool",
      "Pedágios via Telepeaje"
    ],
    "contacts": {
      "pickup_location": "+598 2 2604 0000",
      "emergency": "911"
    }
  }
}
```

### API Endpoints

```python
@app.route('/api/car-rental/reservation')
def get_car_reservation():
    # Retornar dados da reserva
    return jsonify(car_rental_data)

@app.route('/api/car-rental/pickup-location')
def get_pickup_location():
    # Retornar localização de retirada
    return jsonify({
        'address': '...',
        'coordinates': {...},
        'map_url': '...'
    })
```

---

## 🗺️ INTEGRAÇÃO COM MAPAS

### Mostrar Localização no Mapa

```javascript
// Adicionar marcador de retirada/devolução
function addCarRentalMarkers(map) {
    const pickupMarker = new google.maps.Marker({
        position: { lat: -34.8384, lng: -56.0308 },
        map: map,
        title: 'Retirada do Carro',
        icon: '🚗'
    });

    const dropoffMarker = new google.maps.Marker({
        position: { lat: -34.8384, lng: -56.0308 },
        map: map,
        title: 'Devolução do Carro',
        icon: '🚗'
    });
}
```

---

## ✅ CHECKLIST

- [ ] Dados da reserva coletados
- [ ] Estrutura de dados definida
- [ ] Endpoints criados
- [ ] Integração com mapas
- [ ] Informações de Telepeaje verificadas
- [ ] Contatos adicionados
- [ ] Interface criada

---

**Última atualização**: 16 de Novembro de 2025

