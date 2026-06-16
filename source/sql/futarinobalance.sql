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

