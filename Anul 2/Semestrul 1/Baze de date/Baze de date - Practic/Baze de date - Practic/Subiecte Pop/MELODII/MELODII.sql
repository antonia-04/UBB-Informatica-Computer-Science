CREATE DATABASE Studio
GO
USE Studio
GO

DROP TABLE Tipuri
DROP TABLE Melodii
DROP TABLE Adrese
DROP TABLE Interpreti
DROP TABLE MelodiiInterpreti

CREATE TABLE Tipuri(
id_tip INT PRIMARY KEY,
denumire VARCHAR(50) NOT NULL,
descriere VARCHAR(50) NOT NULL
)

CREATE TABLE Melodii(
id_melodie INT PRIMARY KEY,
denumire VARCHAR(50) NOT NULL,
an INT,
durata FLOAT,
id_tip INT FOREIGN KEY REFERENCES Tipuri(id_tip)
)

CREATE TABLE Adrese(
id_adresa INT PRIMARY KEY,
tara VARCHAR(50) NOT NULL,
localitate VARCHAR(50) NOT NULL,
strada VARCHAR(50),
nr INT,
cod_postal INT
)

CREATE TABLE Interpreti(
id_interpret INT PRIMARY KEY,
nume VARCHAR(50) NOT NULL,
prenume VARCHAR(50) NOT NULL,
gen VARCHAR(50) CHECK (gen IN ('Femeie', 'Barbat')),
data_nastere DATE,
id_adresa INT FOREIGN KEY REFERENCES Adrese(id_adresa)
)

CREATE TABLE MelodiiInterpreti(
id_melodie INT FOREIGN KEY REFERENCES Melodii(id_melodie),
id_interpret INT FOREIGN KEY REFERENCES Interpreti(id_interpret),
studio VARCHAR(50),
cost FLOAT,
CONSTRAINT pk_melodiiinterpreti PRIMARY KEY(id_melodie,id_interpret)
)

---INSERARI IN ATBELE

INSERT INTO Tipuri(id_tip, denumire, descriere) VALUES
(1, 'Pop', 'descriere pop'),
(2, 'Rock', 'descriere rock'),
(3, 'Latino', 'descriere latino'),
(4, 'Hip Hop', 'descriere hip hop')
SELECT * FROM Tipuri
DELETE FROM Tipuri
DELETE FROM Melodii
DELETE FROM MelodiiInterpreti
DELETE FROM Interpreti
DELETE FROM Adrese

INSERT INTO Melodii(id_melodie, denumire, an, durata, id_tip) VALUES
(1, 'M1', 2022, 3.45, 1),
(2, 'M2', 2021, 2.50, 2),
(3, 'M3', 2022, 3.00, 4),
(4, 'M4', 2020, 2.25, 1)
SELECT * FROM Melodii

INSERT INTO Adrese(id_adresa, tara, localitate, strada, nr, cod_postal) VALUES
(1,'Romania', 'L1', 'S1', 1, 111111),
(2,'Spania', 'L2', 'S2', 2, 222222),
(3,'Spania', 'L3', 'S3', 3, 333333)
SELECT * FROM Adrese

INSERT INTO Interpreti(id_interpret, nume, prenume, gen, data_nastere, id_adresa) VALUES
(1, 'Nume1', 'Prenume1', 'Femeie', '2002-12-12', 1),
(2, 'Nume2', 'Prenume2', 'Barbat', '2002-11-12', 3),
(3, 'Nume3', 'Prenume3', 'Femeie', '2000-12-12', 3)
SELECT * FROM Interpreti

INSERT INTO MelodiiInterpreti(id_melodie, id_interpret, studio, cost) VALUES
(1,3, 'Studio', 20340),
(1,2, 'Studio', 20340),
(2,3, 'Studioo', 8000),
(3,1, 'Studiooo', 50000.9),
(4,3, 'Studioooo', 25000)
SELECT * FROM MelodiiInterpreti

GO
CREATE OR ALTER PROCEDURE AdaugaSauActualizeazaMelodieInterpret
@id_melodie INT,
@id_interpret INT,
@studio VARCHAR(50),
@cost FLOAT
AS
BEGIN
IF NOT (EXISTS(SELECT * FROM MelodiiInterpreti WHERE id_melodie = @id_melodie AND id_interpret = @id_interpret))
BEGIN
INSERT INTO MelodiiInterpreti VALUES (@id_melodie, @id_interpret, @studio, @cost)
END
ELSE
BEGIN
UPDATE MelodiiInterpreti
SET studio = @studio, cost = @cost
WHERE id_melodie = @id_melodie AND id_interpret = @id_interpret
END
END

GO
SELECT * FROM MelodiiInterpreti
EXEC AdaugaSauActualizeazaMelodieInterpret 1, 1, 'StudioActualizat', 10000 ---> se actualizeaza
EXEC AdaugaSauActualizeazaMelodieInterpret 2, 1, 'Studio', 10000 ---> se adauga


GO
CREATE OR ALTER FUNCTION MelodiiCuCelPutinNInterpreti (@n INT)
RETURNS TABLE
AS
RETURN
SELECT M.denumire, COUNT(MI.id_interpret) AS nr_interpreti
FROM Melodii M INNER JOIN MelodiiInterpreti MI ON M.id_melodie = MI.id_melodie
GROUP BY M.denumire
HAVING COUNT(MI.id_interpret) >= @n

GO
SELECT * FROM MelodiiCuCelPutinNInterpreti(2)
SELECT * FROM MelodiiInterpreti