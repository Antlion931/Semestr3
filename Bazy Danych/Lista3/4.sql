SET @sql := 'SELECT COUNT(*) FROM Pracownicy JOIN Ludzie ON ID = osoba_id JOIN Zawody ON Zawody.zawod_id = Pracownicy.zawod_id WHERE plec = ''K'' && nazwa = ?';

PREPARE pracownice FROM @sql;

EXECUTE pracownice USING 'informatyk';