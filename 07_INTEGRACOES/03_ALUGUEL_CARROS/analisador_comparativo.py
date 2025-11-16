#!/usr/bin/env python3
"""
Analisador Comparativo de Aluguel de Carros
GEM Expert - Viagem Aline & Luiz Fernando | Uruguai 2025

Valida e compara ofertas de Kwid vs Onix entre múltiplas plataformas.
"""

import json
import os
from datetime import datetime
from typing import Dict, List, Optional
from dataclasses import dataclass, asdict
from pathlib import Path


@dataclass
class OfertaCarro:
    """Estrutura de dados para uma oferta de carro"""
    plataforma: str
    veiculo: str  # "Kwid" ou "Onix"
    preco_diaria: float
    preco_total: float
    seguro_basico: str  # "Incluído" ou "+R$ X"
    seguro_full: Optional[str] = None
    combustivel: str  # "Cheio/Cheio", "Vazio/Vazio", etc.
    cancelamento: str  # "Grátis" ou "Pago"
    limite_km: str  # "Ilimitado" ou "X km"
    taxa_aeroporto: bool = False
    taxa_limpeza: bool = False
    gps_wifi: Optional[str] = None
    motorista_adicional: Optional[str] = None
    observacoes: Optional[str] = None
    link_reserva: Optional[str] = None
    data_coleta: Optional[str] = None


class AnalisadorComparativo:
    """Analisa e compara ofertas de aluguel de carros"""
    
    def __init__(self, arquivo_dados: str = "ofertas_comparacao.json"):
        self.arquivo_dados = arquivo_dados
        self.ofertas: List[OfertaCarro] = []
        self._carregar_ofertas()
    
    def _carregar_ofertas(self):
        """Carrega ofertas do arquivo JSON"""
        if os.path.exists(self.arquivo_dados):
            try:
                with open(self.arquivo_dados, 'r', encoding='utf-8') as f:
                    dados = json.load(f)
                    self.ofertas = [OfertaCarro(**oferta) for oferta in dados.get('ofertas', [])]
            except Exception as e:
                print(f"⚠️ Erro ao carregar ofertas: {e}")
                self.ofertas = []
    
    def _salvar_ofertas(self):
        """Salva ofertas no arquivo JSON"""
        dados = {
            'ultima_atualizacao': datetime.now().isoformat(),
            'ofertas': [asdict(oferta) for oferta in self.ofertas]
        }
        with open(self.arquivo_dados, 'w', encoding='utf-8') as f:
            json.dump(dados, f, indent=2, ensure_ascii=False)
    
    def adicionar_oferta(self, oferta: OfertaCarro):
        """Adiciona uma nova oferta"""
        oferta.data_coleta = datetime.now().isoformat()
        self.ofertas.append(oferta)
        self._salvar_ofertas()
    
    def comparar_por_veiculo(self, veiculo: str) -> List[OfertaCarro]:
        """Retorna todas as ofertas de um veículo específico, ordenadas por preço"""
        ofertas_veiculo = [o for o in self.ofertas if o.veiculo.lower() == veiculo.lower()]
        return sorted(ofertas_veiculo, key=lambda x: x.preco_total)
    
    def melhor_oferta_por_veiculo(self, veiculo: str) -> Optional[OfertaCarro]:
        """Retorna a melhor oferta (menor preço) para um veículo"""
        ofertas = self.comparar_por_veiculo(veiculo)
        return ofertas[0] if ofertas else None
    
    def calcular_economia(self, oferta1: OfertaCarro, oferta2: OfertaCarro) -> Dict:
        """Calcula economia entre duas ofertas"""
        diferenca = abs(oferta1.preco_total - oferta2.preco_total)
        percentual = (diferenca / oferta2.preco_total) * 100 if oferta2.preco_total > 0 else 0
        
        return {
            'diferenca_absoluta': diferenca,
            'percentual': percentual,
            'mais_barata': oferta1 if oferta1.preco_total < oferta2.preco_total else oferta2
        }
    
    def gerar_relatorio_comparativo(self) -> Dict:
        """Gera relatório completo comparando Kwid vs Onix"""
        kwid_ofertas = self.comparar_por_veiculo("Kwid")
        onix_ofertas = self.comparar_por_veiculo("Onix")
        
        melhor_kwid = self.melhor_oferta_por_veiculo("Kwid")
        melhor_onix = self.melhor_oferta_por_veiculo("Onix")
        
        comparacao_kwid_onix = None
        if melhor_kwid and melhor_onix:
            comparacao_kwid_onix = self.calcular_economia(melhor_kwid, melhor_onix)
        
        return {
            'data_analise': datetime.now().isoformat(),
            'kwid': {
                'total_ofertas': len(kwid_ofertas),
                'melhor_oferta': asdict(melhor_kwid) if melhor_kwid else None,
                'todas_ofertas': [asdict(o) for o in kwid_ofertas]
            },
            'onix': {
                'total_ofertas': len(onix_ofertas),
                'melhor_oferta': asdict(melhor_onix) if melhor_onix else None,
                'todas_ofertas': [asdict(o) for o in onix_ofertas]
            },
            'comparacao': {
                'kwid_vs_onix': comparacao_kwid_onix,
                'recomendacao': self._gerar_recomendacao(melhor_kwid, melhor_onix)
            }
        }
    
    def _gerar_recomendacao(self, melhor_kwid: Optional[OfertaCarro], 
                           melhor_onix: Optional[OfertaCarro]) -> Dict:
        """Gera recomendação final"""
        if not melhor_kwid or not melhor_onix:
            return {
                'veiculo': None,
                'motivo': 'Dados insuficientes para comparação'
            }
        
        if melhor_kwid.preco_total < melhor_onix.preco_total:
            economia = melhor_onix.preco_total - melhor_kwid.preco_total
            percentual = (economia / melhor_onix.preco_total) * 100
            return {
                'veiculo': 'Kwid',
                'plataforma': melhor_kwid.plataforma,
                'preco_total': melhor_kwid.preco_total,
                'economia_vs_onix': economia,
                'percentual_economia': percentual,
                'link_reserva': melhor_kwid.link_reserva,
                'motivo': f'Kwid é R$ {economia:.2f} mais barato ({percentual:.1f}% de economia)'
            }
        else:
            economia = melhor_kwid.preco_total - melhor_onix.preco_total
            percentual = (economia / melhor_kwid.preco_total) * 100
            return {
                'veiculo': 'Onix',
                'plataforma': melhor_onix.plataforma,
                'preco_total': melhor_onix.preco_total,
                'economia_vs_kwid': economia,
                'percentual_economia': percentual,
                'link_reserva': melhor_onix.link_reserva,
                'motivo': f'Onix é R$ {economia:.2f} mais barato ({percentual:.1f}% de economia)'
            }
    
    def gerar_markdown_analise(self) -> str:
        """Gera análise em formato Markdown para o documento"""
        relatorio = self.gerar_relatorio_comparativo()
        
        md = f"""# 📊 ANÁLISE COMPARATIVA ATUALIZADA
## Aluguel de Carro - Kwid vs Onix
### Gerado em: {datetime.now().strftime('%d/%m/%Y %H:%M')}

---

## 🏆 MELHOR PREÇO KWID

"""
        
        if relatorio['kwid']['melhor_oferta']:
            kwid = relatorio['kwid']['melhor_oferta']
            md += f"""
- **Plataforma:** {kwid['plataforma']}
- **Preço Total (7 dias):** R$ {kwid['preco_total']:.2f}
- **Preço Diária:** R$ {kwid['preco_diaria']:.2f}
- **Seguro Básico:** {kwid['seguro_basico']}
- **Seguro Full:** {kwid.get('seguro_full', 'N/A')}
- **Combustível:** {kwid['combustivel']}
- **Cancelamento:** {kwid['cancelamento']}
- **KM:** {kwid['limite_km']}
- **Link:** {kwid.get('link_reserva', 'N/A')}
"""
        else:
            md += "\n⚠️ Nenhuma oferta de Kwid encontrada.\n"
        
        md += "\n---\n\n## 🏆 MELHOR PREÇO ONIX\n\n"
        
        if relatorio['onix']['melhor_oferta']:
            onix = relatorio['onix']['melhor_oferta']
            md += f"""
- **Plataforma:** {onix['plataforma']}
- **Preço Total (7 dias):** R$ {onix['preco_total']:.2f}
- **Preço Diária:** R$ {onix['preco_diaria']:.2f}
- **Seguro Básico:** {onix['seguro_basico']}
- **Seguro Full:** {onix.get('seguro_full', 'N/A')}
- **Combustível:** {onix['combustivel']}
- **Cancelamento:** {onix['cancelamento']}
- **KM:** {onix['limite_km']}
- **Link:** {onix.get('link_reserva', 'N/A')}
"""
        else:
            md += "\n⚠️ Nenhuma oferta de Onix encontrada.\n"
        
        md += "\n---\n\n## ⚡ RECOMENDAÇÃO FINAL\n\n"
        
        rec = relatorio['comparacao']['recomendacao']
        if rec.get('veiculo'):
            md += f"""
- **Veículo Recomendado:** {rec['veiculo']}
- **Plataforma:** {rec['plataforma']}
- **Preço Total:** R$ {rec['preco_total']:.2f}
- **Economia:** {rec.get('motivo', 'N/A')}
- **Link para Reserva:** {rec.get('link_reserva', 'N/A')}
"""
        else:
            md += f"\n⚠️ {rec.get('motivo', 'Dados insuficientes')}\n"
        
        md += "\n---\n\n## 📋 TODAS AS OFERTAS\n\n"
        
        md += "### Kwid\n\n"
        for i, oferta in enumerate(relatorio['kwid']['todas_ofertas'], 1):
            md += f"{i}. **{oferta['plataforma']}** - R$ {oferta['preco_total']:.2f} ({oferta['seguro_basico']})\n"
        
        md += "\n### Onix\n\n"
        for i, oferta in enumerate(relatorio['onix']['todas_ofertas'], 1):
            md += f"{i}. **{oferta['plataforma']}** - R$ {oferta['preco_total']:.2f} ({oferta['seguro_basico']})\n"
        
        return md


if __name__ == "__main__":
    # Exemplo de uso
    analisador = AnalisadorComparativo()
    
    # Exemplo: adicionar oferta
    # oferta = OfertaCarro(
    #     plataforma="Booking.com",
    #     veiculo="Kwid",
    #     preco_diaria=150.00,
    #     preco_total=1050.00,
    #     seguro_basico="Incluído",
    #     seguro_full="+R$ 200",
    #     combustivel="Cheio/Cheio",
    #     cancelamento="Grátis",
    #     limite_km="Ilimitado",
    #     link_reserva="https://..."
    # )
    # analisador.adicionar_oferta(oferta)
    
    # Gerar relatório
    relatorio = analisador.gerar_relatorio_comparativo()
    print(json.dumps(relatorio, indent=2, ensure_ascii=False))
    
    # Gerar markdown
    md = analisador.gerar_markdown_analise()
    print("\n" + "="*50)
    print(md)

