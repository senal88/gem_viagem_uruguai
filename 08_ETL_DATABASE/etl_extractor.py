#!/usr/bin/env python3
"""
ETL Extractor - Extrai dados de documentos PDF da viagem
Processa: cartões de embarque, reservas de hotéis, seguro, passagens, aluguel de carro
"""

import os
import sys
import json
import sqlite3
import hashlib
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Any
import re

# Adicionar diretório raiz ao path
sys.path.insert(0, str(Path(__file__).parent.parent))

class DocumentExtractor:
    """Classe base para extração de dados de documentos"""
    
    def __init__(self, db_path: str = "viagem_uruguai.db"):
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
        self._init_database()
    
    def _init_database(self):
        """Inicializa o banco de dados com o schema"""
        schema_path = Path(__file__).parent / "schema.sql"
        if schema_path.exists():
            with open(schema_path, 'r', encoding='utf-8') as f:
                schema = f.read()
            self.conn.executescript(schema)
            self.conn.commit()
    
    def calculate_file_hash(self, file_path: str) -> str:
        """Calcula hash SHA256 do arquivo"""
        sha256_hash = hashlib.sha256()
        with open(file_path, "rb") as f:
            for byte_block in iter(lambda: f.read(4096), b""):
                sha256_hash.update(byte_block)
        return sha256_hash.hexdigest()
    
    def extract_text_from_pdf(self, pdf_path: str) -> str:
        """Extrai texto de PDF usando PyPDF2 ou pdfplumber"""
        try:
            import pdfplumber
            with pdfplumber.open(pdf_path) as pdf:
                text = ""
                for page in pdf.pages:
                    text += page.extract_text() or ""
                return text
        except ImportError:
            try:
                import PyPDF2
                with open(pdf_path, 'rb') as file:
                    reader = PyPDF2.PdfReader(file)
                    text = ""
                    for page in reader.pages:
                        text += page.extract_text()
                    return text
            except ImportError:
                print("⚠️  Instale pdfplumber ou PyPDF2: pip install pdfplumber")
                return ""
    
    def extract_boarding_pass(self, pdf_path: str) -> Optional[Dict[str, Any]]:
        """Extrai dados de cartão de embarque"""
        text = self.extract_text_from_pdf(pdf_path)
        if not text:
            return None
        
        # Padrões para cartão de embarque LATAM
        data = {
            "file_path": pdf_path,
            "file_type": "boarding_pass",
            "extracted_data": {}
        }
        
        # Extrair número do voo
        flight_match = re.search(r'LA\s*(\d{4})', text, re.IGNORECASE)
        if flight_match:
            data["extracted_data"]["flight_number"] = f"LA{flight_match.group(1)}"
        
        # Extrair datas e horários
        date_match = re.search(r'(\d{2})[/-](\d{2})[/-](\d{4})', text)
        time_match = re.search(r'(\d{2}):(\d{2})', text)
        
        # Extrair aeroportos (MVD, VIX, etc)
        airport_match = re.search(r'([A-Z]{3})\s*-\s*([A-Z]{3})', text)
        
        # Extrair nome do passageiro
        name_match = re.search(r'([A-Z]+\s+[A-Z]+)', text)
        
        # Extrair assento
        seat_match = re.search(r'SEAT\s*:?\s*([0-9]+[A-Z])', text, re.IGNORECASE)
        
        return data
    
    def extract_hotel_reservation(self, pdf_path: str) -> Optional[Dict[str, Any]]:
        """Extrai dados de reserva de hotel"""
        text = self.extract_text_from_pdf(pdf_path)
        if not text:
            return None
        
        data = {
            "file_path": pdf_path,
            "file_type": "hotel_reservation",
            "extracted_data": {}
        }
        
        # Padrões comuns em reservas de hotel
        # Nome do hotel
        hotel_patterns = [
            r'Hotel\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)',
            r'([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)\s+Hotel'
        ]
        
        # Número de confirmação
        conf_match = re.search(r'(?:Confirmação|Reserva|Booking)\s*:?\s*([A-Z0-9]+)', text, re.IGNORECASE)
        if conf_match:
            data["extracted_data"]["reservation_number"] = conf_match.group(1)
        
        # Datas de check-in/check-out
        checkin_match = re.search(r'Check[- ]in\s*:?\s*(\d{2})[/-](\d{2})[/-](\d{4})', text, re.IGNORECASE)
        checkout_match = re.search(r'Check[- ]out\s*:?\s*(\d{2})[/-](\d{2})[/-](\d{4})', text, re.IGNORECASE)
        
        return data
    
    def extract_car_rental(self, pdf_path: str) -> Optional[Dict[str, Any]]:
        """Extrai dados de aluguel de carro"""
        text = self.extract_text_from_pdf(pdf_path)
        if not text:
            return None
        
        data = {
            "file_path": pdf_path,
            "file_type": "car_rental",
            "extracted_data": {}
        }
        
        # Número de confirmação Budget
        conf_match = re.search(r'(\d{8,}[A-Z0-9]+)', text)
        if conf_match:
            data["extracted_data"]["confirmation_number"] = conf_match.group(1)
        
        # Locadora
        if "Budget" in text or "BUDGET" in text:
            data["extracted_data"]["rental_company"] = "Budget"
        
        # Datas de retirada/devolução
        pickup_match = re.search(r'Retirada[:\s]+(\d{2})[/-](\d{2})[/-](\d{4})', text, re.IGNORECASE)
        return_match = re.search(r'Devolução[:\s]+(\d{2})[/-](\d{2})[/-](\d{4})', text, re.IGNORECASE)
        
        return data
    
    def extract_insurance(self, pdf_path: str) -> Optional[Dict[str, Any]]:
        """Extrai dados de seguro viagem"""
        text = self.extract_text_from_pdf(pdf_path)
        if not text:
            return None
        
        data = {
            "file_path": pdf_path,
            "file_type": "insurance",
            "extracted_data": {}
        }
        
        # Número da apólice
        policy_match = re.search(r'(?:Apólice|Policy)\s*:?\s*([A-Z0-9]+)', text, re.IGNORECASE)
        if policy_match:
            data["extracted_data"]["policy_number"] = policy_match.group(1)
        
        # Certificado
        cert_match = re.search(r'(?:Certificado|Certificate)\s*:?\s*(\d+)', text, re.IGNORECASE)
        if cert_match:
            data["extracted_data"]["certificate_number"] = cert_match.group(1)
        
        return data
    
    def process_document(self, file_path: str) -> Dict[str, Any]:
        """Processa um documento e extrai dados"""
        file_path = Path(file_path)
        if not file_path.exists():
            return {"error": "Arquivo não encontrado"}
        
        file_hash = self.calculate_file_hash(str(file_path))
        file_type = self._detect_file_type(str(file_path))
        
        # Verificar se já foi processado
        cursor = self.conn.execute(
            "SELECT id FROM processed_documents WHERE file_hash = ?",
            (file_hash,)
        )
        existing = cursor.fetchone()
        if existing:
            return {"status": "already_processed", "id": existing["id"]}
        
        # Extrair dados baseado no tipo
        extracted_data = None
        if file_type == "boarding_pass":
            extracted_data = self.extract_boarding_pass(str(file_path))
        elif file_type == "hotel_reservation":
            extracted_data = self.extract_hotel_reservation(str(file_path))
        elif file_type == "car_rental":
            extracted_data = self.extract_car_rental(str(file_path))
        elif file_type == "insurance":
            extracted_data = self.extract_insurance(str(file_path))
        
        # Salvar no banco
        cursor = self.conn.execute("""
            INSERT INTO processed_documents 
            (file_path, file_type, file_hash, extraction_status, extracted_data, extraction_date)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (
            str(file_path),
            file_type,
            file_hash,
            "success" if extracted_data else "failed",
            json.dumps(extracted_data["extracted_data"] if extracted_data else {}),
            datetime.now().isoformat()
        ))
        
        self.conn.commit()
        return {
            "status": "success",
            "id": cursor.lastrowid,
            "extracted_data": extracted_data
        }
    
    def _detect_file_type(self, file_path: str) -> str:
        """Detecta o tipo de documento baseado no nome do arquivo"""
        filename = Path(file_path).name.lower()
        
        if "cartão" in filename or "boarding" in filename or "embarque" in filename:
            return "boarding_pass"
        elif "reserva" in filename or "hotel" in filename:
            return "hotel_reservation"
        elif "aluguel" in filename or "carro" in filename or "rental" in filename:
            return "car_rental"
        elif "seguro" in filename or "insurance" in filename or "certificado" in filename:
            return "insurance"
        elif "passagem" in filename or "ticket" in filename:
            return "flight_ticket"
        else:
            return "unknown"
    
    def process_all_documents(self, directory: str = ".") -> List[Dict[str, Any]]:
        """Processa todos os PDFs em um diretório"""
        directory = Path(directory)
        pdf_files = list(directory.glob("*.pdf"))
        
        results = []
        for pdf_file in pdf_files:
            print(f"📄 Processando: {pdf_file.name}")
            result = self.process_document(str(pdf_file))
            results.append(result)
        
        return results
    
    def close(self):
        """Fecha conexão com banco de dados"""
        self.conn.close()


def main():
    """Função principal"""
    # Diretório raiz do projeto
    project_root = Path(__file__).parent.parent
    db_path = project_root / "08_ETL_DATABASE" / "viagem_uruguai.db"
    
    extractor = DocumentExtractor(str(db_path))
    
    # Processar documentos PDFs no diretório raiz
    print("🔍 Procurando documentos PDF...")
    results = extractor.process_all_documents(str(project_root))
    
    print(f"\n✅ Processados {len(results)} documentos")
    extractor.close()


if __name__ == "__main__":
    main()

