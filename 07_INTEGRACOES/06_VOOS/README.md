# ✈️ Integração Voos e Aeroportos
## Status de Voos e Informações de Aeroportos

---

## 🎯 OBJETIVO

Integrar APIs de voos para fornecer status de voos, informações de aeroportos e check-in online.

---

## 📋 FUNCIONALIDADES

### 1. Status de Voos
- Verificar status do voo
- Atrasos e cancelamentos
- Portão de embarque
- Tempo estimado

### 2. Informações de Aeroportos
- Localização
- Serviços disponíveis
- Contatos
- Estacionamento

### 3. Check-in Online
- Links para check-in
- Instruções
- Requisitos de bagagem

---

## 🔑 PROVEDORES DE API

### 1. AviationStack
- **URL**: https://aviationstack.com/
- **Gratuito**: 500 requisições/mês
- **Dados de voos**

### 2. Amadeus API
- **URL**: https://developers.amadeus.com/
- **Completo mas complexo**
- **Dados de voos e aeroportos**

### 3. FlightAware
- **URL**: https://www.flightaware.com/commercial/flightxml/
- **Dados em tempo real**
- **Pago**

---

## 💻 IMPLEMENTAÇÃO

### Estrutura de Dados

```json
{
  "flights": [
    {
      "airline": "LATAM",
      "flight_number": "LA9574174NEOG",
      "reservation_code": "DYYFYZ",
      "departure": {
        "airport": "Aeroporto de Guarulhos (GRU)",
        "date": "2025-11-18",
        "time": "02:55",
        "gate": "A definir",
        "status": "scheduled"
      },
      "arrival": {
        "airport": "Aeroporto Carrasco (MVD)",
        "date": "2025-11-18",
        "time": "10:35",
        "gate": "A definir",
        "status": "scheduled"
      },
      "return": {
        "departure": {
          "airport": "Aeroporto Carrasco (MVD)",
          "date": "2025-11-25",
          "time": "02:10"
        },
        "arrival": {
          "airport": "Aeroporto de Guarulhos (GRU)",
          "date": "2025-11-25",
          "time": "09:00"
        }
      },
      "check_in": {
        "online": true,
        "url": "https://www.latam.com/checkin",
        "opens": "24 horas antes"
      }
    }
  ]
}
```

### API Endpoint

```python
@app.route('/api/flights/status/<flight_number>')
def flight_status(flight_number):
    # Buscar status do voo
    status = get_flight_status(flight_number)
    return jsonify(status)

@app.route('/api/airports/<code>')
def airport_info(code):
    # Informações do aeroporto
    info = get_airport_info(code)
    return jsonify(info)
```

---

## 🔗 INTEGRAÇÃO COM MAPAS

### Mostrar Aeroportos no Mapa

```javascript
function addAirportMarkers(map) {
    const airports = [
        {
            name: 'Aeroporto Carrasco (MVD)',
            position: { lat: -34.8384, lng: -56.0308 },
            icon: '✈️'
        }
    ];

    airports.forEach(airport => {
        new google.maps.Marker({
            position: airport.position,
            map: map,
            title: airport.name,
            icon: airport.icon
        });
    });
}
```

---

## ✅ CHECKLIST

- [ ] Dados de voos coletados
- [ ] Estrutura de dados definida
- [ ] Endpoints criados
- [ ] Integração com mapas
- [ ] Links de check-in adicionados
- [ ] Informações de aeroportos
- [ ] Testes realizados

---

**Última atualização**: 16 de Novembro de 2025

