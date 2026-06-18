--マスタテーブル（category）を作成
CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50),
    size VARCHAR(50)
);

--おねだりテーブルの作成
CREATE TABLE onedari (
    onedari_id INT AUTO_INCREMENT PRIMARY KEY,
    family_id VARCHAR(32) NOT NULL,
    couple_id INT NOT NULL,                        -- 0:ママ / 1:パパ
    category_id INT NOT NULL,                      -- マスタ(category)のIDと繋ぐ列
    product_name VARCHAR(50),                      -- 自由入力の商品名（ブランドなど）
    image_path VARCHAR(255),                       -- 画像ファイル名
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 登録時の現在時刻が自動で入る
    updated_at DATETIME NULL,                      -- 購入日時（未購入はNULL / 購入したら時刻が入る）
    
    -- 外部キー制約（存在しない家族や存在しないマスタIDを登録できないように守る！）
    FOREIGN KEY (family_id) REFERENCES users(family_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);


INSERT INTO category (id, name, type, size) VALUES
(1, '紙おむつ', 'テープタイプ', '新生児'),
(2, '紙おむつ', 'テープタイプ', 'Sサイズ'),
(3, '紙おむつ', 'テープタイプ', 'Mサイズ'),
(4, '紙おむつ', 'テープタイプ', 'Lサイズ'),
(5, '紙おむつ', 'テープタイプ', 'BIGサイズ'),
(6, '紙おむつ', 'パンツタイプ', '新生児'),
(7, '紙おむつ', 'パンツタイプ', 'Sサイズ'),
(8, '紙おむつ', 'パンツタイプ', 'Mサイズ'),
(9, '紙おむつ', 'パンツタイプ', 'Lサイズ'),
(10, '紙おむつ', 'パンツタイプ', 'BIGサイズ'),
(11, 'ミルク', '缶', '-'),
(12, 'ミルク', 'スティック', '-'),
(13, 'ミルク', 'キューブ', '-'),
(14, 'その他', '-', '-');


