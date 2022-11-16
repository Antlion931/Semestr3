DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS Generate()
BEGIN
    DECLARE i int; 
    DECLARE p int;
    DECLARE m int;
    DECLARE o int;

    SET i = 1;
    a: WHILE i <= 100 DO

        SELECT ID INTO p FROM Producent ORDER BY RAND() LIMIT 1;
        SELECT ID INTO m FROM Matryca ORDER BY RAND() LIMIT 1;
        SELECT ID INTO o FROM Obiektyw ORDER BY RAND() LIMIT 1;

        INSERT INTO Aparat (model, producent, matryca, obiektyw, typ) VALUE (CONCAT('gen', i), p, m, o, 'inny');
        SET i = i + 1;
    END WHILE a;

END$$
DELIMITER ;
