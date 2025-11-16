#!/usr/bin/env python3
"""
Script de Teste de Integrações
GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025
"""

import os
import sys
from dotenv import load_dotenv

# Carregar variáveis de ambiente
load_dotenv()

def test_openai():
    """Testar integração OpenAI"""
    try:
        from openai import OpenAI

        api_key = os.getenv('OPENAI_API_KEY')
        if not api_key:
            print("❌ OpenAI API Key não encontrada")
            return False

        client = OpenAI(api_key=api_key)

        response = client.chat.completions.create(
            model=os.getenv('OPENAI_MODEL', 'gpt-4-turbo-preview'),
            messages=[
                {"role": "system", "content": "Você é um assistente útil."},
                {"role": "user", "content": "Responda apenas: OK"}
            ],
            max_tokens=10,
            temperature=0.7
        )

        print("✅ OpenAI: Configurado e funcionando")
        print(f"   Resposta: {response.choices[0].message.content}")
        return True

    except ImportError:
        print("❌ OpenAI SDK não instalado. Execute: pip3 install openai")
        return False
    except Exception as e:
        print(f"❌ OpenAI: Erro - {str(e)}")
        return False

def test_anthropic():
    """Testar integração Anthropic"""
    try:
        import anthropic

        api_key = os.getenv('ANTHROPIC_API_KEY')
        if not api_key:
            print("❌ Anthropic API Key não encontrada")
            return False

        client = anthropic.Anthropic(api_key=api_key)

        message = client.messages.create(
            model=os.getenv('ANTHROPIC_MODEL', 'claude-3-5-sonnet-20241022'),
            max_tokens=10,
            messages=[
                {"role": "user", "content": "Responda apenas: OK"}
            ]
        )

        print("✅ Anthropic: Configurado e funcionando")
        print(f"   Resposta: {message.content[0].text}")
        return True

    except ImportError:
        print("❌ Anthropic SDK não instalado. Execute: pip3 install anthropic")
        return False
    except Exception as e:
        print(f"❌ Anthropic: Erro - {str(e)}")
        return False

def test_google():
    """Testar integração Google Gemini"""
    try:
        import google.generativeai as genai

        api_key = os.getenv('GOOGLE_API_KEY')
        if not api_key:
            print("❌ Google API Key não encontrada")
            return False

        genai.configure(api_key=api_key)
        model = genai.GenerativeModel(os.getenv('GOOGLE_MODEL', 'gemini-2.5-pro'))

        response = model.generate_content("Responda apenas: OK")

        print("✅ Google Gemini: Configurado e funcionando")
        print(f"   Resposta: {response.text}")
        return True

    except ImportError:
        print("❌ Google Generative AI SDK não instalado. Execute: pip3 install google-generativeai")
        return False
    except Exception as e:
        print(f"❌ Google Gemini: Erro - {str(e)}")
        return False

def test_github():
    """Testar configuração GitHub"""
    token = os.getenv('GITHUB_TOKEN')
    username = os.getenv('GITHUB_USERNAME')
    repo = os.getenv('GITHUB_REPO')

    if token and username and repo:
        print("✅ GitHub: Configurado")
        print(f"   Username: {username}")
        print(f"   Repo: {repo}")
        print(f"   Token: {'*' * 20}...{token[-10:]}")
        return True
    else:
        print("❌ GitHub: Configuração incompleta")
        return False

def main():
    """Executar todos os testes"""
    print("🧪 Testando Integrações do GEM Expert\n")
    print("=" * 50)

    results = {
        'GitHub': test_github(),
        'OpenAI': test_openai(),
        'Anthropic': test_anthropic(),
        'Google Gemini': test_google()
    }

    print("\n" + "=" * 50)
    print("\n📊 Resumo dos Testes:\n")

    for service, result in results.items():
        status = "✅" if result else "❌"
        print(f"{status} {service}")

    all_passed = all(results.values())

    if all_passed:
        print("\n🎉 Todas as integrações estão funcionando!")
        return 0
    else:
        print("\n⚠️  Algumas integrações precisam de atenção")
        return 1

if __name__ == "__main__":
    sys.exit(main())

