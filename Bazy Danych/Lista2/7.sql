DELIMITER $$
CREATE FUNCTION  IF NOT EXISTS countMatryca(id int) RETURNS int
BEGIN
    DECLARE result int;
    SELECT count(*) INTO result FROM Aparat WHERE matryca = id;
    RETURN result;
END$$
DELIMITER ;