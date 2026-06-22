--これを採用
CREATE TABLE album(

	album_id INT AUTO_INCREMENT PRIMARY KEY,
	family_id VARCHAR(32) NOT NULL UNIQUE,
	                          
    couple_id INT NOT NULL,                          
    photo_path VARCHAR(255) NOT NULL,                
    comment VARCHAR(200) NOT NULL,                   
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


----------------------------------------------------------------------
--候補2（入力しない）
CREATE TABLE album(

	omoidealbum_id INT AUTO_INCREMENT PRIMARY KEY,
	
	family_id VARCHAR(32) NOT NULL UNIQUE,
	album_id INT NOT NULL,
	                          
    couple_id INT NOT NULL,                          
    photo_path VARCHAR(255) NOT NULL,                
    comment VARCHAR(200) NOT NULL,                   
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    
);
