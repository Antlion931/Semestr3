DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS Generate()
BEGIN
    DECLARE oi int; 
    DECLARE op int; 
    SET oi = 1;
    a: WHILE oi <= 10 DO
        SET op = 1;
        b: WHILE op <= 10 DO
            INSERT INTO Aparat (model, producent, matryca, obiektyw, typ) VALUE (CONCAT('gen', oi, 'n', op), oi, 100, op, 'inny');
            SET op = op + 1;
        END WHILE b;
        SET oi = oi + 1;
    END WHILE a;

END$$
DELIMITER ;
