CREATE TABLE mamanoyousu (
    mamanoyousu_id INT AUTO_INCREMENT PRIMARY KEY,
    family_id VARCHAR(50) NOT NULL,
    couple_id INT NOT NULL,
    physical_score INT NOT NULL,
    mental_score INT NOT NULL,
    sleep_hours DOUBLE NOT NULL,
    stress INT NOT NULL,
    memo TEXT,
    recorded_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);