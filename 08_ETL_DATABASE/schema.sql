-- Schema do Banco de Dados - GEM Expert Viagem Uruguai
-- SQLite Database Schema

-- Tabela de Viajantes
CREATE TABLE IF NOT EXISTS travelers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    document TEXT,
    email TEXT,
    phone TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Voos
CREATE TABLE IF NOT EXISTS flights (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    traveler_id INTEGER,
    flight_number TEXT NOT NULL,
    airline TEXT NOT NULL,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    departure_airport TEXT NOT NULL,
    departure_city TEXT NOT NULL,
    arrival_date DATE NOT NULL,
    arrival_time TIME NOT NULL,
    arrival_airport TEXT NOT NULL,
    arrival_city TEXT NOT NULL,
    booking_reference TEXT,
    seat TEXT,
    status TEXT DEFAULT 'confirmed',
    document_path TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (traveler_id) REFERENCES travelers(id)
);

-- Tabela de Hotéis
CREATE TABLE IF NOT EXISTS hotels (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    address TEXT,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    nights INTEGER,
    reservation_number TEXT,
    pin TEXT,
    confirmation_code TEXT,
    status TEXT DEFAULT 'pending',
    cost REAL,
    currency TEXT DEFAULT 'BRL',
    document_path TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Reservas/Atividades
CREATE TABLE IF NOT EXISTS reservations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    reservation_id TEXT UNIQUE,
    name TEXT NOT NULL,
    type TEXT NOT NULL, -- 'tour', 'event', 'restaurant', 'activity'
    date DATE NOT NULL,
    time TIME,
    location TEXT NOT NULL,
    address TEXT,
    cost_per_person REAL,
    cost_total REAL,
    currency TEXT DEFAULT 'BRL',
    status TEXT DEFAULT 'pending',
    confirmation_code TEXT,
    contact_phone TEXT,
    contact_email TEXT,
    transfer_included BOOLEAN DEFAULT 0,
    pickup_time TIME,
    pickup_location TEXT,
    return_time TIME,
    dress_code TEXT,
    notes TEXT,
    document_path TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Aluguel de Carros
CREATE TABLE IF NOT EXISTS car_rentals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    rental_company TEXT NOT NULL,
    confirmation_number TEXT UNIQUE NOT NULL,
    pickup_date DATE NOT NULL,
    pickup_time TIME NOT NULL,
    pickup_location TEXT NOT NULL,
    pickup_address TEXT,
    return_date DATE NOT NULL,
    return_time TIME NOT NULL,
    return_location TEXT NOT NULL,
    return_address TEXT,
    days INTEGER,
    car_model TEXT,
    cost REAL,
    currency TEXT DEFAULT 'BRL',
    status TEXT DEFAULT 'pending',
    insurance_included BOOLEAN DEFAULT 0,
    telepeaje_included BOOLEAN DEFAULT 0,
    fuel_policy TEXT,
    document_path TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Seguros
CREATE TABLE IF NOT EXISTS insurances (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    traveler_id INTEGER,
    insurance_company TEXT NOT NULL,
    policy_number TEXT UNIQUE NOT NULL,
    certificate_number TEXT,
    coverage_start DATE NOT NULL,
    coverage_end DATE NOT NULL,
    cost REAL,
    currency TEXT DEFAULT 'BRL',
    status TEXT DEFAULT 'confirmed',
    document_path TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (traveler_id) REFERENCES travelers(id)
);

-- Tabela de Documentos Processados
CREATE TABLE IF NOT EXISTS processed_documents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    file_path TEXT UNIQUE NOT NULL,
    file_type TEXT NOT NULL, -- 'boarding_pass', 'hotel_reservation', 'insurance', 'flight_ticket', 'car_rental'
    file_hash TEXT,
    extraction_status TEXT DEFAULT 'pending', -- 'pending', 'success', 'failed', 'partial'
    extraction_date TIMESTAMP,
    extracted_data TEXT, -- JSON com dados extraídos
    validation_status TEXT DEFAULT 'pending', -- 'pending', 'valid', 'invalid', 'needs_review'
    validation_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Itinerário Detalhado
CREATE TABLE IF NOT EXISTS itinerary (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    day INTEGER NOT NULL,
    date DATE NOT NULL,
    weekday TEXT,
    location TEXT NOT NULL,
    event_time TIME,
    event_type TEXT, -- 'arrival', 'departure', 'reservation', 'activity', 'meal', 'logistics', 'free'
    title TEXT NOT NULL,
    details TEXT,
    status TEXT DEFAULT 'pending', -- 'confirmed', 'pending', 'suggestion', 'free'
    reservation_id TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

-- Tabela de Contatos Essenciais
CREATE TABLE IF NOT EXISTS contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT NOT NULL, -- 'hotel', 'restaurant', 'tour', 'emergency', 'car_rental', 'airline'
    phone TEXT,
    email TEXT,
    address TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para melhor performance
CREATE INDEX IF NOT EXISTS idx_flights_traveler ON flights(traveler_id);
CREATE INDEX IF NOT EXISTS idx_flights_departure_date ON flights(departure_date);
CREATE INDEX IF NOT EXISTS idx_hotels_check_in ON hotels(check_in_date);
CREATE INDEX IF NOT EXISTS idx_reservations_date ON reservations(date);
CREATE INDEX IF NOT EXISTS idx_reservations_status ON reservations(status);
CREATE INDEX IF NOT EXISTS idx_car_rentals_pickup_date ON car_rentals(pickup_date);
CREATE INDEX IF NOT EXISTS idx_itinerary_date ON itinerary(date);
CREATE INDEX IF NOT EXISTS idx_processed_documents_status ON processed_documents(extraction_status);

