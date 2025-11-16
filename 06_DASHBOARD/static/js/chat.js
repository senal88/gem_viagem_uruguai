/**
 * Chat com GEM Expert
 * Integração com múltiplos providers (Gemini, OpenAI, Anthropic)
 */

(function() {
    'use strict';

    const API_BASE = window.location.pathname.includes('/gem') ? '/gem/api' : '/api';

    // Elementos
    const chatMessages = document.getElementById('chatMessages');
    const chatInput = document.getElementById('chatInput');
    const sendButton = document.getElementById('sendButton');
    const providerSelect = document.getElementById('providerSelect');

    // Histórico de mensagens
    let messageHistory = [];

    // Inicialização
    function init() {
        setupEventListeners();
        addWelcomeMessage();
    }

    // Event listeners
    function setupEventListeners() {
        sendButton.addEventListener('click', sendMessage);
        chatInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });
    }

    // Mensagem de boas-vindas
    function addWelcomeMessage() {
        addMessage('assistant', 'Olá! Sou o GEM Expert, seu concierge pessoal para a viagem ao Uruguai. Como posso ajudar?');
    }

    // Enviar mensagem
    async function sendMessage() {
        const message = chatInput.value.trim();
        if (!message) return;

        // Adicionar mensagem do usuário
        addMessage('user', message);
        chatInput.value = '';

        // Mostrar loading
        const loadingId = addMessage('assistant', 'Pensando...', true);

        try {
            const provider = providerSelect.value;
            const response = await fetch(`${API_BASE}/chat`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    message: message,
                    provider: provider,
                    history: messageHistory
                })
            });

            if (!response.ok) {
                throw new Error(`Erro ${response.status}: ${response.statusText}`);
            }

            const data = await response.json();

            // Remover loading
            removeMessage(loadingId);

            // Adicionar resposta
            addMessage('assistant', data.response || 'Erro ao processar resposta');

            // Atualizar histórico
            messageHistory.push(
                { role: 'user', content: message },
                { role: 'assistant', content: data.response }
            );

            // Limitar histórico (últimas 10 mensagens)
            if (messageHistory.length > 20) {
                messageHistory = messageHistory.slice(-20);
            }

        } catch (error) {
            removeMessage(loadingId);
            addMessage('assistant', `Erro: ${error.message}`, false);
        }
    }

    // Adicionar mensagem ao chat
    function addMessage(role, content, isLoading = false) {
        const messageDiv = document.createElement('div');
        const messageId = 'msg-' + Date.now();
        messageDiv.id = messageId;
        messageDiv.className = `chat-message ${role}`;

        if (isLoading) {
            messageDiv.innerHTML = '<span class="loading-dots">...</span>';
        } else {
            messageDiv.textContent = content;
        }

        chatMessages.appendChild(messageDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;

        return messageId;
    }

    // Remover mensagem
    function removeMessage(messageId) {
        const message = document.getElementById(messageId);
        if (message) {
            message.remove();
        }
    }

    // Inicializar quando DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
