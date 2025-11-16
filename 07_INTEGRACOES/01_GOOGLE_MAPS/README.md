# 🗺️ Integração Google Maps API
## Mapas Interativos para GEM Expert

---

## 🎯 OBJETIVO

Integrar Google Maps API para fornecer mapas interativos, rotas, localizações e direções em tempo real.

---

## 📋 FUNCIONALIDADES

### 1. Mapa Interativo da Viagem
- Visualização completa do roteiro
- Marcadores para hotéis, eventos e pontos de interesse
- Linha de rota entre destinos

### 2. Rotas em Tempo Real
- Cálculo de rotas entre pontos
- Tempo estimado de viagem
- Distâncias
- Opções de transporte (carro, transporte público)

### 3. Localização Atual
- GPS para localização em tempo real
- "Onde estamos agora?"
- Próximos pontos de interesse

### 4. Direções Passo a Passo
- Navegação turn-by-turn
- Instruções detalhadas
- Alternativas de rota

---

## 🔑 CONFIGURAÇÃO

### 1. Obter API Key do Google Maps

1. Acesse: https://console.cloud.google.com/
2. Crie um projeto ou selecione existente
3. Vá em "APIs & Services" → "Library"
4. Ative:
   - **Maps JavaScript API**
   - **Directions API**
   - **Geocoding API**
   - **Places API**
5. Vá em "Credentials" → "Create Credentials" → "API Key"
6. Configure restrições (recomendado)

### 2. Configurar no Projeto

```bash
# Adicionar ao .env
GOOGLE_MAPS_API_KEY=sua_chave_aqui
```

### 3. Instalar Dependências

```bash
pip install googlemaps
```

---

## 💻 IMPLEMENTAÇÃO

### Backend (Python)

```python
import googlemaps
import os
from dotenv import load_dotenv

load_dotenv()

gmaps = googlemaps.Client(key=os.getenv('GOOGLE_MAPS_API_KEY'))

# Obter coordenadas de um endereço
def geocode_address(address):
    geocode_result = gmaps.geocode(address)
    if geocode_result:
        location = geocode_result[0]['geometry']['location']
        return location['lat'], location['lng']
    return None, None

# Calcular rota
def get_route(origin, destination):
    directions_result = gmaps.directions(origin, destination)
    if directions_result:
        route = directions_result[0]
        distance = route['legs'][0]['distance']['text']
        duration = route['legs'][0]['duration']['text']
        steps = route['legs'][0]['steps']
        return {
            'distance': distance,
            'duration': duration,
            'steps': steps
        }
    return None
```

### Frontend (JavaScript)

```javascript
// Carregar Google Maps
function initMap() {
    const map = new google.maps.Map(document.getElementById('map'), {
        zoom: 10,
        center: { lat: -34.9011, lng: -56.1645 }, // Montevidéu
        mapTypeId: 'roadmap'
    });

    // Adicionar marcadores
    const markers = [
        { lat: -34.9011, lng: -56.1645, title: 'Montevidéu' },
        { lat: -34.9475, lng: -54.9336, title: 'Punta del Este' }
    ];

    markers.forEach(marker => {
        new google.maps.Marker({
            position: { lat: marker.lat, lng: marker.lng },
            map: map,
            title: marker.title
        });
    });
}
```

---

## 📊 ENDPOINTS DA API

### GET /api/maps/route
```json
{
  "origin": "Montevidéu",
  "destination": "Punta del Este",
  "mode": "driving"
}
```

**Resposta:**
```json
{
  "distance": "140 km",
  "duration": "2 horas",
  "steps": [...]
}
```

### GET /api/maps/geocode
```json
{
  "address": "Hotel Barradas, Punta del Este"
}
```

**Resposta:**
```json
{
  "lat": -34.9475,
  "lng": -54.9336,
  "formatted_address": "..."
}
```

---

## ✅ CHECKLIST

- [ ] API Key do Google Maps obtida
- [ ] APIs necessárias ativadas
- [ ] Chave configurada no .env
- [ ] Dependências instaladas
- [ ] Backend implementado
- [ ] Frontend implementado
- [ ] Testes realizados

---

**Última atualização**: 16 de Novembro de 2025

