CREATE TABLE todo (
    task_id   INT         NOT NULL AUTO_INCREMENT,  -- タスクID (主キー)
    task_name VARCHAR(50) NOT NULL,                 -- タスク名
    PRIMARY KEY (task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
INSERT INTO todo (task_id, task_name) VALUES
    ( 1, 'ミルク'),
    ( 2, 'おむつ交換'),
    ( 3, '沐浴・お風呂'),
    ( 4, '寝かしつけ'),
    ( 5, '夜泣き'),
    ( 6, '歯磨き'),
    ( 7, '哺乳瓶の洗浄・消毒'),
    ( 8, '送り迎え'),
    ( 9, '離乳食準備'),
    (10, '病院対応'),
    (11, 'ご飯を作る'),
    (12, '洗い物をする'),
    (13, '洗濯機を回す'),
    (14, '洗濯物を干す'),
    (15, '洗濯物を畳む'),
    (16, '掃除機をかける'),
    (17, 'ゴミ出し'),
    (18, '買い物に行く'),
    (19, '消耗品の補充・注文'),
    (20, '風呂掃除'),
    (21, 'トイレ掃除');
 -- ============================================================
--  8. futarinobalance (ふたりのバランス)
--     21個のタスクを「妻/夫/未割当」で振り分ける表
--     ※ couple_id は 0=妻 / 1=夫 / 2=未割当 (FutarinobalanceDaoより)
--     ※ couple_id=2 は users に存在しないので、ここでは複合FKは張らない
-- ============================================================
CREATE TABLE futarinobalance (
    balance_id    INT         NOT NULL AUTO_INCREMENT,  -- バランスID (主キー)
    family_id     VARCHAR(32) NOT NULL,                 -- ファミリーID
    couple_id     INT         NOT NULL DEFAULT 2,       -- 担当 (0=妻, 1=夫, 2=未割当)
    todo_id       INT         NOT NULL,                 -- FK → todo
    display_order INT         NOT NULL DEFAULT 0,       -- 表示順
    PRIMARY KEY (balance_id),
    FOREIGN KEY (todo_id) REFERENCES todo (task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

