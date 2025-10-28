--- SUBIECT 4 - Administrare Politie
CREATE DATABASE Politie
GO

USE Politie
GO;

CREATE TABLE Sectoare(
	idSector INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(80)
);

CREATE TABLE Grade(
	idGrad INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(80)
);

CREATE TABLE Sectii(
	idSectie INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(80),
	adresa VARCHAR(80)
);

CREATE TABLE Politisti(
	idPolitist INT PRIMARY KEY IDENTITY,
	nume VARCHAR(50),
	prenume VARCHAR(50),
	idSectie INT FOREIGN KEY REFERENCES Sectii(idSectie),
	idGrad INT FOREIGN KEY REFERENCES Grade(idGrad)
);


CREATE TABLE Patrule(
	idPatrula INT PRIMARY KEY IDENTITY,
	idPolitist INT FOREIGN KEY REFERENCES Politisti(idPolitist),
	idSector INT FOREIGN KEY REFERENCES Sectoare(idSector),
	timpStart DATETIME,
	timpStop DATETIME
);

-- inserts

INSERT INTO Sectoare(denumire) VALUES
('sector 1'), ('sector 2'), ('sector 3'), ('sector 4');

SELECT * FROM Sectoare 

INSERT INTO Grade(denumire) VALUES
('ofiter'), ('agent'), ('subinspector');

INSERT INTO Sectii(denumire, adresa) VALUES
('sectia 1', 'Strada Constantin Noica'),
('sectia 2', 'Strada Lalelelor'),
('sectia 3', 'Strada Justitiei');

INSERT INTO Politisti(nume, prenume, idSectie, idGrad) VALUES
('Andrei', 'Popescu', 1, 1),
('Mihai', 'Ionescu', 1, 2),
('Maria', 'Zimnicean', 2, 3),
('Ana', 'Mihalache', 3, 2),
('Carmen', 'Mitrean', 2, 1);

SELECT * FROM Politisti

INSERT INTO Patrule(idPolitist, idSector, timpStart, timpStop) VALUES
(1, 1, '2024-02-10 00:00:00', '2024-02-10 08:00:00'),
(2, 2, '2024-02-11 00:00:00', '2024-02-11 08:00:00'),
(3, 3, '2024-02-12 00:00:00', '2024-02-12 08:00:00'),
(4, 4, '2024-02-13 00:00:00', '2024-02-13 08:00:00'),
(5, 1, '2024-02-14 00:00:00', '2024-02-14 08:00:00');

INSERT INTO Patrule(idPolitist, idSector, timpStart, timpStop) VALUES
(1, 1, '2024-01-10 00:00:00', '2024-01-10 08:00:00'),
(2, 2, '2024-01-11 00:00:00', '2024-01-11 08:00:00'),
(3, 3, '2024-01-12 00:00:00', '2024-01-12 08:00:00'),
(4, 4, '2024-01-13 00:00:00', '2024-01-13 08:00:00'),
(5, 1, '2024-01-14 00:00:00', '2024-01-14 08:00:00');

INSERT INTO Patrule(idPolitist, idSector, timpStart, timpStop) VALUES
(1, 1, '2024-01-10 00:00:00', '2024-01-10 08:00:00'),
(1, 1, '2024-01-10 05:00:00', '2024-01-10 13:00:00');

--b) procedura stocata care primeste un politist, o sectie, data si ora de intrare, data si ora de iesire
-- si le adauga in lista programarilor
-- daca programarea pt sectia, politistul si data respectiva exista dejaatunci se actualizeaza datele 

CREATE OR ALTER PROCEDURE PROGRAMEAZA
    @idPolitist INT,
    @idSectie INT,
    @idSector INT,
    @startTime DATETIME,
    @stopTime DATETIME
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Patrule p
        WHERE p.idPolitist = @idPolitist
          AND p.idSector = @idSector
    )
    BEGIN
        UPDATE Patrule
        SET timpStart = @startTime,
            timpStop = @stopTime
        WHERE idPolitist = @idPolitist
          AND idSector = @idSector;
    END
    ELSE
    BEGIN
        INSERT INTO Patrule (idPolitist, idSector, timpStart, timpStop)
        VALUES (@idPolitist, @idSector, @startTime, @stopTime);
    END
END;
GO
SELECT * FROM Patrule

EXEC PROGRAMEAZA @idPolitist = 1, @idSectie = 1, @idSector = 1, @startTime = '2024-02-11 00:00:00', @stopTime = '2024-02-11 08:00:00';

-- c) create o view care afiseaza o lista a politistilor, ordonati alfabetic dupa sectie si dupa numele politistului
--  care sa prezinte numarul total de ore de munca pentru fiecare politist pentru luna ianuarie a anului curent

CREATE OR ALTER VIEW exercitiu3 AS
SELECT 
	s.denumire AS Sectie,
	p.nume AS Nume,
	p.prenume AS Prenume, 
	SUM(DATEDIFF(HOUR, pa.timpStart, pa.timpStop)) AS TotalOreMunca
FROM
	Politisti p INNER JOIN Sectii s ON p.idSectie = s.idSectie
				INNER JOIN Patrule pa ON pa.idPolitist = p.idPolitist
				WHERE MONTH(pa.timpStart) = 1 AND YEAR(pa.timpStart) = 2024
	GROUP BY s.denumire, p.nume, p.prenume
	--ORDER BY s.denumire, p.nume, p.prenume;
GO
SELECT * FROM exercitiu3

-- d) creati o functie care afiseaza lista politisilor care au mai multe programari la o anumita ora si data

CREATE OR ALTER FUNCTION exercitiu4(@oraData DATETIME)
RETURNS TABLE AS
RETURN (
	SELECT p.idPolitist, p.nume, p.prenume, COUNT(pa.idPatrula) AS NrPatrule
	FROM Politisti p INNER JOIN Patrule pa ON p.idPolitist = pa.idPolitist
	WHERE @oraData BETWEEN pa.timpStart AND pa.timpStop
	GROUP BY p.idPolitist, p.nume, p.prenume 
	HAVING COUNT(pa.idPatrula) > 1
);
GO

SELECT * FROM exercitiu4('2024-01-10 05:00:00');
SELECT * FROM Patrule