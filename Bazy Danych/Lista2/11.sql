ALTER TABLE Producent ADD COLUMN IF NOT EXISTS liczbaModeli int NOT NULL;

UPDATE Producent SET liczbaModeli = (SELECT COUNT(*) FROM Aparat WHERE producent = Producent.ID);

DROP TRIGGER IF EXISTS producentChecker;

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS producentChecker BEFORE INSERT ON Aparat
FOR EACH ROW
BEGIN
    IF 0 = (SELECT COUNT(*) FROM Producent WHERE ID = NEW.producent) THEN
        INSERT INTO Producent (ID, liczbaModeli) VALUE(NEW.producent, (SELECT COUNT(*) FROM Aparat WHERE producent = Producent.ID));
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS producentUpdateOnInsertAparat AFTER INSERT ON Aparat
FOR EACH ROW
BEGIN
    UPDATE Producent SET liczbaModeli = (SELECT COUNT(*) FROM Aparat WHERE producent = Producent.ID);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS producentUpdateOnDeleteAparat AFTER DELETE ON Aparat
FOR EACH ROW
BEGIN
    UPDATE Producent SET liczbaModeli = (SELECT COUNT(*) FROM Aparat WHERE producent = Producent.ID);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS producentUpdateOnUpdateAparat AFTER UPDATE ON Aparat
FOR EACH ROW
BEGIN
    UPDATE Producent SET liczbaModeli = (SELECT COUNT(*) FROM Aparat WHERE producent = Producent.ID);
END$$
DELIMITER ;