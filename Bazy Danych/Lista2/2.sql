CREATE TABLE IF NOT EXISTS Producent (
    ID int AUTO_INCREMENT PRIMARY KEY,
    nazwa varchar(50),
    kraj varchar(20)
);

CREATE TABLE IF NOT EXISTS Matryca (
    ID int AUTO_INCREMENT PRIMARY KEY,
    przekatna decimal(4,2) NOT NULL,
    rozdzielczosc decimal(3,1) NOT NULL,
    typ varchar(10) NOT NULL,
    CHECK(przekatna >= 0),
    CHECK(rozdzielczosc >= 0)
);

ALTER TABLE Matryca AUTO_INCREMENT=100; 

CREATE TABLE IF NOT EXISTS Obiektyw (
    ID int AUTO_INCREMENT PRIMARY KEY,
    model varchar(30) NOT NULL,
    minPrzeslona float NOT NULL,
    maxPrzeslona float NOT NULL,
    CHECK(minprzeslona <= maxprzeslona),
    CHECK(maxprzeslona >= 0),
    CHECK(minprzeslona >= 0)
);

CREATE TABLE IF NOT EXISTS Aparat (
    model varchar(30) PRIMARY KEY,
    producent int,
    matryca int,
    obiektyw int,
    typ enum('kompaktowy', 'lustrzanka', 'profesjonalny', 'inny') NOT NULL,
    FOREIGN KEY (producent) REFERENCES Producent(ID),
    FOREIGN KEY (matryca) REFERENCES Matryca(ID),
    FOREIGN KEY (obiektyw) REFERENCES Obiektyw(ID)
);