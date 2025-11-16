/**
 * Sidebar Navigation - GEM Expert Dashboard
 * Controla navegação entre seções e responsividade
 */

(function() {
    'use strict';

    const API_BASE = window.location.pathname.includes('/gem') ? '/gem/api' : '/api';

    // Elementos
    const sidebar = document.getElementById('sidebar');
    const sidebarToggle = document.getElementById('sidebarToggle');
    const navItems = document.querySelectorAll('.nav-item');
    const sections = document.querySelectorAll('.content-section');

    // Inicialização
    function init() {
        setupEventListeners();
        loadInitialData();
        checkScreenSize();
    }

    // Event listeners
    function setupEventListeners() {
        // Toggle sidebar (mobile)
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', toggleSidebar);
        }

        // Navegação
        navItems.forEach(item => {
            item.addEventListener('click', (e) => {
                e.preventDefault();
                const section = item.getAttribute('data-section');
                navigateToSection(section);
            });
        });

        // Fechar sidebar ao clicar fora (mobile)
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 768) {
                if (!sidebar.contains(e.target) && !sidebarToggle.contains(e.target)) {
                    if (sidebar.classList.contains('active')) {
                        sidebar.classList.remove('active');
                    }
                }
            }
        });

        // Responsividade
        window.addEventListener('resize', checkScreenSize);
    }

    // Navegação entre seções
    function navigateToSection(sectionName) {
        // Atualizar nav items
        navItems.forEach(item => {
            item.classList.remove('active');
            if (item.getAttribute('data-section') === sectionName) {
                item.classList.add('active');
            }
        });

        // Mostrar seção correspondente
        sections.forEach(section => {
            section.classList.remove('active');
            const sectionId = section.id.replace('-section', '');
            if (sectionId === sectionName) {
                section.classList.add('active');
                // Scroll para topo
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        });

        // Carregar dados da seção se necessário
        loadSectionData(sectionName);

        // Fechar sidebar no mobile após navegação
        if (window.innerWidth <= 768) {
            sidebar.classList.remove('active');
        }
    }

    // Carregar dados da seção
    function loadSectionData(sectionName) {
        switch(sectionName) {
            case 'reservas':
                loadReservasDetail();
                break;
            case 'itinerario':
                loadItinerarioDetail();
                break;
            case 'clima':
                loadWeatherDetail();
                break;
            case 'cambio':
                loadExchangeDetail();
                break;
            case 'mapas':
                loadMapsDetail();
                break;
        }
    }

    // Carregar dados iniciais
    function loadInitialData() {
        // Dashboard já carrega dados via dashboard.js
        // Apenas garantir que está ativo
        navigateToSection('dashboard');
    }

    // Toggle sidebar
    function toggleSidebar() {
        sidebar.classList.toggle('active');
    }

    // Verificar tamanho da tela
    function checkScreenSize() {
        if (window.innerWidth > 768) {
            sidebar.classList.add('active');
        } else {
            sidebar.classList.remove('active');
        }
    }

    // Carregar detalhes de reservas
    async function loadReservasDetail() {
        const container = document.getElementById('reservasDetail');
        if (!container) return;

        try {
            const response = await fetch(`${API_BASE}/reservas`);
            if (!response.ok) throw new Error('Erro ao carregar reservas');

            const data = await response.json();
            container.innerHTML = formatReservas(data);
        } catch (error) {
            container.innerHTML = `<p class="error">Erro ao carregar reservas: ${error.message}</p>`;
        }
    }

    // Carregar detalhes de itinerário
    async function loadItinerarioDetail() {
        const container = document.getElementById('itinerarioDetail');
        if (!container) return;

        try {
            const response = await fetch(`${API_BASE}/itinerario`);
            if (!response.ok) throw new Error('Erro ao carregar itinerário');

            const data = await response.json();
            container.innerHTML = formatItinerario(data);
        } catch (error) {
            container.innerHTML = `<p class="error">Erro ao carregar itinerário: ${error.message}</p>`;
        }
    }

    // Carregar detalhes de clima
    async function loadWeatherDetail() {
        const container = document.getElementById('weatherDetail');
        if (!container) return;

        try {
            const response = await fetch(`${API_BASE}/weather/forecast`);
            if (!response.ok) throw new Error('Erro ao carregar clima');

            const data = await response.json();
            container.innerHTML = formatWeatherDetail(data);
        } catch (error) {
            container.innerHTML = `<p class="error">Erro ao carregar clima: ${error.message}</p>`;
        }
    }

    // Carregar detalhes de câmbio
    async function loadExchangeDetail() {
        const container = document.getElementById('exchangeDetail');
        if (!container) return;

        try {
            const response = await fetch(`${API_BASE}/exchange/rate`);
            if (!response.ok) throw new Error('Erro ao carregar câmbio');

            const data = await response.json();
            container.innerHTML = formatExchangeDetail(data);
        } catch (error) {
            container.innerHTML = `<p class="error">Erro ao carregar câmbio: ${error.message}</p>`;
        }
    }

    // Carregar detalhes de mapas
    async function loadMapsDetail() {
        const container = document.getElementById('mapsDetail');
        if (!container) return;

        container.innerHTML = `
            <div class="maps-info">
                <h3>🗺️ Principais Rotas</h3>
                <div class="route-list">
                    <div class="route-item">
                        <strong>Aeroporto → Centro Montevidéu</strong>
                        <p>~20 km | 45 minutos</p>
                    </div>
                    <div class="route-item">
                        <strong>Montevidéu ↔ Punta del Este</strong>
                        <p>~140 km | 1h45-2h</p>
                    </div>
                    <div class="route-item">
                        <strong>Montevidéu → Colônia</strong>
                        <p>~180 km | 2 horas</p>
                    </div>
                </div>
                <p class="note">⚠️ Lembre-se: Faróis obrigatórios 24/7 e pedágios Telepeaje</p>
            </div>
        `;
    }

    // Formatar reservas
    function formatReservas(data) {
        if (!data || !data.reservations) {
            return '<p>Nenhuma reserva encontrada</p>';
        }

        return data.reservations.map(reserva => `
            <div class="reserva-card">
                <div class="reserva-header">
                    <h3>${reserva.name}</h3>
                    <span class="status-badge confirmed">✅ Confirmada</span>
                </div>
                <div class="reserva-body">
                    <div class="info-row">
                        <strong>Data:</strong> ${reserva.date} às ${reserva.time}
                    </div>
                    <div class="info-row">
                        <strong>Local:</strong> ${reserva.location}
                    </div>
                    ${reserva.type ? `<div class="info-row"><strong>Tipo:</strong> ${reserva.type}</div>` : ''}
                </div>
            </div>
        `).join('');
    }

    // Formatar itinerário
    function formatItinerario(data) {
        if (!data || !data.days) {
            return '<p>Itinerário não disponível</p>';
        }

        return data.days.map(day => `
            <div class="day-card">
                <div class="day-header">
                    <h3>${day.date} - ${day.title}</h3>
                </div>
                <div class="day-activities">
                    ${day.activities.map(activity => `
                        <div class="activity-item">
                            <span class="activity-time">${activity.time}</span>
                            <span class="activity-name">${activity.name}</span>
                            <span class="activity-location">${activity.location}</span>
                        </div>
                    `).join('')}
                </div>
            </div>
        `).join('');
    }

    // Formatar clima detalhado
    function formatWeatherDetail(data) {
        if (!data || !data.forecast) {
            return '<p>Previsão não disponível</p>';
        }

        return `
            <div class="weather-forecast">
                <h3>${data.location}</h3>
                <div class="forecast-grid">
                    ${data.forecast.map(day => `
                        <div class="forecast-day">
                            <div class="forecast-date">${day.date}</div>
                            <div class="forecast-temp">${day.temp}°C</div>
                            <div class="forecast-desc">${day.description}</div>
                        </div>
                    `).join('')}
                </div>
            </div>
        `;
    }

    // Formatar câmbio detalhado
    function formatExchangeDetail(data) {
        if (!data || !data.rate) {
            return '<p>Câmbio não disponível</p>';
        }

        return `
            <div class="exchange-detail-card">
                <div class="exchange-rate">
                    <div class="rate-value">1 BRL = ${data.rate.toFixed(2)} UYU</div>
                    <div class="rate-update">Atualizado: ${new Date(data.timestamp).toLocaleString('pt-BR')}</div>
                </div>
                <div class="exchange-converter">
                    <h4>Conversor</h4>
                    <input type="number" id="brlAmount" placeholder="Valor em BRL" class="converter-input">
                    <div class="converter-result" id="uyuResult">0.00 UYU</div>
                </div>
            </div>
        `;
    }

    // Inicializar quando DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

    // Exportar para uso global
    window.SidebarNav = {
        navigateTo: navigateToSection,
        toggle: toggleSidebar
    };
})();

