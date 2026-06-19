
CREATE TABLE sukusukukiroku (
    sukusuku_id INT AUTO_INCREMENT PRIMARY KEY,
    family_id VARCHAR(50) NOT NULL,
    weight DOUBLE,
    temperature DOUBLE,
    note TEXT,
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
