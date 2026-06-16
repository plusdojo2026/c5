
-- 今作成した「c5」データベースに切り替える
USE c5;


--  定義書の仕様に完全に合わせた「users」テーブルを作成する
CREATE TABLE users (
    family_id VARCHAR(32) NOT NULL,   
    couple_id INT NOT NULL,          
    password VARCHAR(64) NOT NULL,    
    
   
    PRIMARY KEY (family_id, couple_id)		 
);


-- ファミリーID
-- カップルID (妻=0, 夫=1)
-- パスワード (SHA-256ハッシュ)
-- 夫婦でファミリーIDを共有し、ママ(0)とパパ(1)がそれぞれ1件ずつ登録できるよう、複合主キーに設定
