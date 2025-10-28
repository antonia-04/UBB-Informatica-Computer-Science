--- SUBIECT 3 - Clinica
CREATE DATABASE Clinica
GO

USE Clinica
GO

CREATE TABLE Pacient(
	idPacient INT PRIMARY KEY IDENTITY,
	nume VARCHAR(50),
	prenume VARCHAR(50),
	adresa VARCHAR(80)
);

CREATE TABLE Specializare(
	idS INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(50)
);

CREATE TABLE Medic(
	idMedic INT PRIMARY KEY IDENTITY,
	nume VARCHAR(50),
	prenume VARCHAR(50),
	idS INT FOREIGN KEY REFERENCES Specializare(idS)
);

CREATE TABLE Diagnostic(
	idD INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(50),
	descriere VARCHAR(50)
);

CREATE TABLE Programare(
	idP INT PRIMARY KEY IDENTITY,
	idMedic INT FOREIGN KEY REFERENCES Medic(idMedic),
	idPacient INT FOREIGN KEY REFERENCES Pacient(idPacient),
	idD INT FOREIGN KEY REFERENCES Diagnostic(idD),
	dataProg DATETIME,
	observatii VARCHAR(50)
);


INSERT INTO Pacient (nume, prenume, adresa) VALUES
('Popescu', 'Andrei', 'Strada Mihai Eminescu, nr. 10'),
('Ionescu', 'Maria', 'Strada Alexandru Ioan Cuza, nr. 5'),
('Georgescu', 'Cristian', 'Strada Libertatii, nr. 12');

INSERT INTO Specializare (denumire) VALUES 
('Cardiologie'),
('Dermatologie'),
('Pediatrie');

INSERT INTO Medic (nume, prenume, idS) VALUES
('Popa', 'Ion', 1),  -- Cardiologie
('Dumitrescu', 'Elena', 2),  -- Dermatologie
('Vasilescu', 'Ana', 3);  -- Pediatrie

INSERT INTO Diagnostic (denumire, descriere) VALUES
('Hipertensiune', 'Tensiune arteriala crescuta'),
('Dermatita', 'Inflamatie a pielii'),
('Raceala', 'Infectie virala usoara');

INSERT INTO Programare (idMedic, idPacient, idD, dataProg, observatii) VALUES
(1, 1, 1, '2024-01-15 09:00:00', 'Monitorizare tensiune arteriala'),
(2, 2, 2,  '2024-01-15 10:00:00', 'Recomandare tratament dermatologic'),
(3, 3, 3, '2024-01-15 11:00:00', 'Odihna si hidratare');
GO


-- b) creati o procedura stocata care primeste un pacient, un medic, un diagnostic, observatiile si data si ora consultarii 
-- si adauga o noua programare in baza de date
-- in caz ca exista la medicul respectiv si data, se actualizeaza diagnosticul, observatiile si ora

CREATE OR ALTER PROCEDURE PROGRAMEAZA
	@idP INT, @idM INT, @diagnostic INT, @observatii VARCHAR(50), @dataC DATETIME
AS
BEGIN
	IF EXISTS( SELECT * FROM Programare pr WHERE @idP = pr.idPacient and @idM = pr.idMedic 
	   and CONVERT(DATE, dataProg) = CONVERT(DATE, @dataC))
	BEGIN 
		UPDATE Programare
			SET idD = @diagnostic, observatii = @observatii, dataProg = @dataC
			WHERE idPacient = @idP AND idMedic = @idM AND CONVERT(DATE, dataProg) = CONVERT(DATE, @dataC);
	END
	ELSE
	INSERT INTO Programare(idMedic, idPacient, idD, dataProg, observatii)
	VALUES (@idM, @idP, @diagnostic, @dataC, @observatii);
END;

SELECT * FROM Programare

EXEC PROGRAMEAZA @idP = 1, @idM = 1, @diagnostic = 1, @observatii = 'Consult initial', @dataC = '2024-02-01 09:00:00';
EXEC PROGRAMEAZA @idP = 1, @idM = 1, @diagnostic = 2, @observatii = 'Reevaluare', @dataC = '2024-02-01 08:00:00';

-- c) creati un view care afiseaza numele si prenumele medicilor care au avut un numar mai mare de 20 de consultatii in luna curenta
-- lista va fi ordonata alfaetic dupa numele si prenumele medicilor

CREATE OR ALTER VIEW exercitiul3
AS 
SELECT 
	m.nume AS Nume,
	m.prenume AS Prenume,
	COUNT(*) AS NumarProgramari
FROM
	Medic m INNER JOIN Programare pr ON m.idMedic = pr.idMedic
	WHERE MONTH(pr.dataProg) = 2 
	GROUP BY m.nume, m.prenume
	HAVING COUNT(*) > 20
GO

SELECT * FROM exercitiul3;

-- d) creati o functie care afiseaza medicii care au mai mult de o consultatie intr-o zi si la o ora data

CREATE OR ALTER PROCEDURE exercitiul4(@dataData DATETIME)
AS
BEGIN
    SELECT 
        m.nume, 
        m.prenume, 
        COUNT(pr.idP) AS NrConsultatii
    FROM Medic m
    INNER JOIN Programare pr ON pr.idMedic = m.idMedic
    WHERE CAST(pr.dataProg AS DATE) = CAST(@dataData AS DATE)
    GROUP BY m.nume, m.prenume
    HAVING COUNT(pr.idP) > 1;
END;
GO

SELECT * FROM dbo.exercitiul4('2024-01-15 09:00:00');
