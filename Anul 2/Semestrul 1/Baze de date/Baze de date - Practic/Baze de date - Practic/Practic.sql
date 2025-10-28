--- SUBIECT TEST

CREATE DATABASE CIOCOLATERIE
GO

USE CIOCOLATERIE

CREATE TABLE Copil(
	idCopil INT PRIMARY KEY IDENTITY,
	nume VARCHAR(50),
	prenume VARCHAR(50),
	gen VARCHAR(50),
	dataN DATE
);

CREATE TABLE Bomboane(
	idB INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(50),
	gramaj INT,
	rating INT,
	idCopil INT FOREIGN KEY REFERENCES Copil(idCopil)
);

CREATE TABLE Locatie(
	idL INT PRIMARY KEY IDENTITY,
	tara VARCHAR(50),
	orads VARCHAR(50),
	strada VARCHAR(50),
	numar INT
);

CREATE TABLE Concurs(
	idC INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(50),
	dataC DATETIME,
	idL INT FOREIGN KEY REFERENCES Locatie(idL)
);

CREATE TABLE Premiu(
	idPremiu INT PRIMARY KEY IDENTITY,
	idCopil INT FOREIGN KEY REFERENCES Copil(idCopil),
	idC INT FOREIGN KEY REFERENCES Concurs(idC),
	loc VARCHAR(50),
	premiu VARCHAR(50)
);



INSERT INTO Copil(nume, prenume, gen, dataN) VALUES
('Pop', 'Ion', 'M', '2012-01-05'),
('Mera', 'Paula', 'F', '2012-02-05'),
('Popescu', 'Zaharia', 'M', '2012-01-09'),
('Rusu', 'Delia', 'F', '2011-09-15')

SELECT * FROM Copil

INSERT INTO Bomboane(denumire, gramaj, rating, idCopil) VALUES
('bomboana1', 100, 5, 1),
('bomboana2', 100, 4, 2),
('bomboana3', 100, 5, 3),
('bomboana4', 100, 3, 4)

SELECT * FROM Bomboane
--orads = oras
INSERT INTO Locatie(tara, orads, strada, numar) VALUES
('Romania', 'Oradea', 'Lalelelor', 8),
('Romania', 'Cluj-Napoca', 'Narciselor', 9)

SELECT * FROM Locatie

INSERT INTO Concurs(denumire, dataC, idL) VALUES
('concurs1', '2025-01-05', 1),
('concurs2', '2025-01-06', 2)

SELECT * FROM Concurs

INSERT INTO Premiu(idCopil, idC, loc, premiu) VALUES
(1, 1, 'loc 1', 'carte'),
(2, 1, 'loc 2', 'carte'),
(3, 2, 'loc 1', 'carte'),
(4, 2, 'loc 2', 'carte')

SELECT * FROM Premiu

INSERT INTO Copil(nume, prenume, gen, dataN) VALUES
('Pop', 'Dan', 'M', '2012-01-05'),
('Popa', 'Mihai', 'M', '2012-01-06')

-- subpunct 2)

CREATE OR ALTER PROCEDURE exercitiul2
    @idCopil INT, --copil
    @idC INT,    --concurs
    @loc VARCHAR(50),
    @premiu VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Premiu WHERE idC = @idC AND idCopil = @idCopil)
    BEGIN
        UPDATE Premiu
        SET loc = @loc, premiu = @premiu
        WHERE idC = @idC AND idCopil = @idCopil;

        PRINT 'Premiu actualizat cu succes!:)';
    END
    ELSE
    BEGIN
        INSERT INTO Premiu(idCopil, idC, loc, premiu)
        VALUES (@idCopil, @idC, @loc, @premiu);

        PRINT 'Premiu adaugat cu succes!:)';
    END
END;
GO
--EXECUTAT
EXEC exercitiul2 5, 1, 'loc 3', 'minge';
EXEC exercitiul2 5, 1, 'loc 3', 'carte';

--PT EVALUARE:
EXEC exercitiul2 6, 2, 'loc 3', 'minge';
EXEC exercitiul2 6, 2, 'loc 3', 'carte';

SELECT * FROM Premiu


--subpunct 3
-- view care afiseaza denumirile bomb de ciocolata care au fost acordate copiilor in toate concursurile
CREATE OR ALTER VIEW exercitiul3
AS 
SELECT 
	b.denumire AS Bomboana,
	co.denumire AS Concurs
FROM
	Bomboane b INNER JOIN Copil c ON b.idCopil = c.idCopil 
	INNER JOIN Premiu p ON p.idC = C.idCopil 
	INNER JOIN Concurs co ON co.idC = p.idC
GO

INSERT INTO Bomboane(denumire, gramaj, rating, idCopil) VALUES
('bomboanaSingura', 100, 5, 5)

SELECT * FROM exercitiul3;

