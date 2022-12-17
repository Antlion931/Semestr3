DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS podwyżka(IN nazwa_zawodu varchar(50))
BEGIN
    START TRANSACTION;

    UPDATE Pracownicy SET pensja = 1.05*pensja WHERE zawod_id = (SELECT zawod_id FROM Zawody WHERE nazwa = nazwa_zawodu);

    IF (SELECT COUNT(*) FROM Pracownicy JOIN Zawody ON Zawody.zawod_id = Pracownicy.zawod_id WHERE nazwa = nazwa_zawodu && pensja > pensja_max) <> 0 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;

END$$
DELIMITER ;
