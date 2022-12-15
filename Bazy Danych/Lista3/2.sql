CREATE INDEX IF NOT EXISTS plec_imie_IDX USING BTREE ON Ludzie(plec, imie);
CREATE INDEX IF NOT EXISTS pensja_IDX USING BTREE ON Pracownicy(pensja);

SHOW INDEX FROM Ludzie;
SHOW INDEX FROM Pracownicy;

EXPLAIN SELECT * FROM Ludzie WHERE plec = 'K' && imie LIKE 'A%';

EXPLAIN SELECT * FROM Ludzie WHERE plec = 'K';

EXPLAIN SELECT * FROM Ludzie WHERE imie LIKE 'K%';

EXPLAIN SELECT * FROM Ludzie LEFT JOIN Pracownicy ON ID = osoba_id WHERE pensja < 2000 || pensja IS NULL;

EXPLAIN SELECT * FROM Ludzie JOIN Pracownicy ON ID = osoba_id
                     JOIN Zawody ON Zawody.zawod_id = Pracownicy.zawod_id
                     WHERE nazwa = 'informatyk' && pensja > 10000 && plec = 'M';
