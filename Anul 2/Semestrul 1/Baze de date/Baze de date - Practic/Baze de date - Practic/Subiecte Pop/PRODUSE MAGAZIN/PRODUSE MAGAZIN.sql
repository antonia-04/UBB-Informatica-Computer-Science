CREATE DATABASE MagazineE
go

USE MagazineE
go

CREATE TABLE Locatii
(
	idL INT PRIMARY KEY IDENTITY,
	localitate VARCHAR(20),
	strada VARCHAR(20),
	numar VARCHAR(5),
	cod_postal VARCHAR(10)
)

CREATE TABLE Magazine
(
	idM INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(20),
	an_deschidere INT,
	idL INT FOREIGN KEY REFERENCES Locatii(idL)
)

CREATE TABLE Clienti
(
	idC INT PRIMARY KEY IDENTITY,
	nume VARCHAR(20),
	prenume VARCHAR(20),
	gen VARCHAR(5) CHECK (gen='M' OR gen='F' OR gen='OT'),
	data_nasterii DATE
)

CREATE TABLE ProduseFavorite
(
	idP INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(20),
	pret FLOAT,
	reducere INT CHECK(reducere>=0 AND reducere<=100),
	idC INT FOREIGN KEY REFERENCES Clienti(idC)
)

CREATE TABLE Achizitii
(
	idM INT FOREIGN KEY REFERENCES Magazine(idM),
	idC INT FOREIGN KEY REFERENCES Clienti(idC),
	data_achizitie DATETIME,
	pret_achitat FLOAT
	CONSTRAINT pk_Achizitii PRIMARY KEY (idM, idC)
)

INSERT INTO Locatii(localitate, strada, numar, cod_postal) VALUES
('Alba Iulia', 'Unirii', '24A', '510379'),
('Bucuresti', 'Calea Victoriei', '23D', '519345'),
('Cluj Napoca', 'Vaida Voevod', '13C', '541980')

SELECT * FROM Locatii
SELECT * FROM Magazine
SELECT * FROM Clienti
SELECT * FROM ProduseFavorite

INSERT INTO Magazine(denumire, an_deschidere, idL) VALUES
('MyAuchan', 2020,3), ('Carrefour', 2004, 2), ('Bershka', 2005, 2),
('Dacia', 2010, 1)

INSERT INTO Clienti(nume, prenume, gen, data_nasterii) VALUES
('Popescu', 'Lucia', 'F', '1996-04-12'), ('Enescu', 'Mihai', 'M', '2000-12-03'),
('Georgescu', 'Luca', 'M', '1995-06-25'), ('Hova', 'Maria', 'OT', '1978-01-09')

INSERT INTO ProduseFavorite(denumire, pret, reducere, idC) VALUES
('Pulover', 159.9, 10, 1), ('Salata', 15, 2, 2), ('Inghetata', 20.5, 10, 3)

go
CREATE OR ALTER PROCEDURE AdaugaAchizitie @idC INT, @idM INT, @dataC DATETIME, @pret FLOAT AS
BEGIN
	--DECLARE @idMG INT, @idCG INT;
	--SELECT @idMG= idM FROM Magazine WHERE idM=@idM;
	--SELECT @idCG= idC FROM Clienti WHERE idC=@idC;
	IF(NOT EXISTS(SELECT * FROM Achizitii WHERE idC=@idC AND idM=@idM))
	BEGIN
		INSERT INTO Achizitii(idC, idM, data_achizitie, pret_achitat) VALUES
		(@idC,@idM, @dataC, @pret)
	END
	ELSE 
	BEGIN
		UPDATE Achizitii SET data_achizitie=@dataC, pret_achitat=@pret WHERE
		idC=@idC AND idM=@idM
	END
END
go
SELECT * FROM Magazine
SELECT * FROM Clienti
SELECT * FROM ProduseFavorite
SELECT * FROM Achizitii

EXEC AdaugaAchizitie 2,1,'2023-01-06 17:00', 8.2
EXEC AdaugaAchizitie 1,3,'2022-12-04 13:35', 250.7
EXEC AdaugaAchizitie 3,4,'2023-01-02 14:55', 34.9

--nerulata
EXEC AdaugaAchizitie 4,1,'2022-11-17 10:30', 22.9

INSERT INTO ProduseFavorite (denumire, pret, reducere, idC) VALUES
('Fusta', 59.8, 20, 1), ('Pufuleti', 5, 0, 2), ('Ciocolata', 7.5, 10,2),('Pizza', 20.4, 3, 2), 
('Muesli', 15.9, 5, 3)


SELECT * FROM Clienti C LEFT JOIN ProduseFavorite P ON C.idC=P.idC

SELECT C.nume, C.prenume, count(P.idP) as NrProduseFavorite FROM Clienti C 
LEFT JOIN ProduseFavorite P ON C.idC=P.idC
GROUP BY C.idC, C.nume, C.prenume

go
CREATE OR ALTER VIEW vw_ClientiProduse AS
SELECT C.nume, C.prenume FROM Clienti C 
LEFT JOIN ProduseFavorite P ON C.idC=P.idC
GROUP BY C.idC, C.nume, C.prenume
HAVING COUNT(P.idP)<=3
go

SELECT * FROM vw_ClientiProduse


--------------
SELECT * FROM Magazine M INNER JOIN Achizitii A ON M.idM=A.idM
INNER JOIN Clienti C ON A.idC=C.idC
