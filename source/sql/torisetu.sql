CREATE TABLE torisetu(
	torisetu_id INT AUTO_INCREMENT PRIMARY KEY,
	family_id VARCHAR(32) NOT NULL UNIQUE,
	
	happy1 VARCHAR(100),
    happy2 VARCHAR(100),
    happy3 VARCHAR(100),

    angry1 VARCHAR(100),
    angry2 VARCHAR(100),
    angry3 VARCHAR(100),

    fun1 VARCHAR(100),
    fun2 VARCHAR(100),
    fun3 VARCHAR(100),

    sad1 VARCHAR(100),
    sad2 VARCHAR(100),
    sad3 VARCHAR(100),

    charge1 VARCHAR(100),
    charge2 VARCHAR(100),
    charge3 VARCHAR(100),
    
    bad1 VARCHAR(100),
    bad2 VARCHAR(100),
    bad3 VARCHAR(100),

    badaction1 VARCHAR(100),
    badaction2 VARCHAR(100),
    badaction3 VARCHAR(100),

    update_at TIMESTAMP DEFAULT NULL
);