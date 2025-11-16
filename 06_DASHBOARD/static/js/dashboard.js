// Dashboard JavaScript - GEM Expert
// Lógica principal do dashboard

// Dados da viagem
const tripData = {
    travelers: ['Aline Torres', 'Luiz Fernando Sena'],
    period: {
        start: '2025-11-18',
        end: '2025-11-25'
    },
    reservations: [
        {
            date: '2025-11-19',
            time: '09:30',
            name: 'Pizzorno Tour',
            location: 'Montevidéu',
            type: 'tour'
        },
        {
            date: '2025-11-20',
            time: '18:30',
            name: 'Pré-Wedding L\'Incanto',
            location: 'Punta del Este',
            type: 'event'
        },
        {
            date: '2025-11-22',
            time: '16:30',
            name: 'Casamento Fasano',
            location: 'Punta del Este',
            type: 'event'
        },
        {
            date: '2025-11-23',
            time: '20:30',
            name: 'Primuseum',
            location: 'Montevidéu',
            type: 'event'
        },
        {
            date: '2025-11-24',
            time: '10:30',
            name: 'Bouza Tour',
            location: 'Montevidéu',
            type: 'tour'
        }
    ],
    contacts: {
        primuseum: { name: 'Primuseum', phone: '+598 99 2176 45' },
        casapueblo: { name: 'Casapueblo', phone: '+598 4257 8611' },
        lodetere: { name: 'Lo de Tere', phone: '+598 4244 0492' },
        airport: { name: 'Aeroporto Carrasco', phone: '+598 2 2604 0000' }
    }
};

// Inicialização
document.addEventListener('DOMContentLoaded', () => {
    initDashboard();
    initClock();
    loadNextEvent();
    loadTimeline();
    initQuickActions();
});

// Inicializar dashboard
function initDashboard() {
    console.log('Dashboard inicializado');
}

// Relógio em tempo real
function initClock() {
    const updateClock = () => {
        const now = new Date();
        const dateStr = now.toLocaleDateString('pt-BR', { 
            weekday: 'long', 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
        });
        const timeStr = now.toLocaleTimeString('pt-BR', { 
            hour: '2-digit', 
            minute: '2-digit' 
        });
        
        document.getElementById('current-date').textContent = 
            dateStr.charAt(0).toUpperCase() + dateStr.slice(1);
        document.getElementById('current-time').textContent = timeStr;
    };
    
    updateClock();
    setInterval(updateClock, 1000);
}

// Carregar próximo evento
function loadNextEvent() {
    const now = new Date();
    const today = now.toISOString().split('T')[0];
    
    // Encontrar próximo evento
    const upcomingEvents = tripData.reservations
        .filter(event => event.date >= today)
        .sort((a, b) => {
            if (a.date !== b.date) return a.date.localeCompare(b.date);
            return a.time.localeCompare(b.time);
        });
    
    const nextEvent = upcomingEvents[0];
    const container = document.getElementById('next-event');
    
    if (nextEvent) {
        const eventDate = new Date(nextEvent.date + 'T' + nextEvent.time);
        const timeUntil = getTimeUntil(eventDate);
        
        container.innerHTML = `
            <div class="event-item">
                <div>
                    <div class="event-name">${nextEvent.name}</div>
                    <div class="event-details">
                        📍 ${nextEvent.location}<br>
                        📅 ${formatDate(nextEvent.date)}<br>
                        ⏰ ${timeUntil}
                    </div>
                </div>
                <div class="event-time">${nextEvent.time}</div>
            </div>
        `;
    } else {
        container.innerHTML = '<p>Nenhum evento próximo</p>';
    }
}

// Carregar timeline
function loadTimeline() {
    const container = document.getElementById('timeline');
    const today = new Date().toISOString().split('T')[0];
    
    const upcoming = tripData.reservations
        .filter(event => event.date >= today)
        .slice(0, 5);
    
    if (upcoming.length === 0) {
        container.innerHTML = '<p>Nenhum evento agendado</p>';
        return;
    }
    
    container.innerHTML = upcoming.map(event => `
        <div class="timeline-item">
            <div class="timeline-date">${formatDate(event.date)} às ${event.time}</div>
            <div class="timeline-content">
                <strong>${event.name}</strong><br>
                📍 ${event.location}
            </div>
        </div>
    `).join('');
}

// Carregar clima (simulado - integrar com API real)
function loadWeather() {
    const container = document.getElementById('weather-info');
    
    // Simular dados - substituir por chamada real à API
    container.innerHTML = `
        <div class="weather-info">
            <div class="weather-main">
                <div class="weather-temp">22°C</div>
                <div class="weather-desc">Parcialmente nublado</div>
            </div>
            <div class="weather-details">
                Vento: 15 km/h<br>
                Umidade: 65%<br>
                UV: Moderado
            </div>
        </div>
    `;
    
    // TODO: Integrar com API de clima real
    fetch('/api/weather')
        .then(res => res.json())
        .then(data => {
            container.innerHTML = `
                <div class="weather-info">
                    <div class="weather-main">
                        <div class="weather-temp">${data.temp}°C</div>
                        <div class="weather-desc">${data.description}</div>
                    </div>
                    <div class="weather-details">
                        Vento: ${data.wind} km/h<br>
                        Umidade: ${data.humidity}%<br>
                        UV: ${data.uv}
                    </div>
                </div>
            `;
        })
        .catch(err => console.error('Erro ao carregar clima:', err));
}

// Carregar câmbio (simulado - integrar com API real)
function loadExchange() {
    const container = document.getElementById('exchange-info');
    
    // Simular dados - substituir por chamada real à API
    container.innerHTML = `
        <div class="exchange-rate">
            <div>
                <div class="rate-value">7.45 UYU</div>
                <div class="rate-label">1 BRL = 7.45 UYU</div>
            </div>
        </div>
    `;
    
    // TODO: Integrar com API de câmbio real
    fetch('/api/exchange')
        .then(res => res.json())
        .then(data => {
            container.innerHTML = `
                <div class="exchange-rate">
                    <div>
                        <div class="rate-value">${data.rate} UYU</div>
                        <div class="rate-label">1 BRL = ${data.rate} UYU</div>
                    </div>
                </div>
            `;
        })
        .catch(err => console.error('Erro ao carregar câmbio:', err));
}

// Inicializar ações rápidas
function initQuickActions() {
    document.querySelectorAll('.action-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const action = btn.dataset.action;
            handleQuickAction(action);
        });
    });
}

// Processar ação rápida
function handleQuickAction(action) {
    const modal = document.getElementById('modal-overlay');
    const modalBody = document.getElementById('modal-body');
    
    switch(action) {
        case 'contacts':
            modalBody.innerHTML = `
                <h2>📞 Contatos Essenciais</h2>
                ${Object.values(tripData.contacts).map(contact => `
                    <div style="padding: 1rem; border-bottom: 1px solid #e2e8f0;">
                        <strong>${contact.name}</strong><br>
                        <a href="tel:${contact.phone.replace(/\s/g, '')}" style="color: #2563eb; text-decoration: none;">
                            ${contact.phone}
                        </a>
                    </div>
                `).join('')}
            `;
            break;
        case 'reservations':
            modalBody.innerHTML = `
                <h2>📋 Reservas Confirmadas</h2>
                ${tripData.reservations.map(res => `
                    <div style="padding: 1rem; border-bottom: 1px solid #e2e8f0;">
                        <strong>${res.name}</strong><br>
                        📅 ${formatDate(res.date)} às ${res.time}<br>
                        📍 ${res.location}
                    </div>
                `).join('')}
            `;
            break;
        case 'transport':
            modalBody.innerHTML = `
                <h2>🚗 Regras de Condução</h2>
                <div style="padding: 1rem;">
                    <p><strong>⚠️ CRÍTICO:</strong></p>
                    <ul style="margin-left: 1.5rem; margin-top: 0.5rem;">
                        <li>Faróis obrigatórios ligados 24/7</li>
                        <li>Tolerância ZERO para álcool</li>
                        <li>Pedágios via tag Telepeaje</li>
                        <li>Cinto de segurança obrigatório</li>
                    </ul>
                </div>
            `;
            break;
        case 'map':
            modalBody.innerHTML = `
                <h2>🗺️ Mapa da Viagem</h2>
                <div style="padding: 1rem;">
                    <p>Montevidéu → Punta del Este → Montevidéu</p>
                    <p style="margin-top: 1rem; color: #64748b;">
                        Integração com Google Maps em desenvolvimento
                    </p>
                </div>
            `;
            break;
    }
    
    modal.classList.add('active');
}

// Fechar modal
document.querySelector('.modal-close')?.addEventListener('click', () => {
    document.getElementById('modal-overlay').classList.remove('active');
});

// Funções auxiliares
function formatDate(dateStr) {
    const date = new Date(dateStr + 'T00:00:00');
    return date.toLocaleDateString('pt-BR', {
        day: 'numeric',
        month: 'long',
        year: 'numeric'
    });
}

function getTimeUntil(targetDate) {
    const now = new Date();
    const diff = targetDate - now;
    
    if (diff < 0) return 'Já passou';
    
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    
    if (days > 0) return `Em ${days} dia(s) e ${hours}h`;
    if (hours > 0) return `Em ${hours}h e ${minutes}min`;
    return `Em ${minutes}min`;
}

// Carregar dados iniciais
setTimeout(() => {
    loadWeather();
    loadExchange();
}, 500);

