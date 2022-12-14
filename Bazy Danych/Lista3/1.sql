CREATE DATABASE IF NOT EXISTS `sekta`;
USE `sekta`;

CREATE TABLE IF NOT EXISTS Ludzie (
    ID int AUTO_INCREMENT PRIMARY KEY,
    PESEL char(11) NOT NULL,
    imie varchar(30) NOT NULL,
    nazwisko varchar(30) NOT NULL,
    data_urodzenia date NOT NULL,
    plec enum('K', 'M') NOT NULL,
    CONSTRAINT month_correct CHECK(
               (YEAR(data_urodzenia) BETWEEN 1800 AND 1899 && CAST(SUBSTRING(PESEL, 3, 2) AS INT) = MONTH(data_urodzenia) + 80)
            || (YEAR(data_urodzenia) BETWEEN 1900 AND 1999 && CAST(SUBSTRING(PESEL, 3, 2) AS INT) = MONTH(data_urodzenia))
            || (YEAR(data_urodzenia) BETWEEN 2000 AND 2099 && CAST(SUBSTRING(PESEL, 3, 2) AS INT) = MONTH(data_urodzenia) + 20)
            || (YEAR(data_urodzenia) BETWEEN 2100 AND 2199 && CAST(SUBSTRING(PESEL, 3, 2) AS INT) = MONTH(data_urodzenia) + 40)
            || (YEAR(data_urodzenia) BETWEEN 2200 AND 2299 && CAST(SUBSTRING(PESEL, 3, 2) AS INT) = MONTH(data_urodzenia) + 60)
        ),
    CONSTRAINT year_correct CHECK( CAST(SUBSTRING(PESEL, 1, 2) AS INT) = YEAR(data_urodzenia) % 100),
    CONSTRAINT day_correct CHECK( SUBSTRING(PESEL, 5, 2) = DAYOFMONTH(data_urodzenia)),
    CONSTRAINT sex_correct CHECK((SUBSTRING(PESEL, 10, 1) IN ('0', '2', '4', '6', '8') && plec = 'K') || (SUBSTRING(PESEL, 10, 1) IN ('1', '3', '5', '7', '9') && plec = 'M')),
    CONSTRAINT checksum_correct CHECK(
        (
            (CAST(SUBSTRING(PESEL, 1, 1) AS INT) * 1) % 10 +
            (CAST(SUBSTRING(PESEL, 2, 1) AS INT) * 3) % 10 +
            (CAST(SUBSTRING(PESEL, 3, 1) AS INT) * 7) % 10 +
            (CAST(SUBSTRING(PESEL, 4, 1) AS INT) * 9) % 10 +
            (CAST(SUBSTRING(PESEL, 5, 1) AS INT) * 1) % 10 +
            (CAST(SUBSTRING(PESEL, 6, 1) AS INT) * 3) % 10 +
            (CAST(SUBSTRING(PESEL, 7, 1) AS INT) * 7) % 10 +
            (CAST(SUBSTRING(PESEL, 8, 1) AS INT) * 9) % 10 +
            (CAST(SUBSTRING(PESEL, 9, 1) AS INT) * 1) % 10 +
            (CAST(SUBSTRING(PESEL, 10, 1) AS INT) * 3) % 10
        ) % 10 * -1 + 10 = (CAST(SUBSTRING(PESEL, 11, 1) AS INT))
    )
);

CREATE TABLE IF NOT EXISTS Zawody (
    zawod_id int AUTO_INCREMENT PRIMARY KEY,
    nazwa varchar(50) NOT NULL,
    pensja_min float NOT NULL,
    pensja_max float NOT NULL,
    CHECK(pensja_min >= 0.0),
    CHECK(pensja_max >= pensja_min)
);

CREATE TABLE IF NOT EXISTS Pracownicy (
    pensja float NOT NULL,
    osoba_id int NOT NULL,
    zawod_id int NOT NULL,
    FOREIGN KEY (osoba_id) REFERENCES Ludzie(ID),
    FOREIGN KEY (zawod_id) REFERENCES Zawody(zawod_id)
);

INSERT INTO Zawody (nazwa, pensja_min, pensja_max) VALUE ('polityk', 12000, 150000);
INSERT INTO Zawody (nazwa, pensja_min, pensja_max) VALUE ('nauczyciel', 3537, 6509);
INSERT INTO Zawody (nazwa, pensja_min, pensja_max) VALUE ('lekarz', 26652, 74400);
INSERT INTO Zawody (nazwa, pensja_min, pensja_max) VALUE ('informatyk', 16000, 24000);

INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('12292998196', 'Jo', 'Kohler', '2012-09-29', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('17241118814', 'Mallory', 'Volkman', '2017-04-11', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('21300927956', 'Cloyd', 'Ortiz', '2021-10-09', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('09250612667', 'Uriah', 'Hoppe', '2009-05-06', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('05241461872', 'Antwan', 'Stamm', '2005-04-14', 'M');

INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('70011356487', 'Agustin', 'Stehr', '1970-01-13', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('96111435954', 'Darien', 'Gottlieb', '1996-11-14', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('80040582458', 'Yasmin', 'Sawayn', '1980-04-05', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('86041241714', 'Jammie', 'Rutherford', '1986-04-12', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('84022466262', 'Golda', 'Thiel', '1984-02-24', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('85122045144', 'Josie', 'Towne', '1985-12-20', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('65112295182', 'Consuelo', 'Nienow', '1965-11-22', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('89061224882', 'Elyse', 'Miller', '1989-06-12', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('74072468871', 'Manley', 'Hartmann', '1974-07-24', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('91121731896', 'Theo', 'Morar', '1991-12-17', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('99080811316', 'Thora', 'Marquardt', '1999-08-08', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('83022496721', 'Sarina', 'Gottlieb', '1983-02-24', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('85121979493', 'Molly', 'Gerlach', '1985-12-19', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('96022846823', 'Vincenza', 'Ortiz', '1996-02-28', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('78071299364', 'Laurence', 'Kub', '1978-07-12', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('71030326822', 'Avis', 'Herzog', '1971-03-03', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('94121798953', 'Rowena', 'Farrell', '1994-12-17', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('87062879438', 'Kendra', 'Heathcote', '1987-06-28', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('74050936516', 'Rosanna', 'Harris', '1974-05-09', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('69012592666', 'Jarrett', 'Toy', '1969-01-25', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('97111297766', 'Jovan', 'Hickle', '1997-11-12', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('97111247129', 'Rosie', 'Reinger', '1997-11-12', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('69062991828', 'Eden', 'Zieme', '1969-06-29', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('98090579193', 'Hazle', 'Raynor', '1998-09-05', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('65012412148', 'Anastasia', 'Corkery', '1965-01-24', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('87051099179', 'Hayley', 'Cummings', '1987-05-10', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('76062233173', 'Winnifred', 'McDermott', '1976-06-22', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('66112276818', 'Tre', 'Hyatt', '1966-11-22', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('74062493324', 'Eugenia', 'Pfannerstill', '1974-06-24', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('67120236168', 'Katrine', 'Reichert', '1967-12-02', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('77080812827', 'Alford', 'Murray', '1977-08-08', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('84090369519', 'Vallie', 'Feest', '1984-09-03', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('77093077754', 'Rosendo', 'Fay', '1977-09-30', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('80050971965', 'Tierra', 'Durgan', '1980-05-09', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('66122485426', 'Jailyn', 'Kuhlman', '1966-12-24', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('93062637226', 'Tyrell', 'Braun', '1993-06-26', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('69111021533', 'Chaim', 'Kirlin', '1969-11-10', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('74021152839', 'Kiara', 'Schroeder', '1974-02-11', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('78032332569', 'Conor', 'Lakin', '1978-03-23', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('79072234442', 'Christopher', 'Mueller', '1979-07-22', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('96082048382', 'Maymie', 'Haag', '1996-08-20', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('77051476537', 'Bertram', 'Wunsch', '1977-05-14', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('94050481823', 'Trinity', 'Boehm', '1994-05-04', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('94080571691', 'Kitty', 'Shields', '1994-08-05', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('88102013869', 'Jon', 'Gleason', '1988-10-20', 'K');

INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('55121181648', 'Alana', 'Krajcik', '1955-12-11', 'K');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('49031167812', 'Gregory', 'Dach', '1949-03-11', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('52102047894', 'Jada', 'Luettgen', '1952-10-20', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('55020974772', 'Rosalyn', 'Howe', '1955-02-09', 'M');
INSERT INTO Ludzie (PESEL, imie, nazwisko, data_urodzenia, plec) VALUE ('50102477972', 'Reagan', 'Veum', '1950-10-24', 'M');

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS urzad_pracy()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE plecc enum('K', 'M');
  DECLARE idd int;
  DECLARE urodziny date;
  DECLARE random_id_zawod INT;
  DECLARE p_max, p_min float;
  DECLARE cur1 CURSOR FOR SELECT ID, data_urodzenia, plec FROM Ludzie;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    FETCH cur1 INTO idd, urodziny, plecc;
    IF done THEN
      LEAVE read_loop;
    END IF;

    IF DATE_ADD(urodziny, INTERVAl 18 YEAR) <= CURDATE() THEN 
        IF plecc = 'K' && DATE_ADD(urodziny, INTERVAl 60 YEAR) <= CURDATE() THEN
            SELECT zawod_id INTO random_id_zawod FROM Zawody WHERE nazwa <> 'lekarz' ORDER BY RAND() LIMIT 1;
        ELSEIF plecc = 'M' && DATE_ADD(urodziny, INTERVAL 65 YEAR) <= CURDATE() THEN
            SELECT zawod_id INTO random_id_zawod FROM Zawody WHERE nazwa <> 'lekarz' ORDER BY RAND() LIMIT 1;
        ELSE 
            SELECT zawod_id INTO random_id_zawod FROM Zawody ORDER BY RAND() LIMIT 1;
        END IF;

        SELECT pensja_min INTO p_min FROM Zawody WHERE zawod_id = random_id_zawod LIMIT 1;
        SELECT pensja_max INTO p_max FROM Zawody WHERE zawod_id = random_id_zawod LIMIT 1;

        INSERT INTO Pracownicy (pensja, osoba_id, zawod_id) VALUE ( FLOOR(RAND() * (p_max - p_min + 1) + p_min), idd, random_id_zawod);

    END IF;
    
  END LOOP;

  CLOSE cur1;
END$$
DELIMITER ;

CALL urzad_pracy();
