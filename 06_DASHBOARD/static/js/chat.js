// Chat JavaScript - GEM Expert
// Lógica do chat interativo

let chatHistory = [];

// Inicializar chat
document.addEventListener('DOMContentLoaded', () => {
    initChat();
});

function initChat() {
    const input = document.getElementById('chat-input');
    const sendBtn = document.getElementById('send-button');
    const quickBtns = document.querySelectorAll('.quick-btn');
    
    // Enviar mensagem ao pressionar Enter
    input.addEventListener('keypress', (e) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });
    
    // Botão enviar
    sendBtn.addEventListener('click', sendMessage);
    
    // Botões rápidos
    quickBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const question = btn.dataset.question;
            input.value = question;
            sendMessage();
        });
    });
}

// Enviar mensagem
async function sendMessage() {
    const input = document.getElementById('chat-input');
    const message = input.value.trim();
    
    if (!message) return;
    
    // Adicionar mensagem do usuário
    addMessage(message, 'user');
    input.value = '';
    
    // Desabilitar input enquanto processa
    input.disabled = true;
    document.getElementById('send-button').disabled = true;
    
    // Mostrar indicador de digitação
    showTypingIndicator();
    
    try {
        // Obter provider selecionado
        const provider = document.getElementById('ai-provider').value;
        
        // Enviar para API
        const response = await fetch('/api/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                message: message,
                provider: provider,
                history: chatHistory.slice(-10) // Últimas 10 mensagens para contexto
            })
        });
        
        const data = await response.json();
        
        // Remover indicador de digitação
        removeTypingIndicator();
        
        // Adicionar resposta do bot
        addMessage(data.response, 'bot');
        
        // Atualizar histórico
        chatHistory.push(
            { role: 'user', content: message },
            { role: 'assistant', content: data.response }
        );
        
    } catch (error) {
        console.error('Erro ao enviar mensagem:', error);
        removeTypingIndicator();
        addMessage('Desculpe, ocorreu um erro. Tente novamente.', 'bot');
    } finally {
        // Reabilitar input
        input.disabled = false;
        document.getElementById('send-button').disabled = false;
        input.focus();
    }
}

// Adicionar mensagem ao chat
function addMessage(content, role) {
    const messagesContainer = document.getElementById('chat-messages');
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${role}-message`;
    
    const now = new Date();
    const timeStr = now.toLocaleTimeString('pt-BR', { 
        hour: '2-digit', 
        minute: '2-digit' 
    });
    
    messageDiv.innerHTML = `
        <div class="message-content">
            <p>${formatMessage(content)}</p>
        </div>
        <div class="message-time">${timeStr}</div>
    `;
    
    messagesContainer.appendChild(messageDiv);
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

// Formatar mensagem (markdown básico)
function formatMessage(text) {
    // Converter markdown básico para HTML
    text = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
    text = text.replace(/\*(.*?)\*/g, '<em>$1</em>');
    text = text.replace(/`(.*?)`/g, '<code>$1</code>');
    text = text.replace(/\n/g, '<br>');
    
    // Links
    text = text.replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" target="_blank">$1</a>');
    
    return text;
}

// Mostrar indicador de digitação
function showTypingIndicator() {
    const messagesContainer = document.getElementById('chat-messages');
    const typingDiv = document.createElement('div');
    typingDiv.id = 'typing-indicator';
    typingDiv.className = 'message bot-message';
    typingDiv.innerHTML = `
        <div class="message-content">
            <p>Digitando<span class="typing-dots">...</span></p>
        </div>
    `;
    messagesContainer.appendChild(typingDiv);
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

// Remover indicador de digitação
function removeTypingIndicator() {
    const typingIndicator = document.getElementById('typing-indicator');
    if (typingIndicator) {
        typingIndicator.remove();
    }
}

// Animação de digitação
setInterval(() => {
    const dots = document.querySelector('.typing-dots');
    if (dots) {
        const current = dots.textContent;
        if (current === '...') {
            dots.textContent = '.';
        } else {
            dots.textContent = current + '.';
        }
    }
}, 500);

