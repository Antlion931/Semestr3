CREATE VIEW IF NOT EXISTS ModeleKraje AS
SELECT model, kraj FROM Aparat 
JOIN Producent ON Producent.ID = producent;

SELECT * FROM ModeleKraje;

DELETE FROM Aparat
WHERE producent IN (SELECT ID FROM Producent WHERE kraj = 'China');

SELECT * FROM ModeleKraje;
