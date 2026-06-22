         CREATE TABLE tasks (
         task_id   INT         NOT NULL AUTO_INCREMENT,
         task_name VARCHAR(20) NOT NULL,
         PRIMARY KEY (task_id)
     ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; INSERT INTO tasks (task_id, task_name) VALUES
         (1, 'ミルク'),
         (2, '夜泣き'),
         (3, 'おむつ交換'),
         (4, '歯磨き'),
         (5, 'お風呂'),
         (6, 'その他');


         CREATE TABLE konnnakotositetayo (
         konnnakotositetayo_id INT         NOT NULL AUTO_INCREMENT,
         family_id             VARCHAR(32) NOT NULL,
         couple_id             INT         NOT NULL,
         task_id               INT         NOT NULL,
         count                 INT         NOT NULL DEFAULT 1,
         memo                  VARCHAR(20)          DEFAULT NULL,
         display_order         INT         NOT NULL DEFAULT 0,
         is_read               INT         NOT NULL DEFAULT 0,
         recorded_date         DATE        NOT NULL,
         created_at            DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
         PRIMARY KEY (konnnakotositetayo_id),
         FOREIGN KEY (task_id) REFERENCES tasks (task_id)
       ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

  
        INSERT INTO todo (task_id, task_name) VALUES (22, 'その他');
