CREATE TABLE IF NOT EXISTS compteur (
    id SERIAL PRIMARY KEY,  
    nombre INT DEFAULT 0
);

INSERT INTO compteur (nombre) VALUES (0)
ON CONFLICT (id) DO NOTHING;