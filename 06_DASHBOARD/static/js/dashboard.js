/**
 * Dashboard Principal - GEM Expert
 * Carrega dados e atualiza visualizações
 */

(function() {
    'use strict';
    
    const API_BASE = window.location.pathname.includes('/gem') ? '/gem/api' : '/api';
    
    // Inicialização
    function init() {
        loadDashboardData();
        setupAutoRefresh();
    }
    
    // Carregar dados do dashboard
    async function loadDashboardData() {
        await Promise.all([
            loadNextActivity(),
            loadWeather(),
            loadExchange(),
            loadReservations()
        ]);
    }
    
    // Carregar próxima atividade
    async function loadNextActivity() {
        const container = document.getElementById('nextActivity');
        if (!container) return;
        
        try {
            const response = await fetch(`${API_BASE}/reservas`);
            if (!response.ok) throw new Error('Erro ao carregar reservas');
            
            const data = await response.json();
            const reservations = data.reservations || [];
            
            if (reservations.length > 0) {
                // Ordenar por data e pegar a próxima
                const sorted = reservations.sort((a, b) => {
                    const dateA = new Date(a.date + ' ' + a.time);
                    const dateB = new Date(b.date + ' ' + b.time);
                    return dateA - dateB;
                });
                
                const next = sorted[0];
                const nextDate = new Date(next.date + ' ' + next.time);
                const now = new Date();
                
                if (nextDate > now) {
                    container.innerHTML = `
                        <div class="activity-info">
                            <h4>${next.name}</h4>
                            <p><strong>Data:</strong> ${next.date} às ${next.time}</p>
                            <p><strong>Local:</strong> ${next.location}</p>
                            <span class="time-until">${getTimeUntil(nextDate)}</span>
                        </div>
                    `;
                } else {
                    container.innerHTML = '<p>Nenhuma atividade próxima</p>';
                }
            } else {
                container.innerHTML = '<p>Nenhuma reserva encontrada</p>';
            }
        } catch (error) {
            container.innerHTML = `<p class="error">Erro: ${error.message}</p>`;
        }
    }
    
    // Calcular tempo até atividade
    function getTimeUntil(date) {
        const now = new Date();
        const diff = date - now;
        
        if (diff < 0) return 'Já passou';
        
        const days = Math.floor(diff / (1000 * 60 * 60 * 24));
        const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
        
        if (days > 0) {
            return `Em ${days} dia${days > 1 ? 's' : ''} e ${hours}h`;
        } else if (hours > 0) {
            return `Em ${hours}h e ${minutes}min`;
        } else {
            return `Em ${minutes}min`;
        }
    }
    
    // Carregar clima
    async function loadWeather() {
        const container = document.getElementById('weatherCard');
        if (!container) return;
        
        try {
            const response = await fetch(`${API_BASE}/weather/current`);
            if (!response.ok) throw new Error('Erro ao carregar clima');
            
            const data = await response.json();
            container.innerHTML = `
                <div class="weather-info">
                    <div class="weather-temp">${data.temperature || 'N/A'}°C</div>
                    <div class="weather-desc">${data.description || 'N/A'}</div>
                    <div class="weather-location">${data.location || 'Montevidéu'}</div>
                </div>
            `;
        } catch (error) {
            container.innerHTML = `<p class="error">Erro: ${error.message}</p>`;
        }
    }
    
    // Carregar câmbio
    async function loadExchange() {
        const container = document.getElementById('exchangeCard');
        if (!container) return;
        
        try {
            const response = await fetch(`${API_BASE}/exchange/rate`);
            if (!response.ok) throw new Error('Erro ao carregar câmbio');
            
            const data = await response.json();
            container.innerHTML = `
                <div class="exchange-info">
                    <div class="exchange-rate-large">1 BRL = ${data.rate ? data.rate.toFixed(2) : 'N/A'} UYU</div>
                    <div class="exchange-update">Atualizado: ${data.timestamp ? new Date(data.timestamp).toLocaleTimeString('pt-BR') : 'N/A'}</div>
                </div>
            `;
        } catch (error) {
            container.innerHTML = `<p class="error">Erro: ${error.message}</p>`;
        }
    }
    
    // Carregar reservas preview
    async function loadReservations() {
        const container = document.getElementById('reservationsList');
        if (!container) return;
        
        try {
            const response = await fetch(`${API_BASE}/reservas`);
            if (!response.ok) throw new Error('Erro ao carregar reservas');
            
            const data = await response.json();
            const reservations = data.reservations || [];
            
            if (reservations.length > 0) {
                container.innerHTML = reservations.slice(0, 6).map(reserva => `
                    <div class="reserva-card">
                        <div class="reserva-header">
                            <h4>${reserva.name}</h4>
                            <span class="status-badge confirmed">✅</span>
                        </div>
                        <div class="reserva-body">
                            <p><strong>${reserva.date}</strong> às ${reserva.time}</p>
                            <p>${reserva.location}</p>
                        </div>
                    </div>
                `).join('');
            } else {
                container.innerHTML = '<p>Nenhuma reserva encontrada</p>';
            }
        } catch (error) {
            container.innerHTML = `<p class="error">Erro: ${error.message}</p>`;
        }
    }
    
    // Auto-refresh
    function setupAutoRefresh() {
        // Atualizar clima e câmbio a cada 5 minutos
        setInterval(() => {
            loadWeather();
            loadExchange();
        }, 5 * 60 * 1000);
    }
    
    // Inicializar quando DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
