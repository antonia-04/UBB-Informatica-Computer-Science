-- SUBIECT -  GARAJ
CREATE DATABASE Garaj 
GO

USE Garaj

--TABELE
CREATE TABLE Garaj(
	idGaraj INT PRIMARY KEY,
	denumire VARCHAR(100),
	strada VARCHAR(100),
	numar VARCHAR(100),
	localitate VARCHAR(100)
);

CREATE TABLE TipGaraj(
	idTip INT PRIMARY KEY,
	idGaraj INT FOREIGN KEY REFERENCES Garaj(idGaraj),
	descriere VARCHAR(100)
);

CREATE TABLE Client(
	idC INT PRIMARY KEY,
	nume VARCHAR(100),
	prenume VARCHAR(100),
	gen VARCHAR(100),
	vechime  VARCHAR(100)
);

CREATE TABLE Unelte(
	idU INT PRIMARY KEY,
	idC INT FOREIGN KEY REFERENCES Client(idC),
	denumire  VARCHAR(100),
	pret INT,
	cantitate INT
);

CREATE TABLE Activitate(
	idA INT PRIMARY KEY IDENTITY,
	idC INT FOREIGN KEY REFERENCES Client(idC),
	idGaraj INT FOREIGN KEY REFERENCES Garaj(idGaraj),
	dataA DATE,
	beneficiu INT
);

INSERT INTO Garaj (idGaraj, denumire, strada, numar, localitate) VALUES
(1, 'Garaj Central', 'Strada Principala', '10', 'Bucuresti'),
(2, 'Garaj Nord', 'Strada Nordului', '20', 'Cluj-Napoca'),
(3, 'Garaj Sud', 'Strada Sudului', '15', 'Timisoara'),
(4, 'Garaj Est', 'Strada Estului', '5', 'Iasi'),
(5, 'Garaj Vest', 'Strada Vestului', '25', 'Oradea');

INSERT INTO TipGaraj (idTip, idGaraj, descriere) VALUES
(1, 1, 'Automate'),
(2, 2, 'Manuale'),
(3, 3, 'Hibrid'),
(4, 4, 'Automate'),
(5, 5, 'Manuale');

INSERT INTO Client (idC, nume, prenume, gen, vechime) VALUES
(1, 'Popescu', 'Ion', 'Masculin', '5 ani'),
(2, 'Ionescu', 'Maria', 'Feminin', '3 ani'),
(3, 'Vasilescu', 'Andrei', 'Masculin', '7 ani'),
(4, 'Georgescu', 'Elena', 'Feminin', '2 ani'),
(5, 'Dumitrescu', 'Mihai', 'Masculin', '6 ani');

INSERT INTO Unelte (idU, idC, denumire, pret, cantitate) VALUES
(1, 1, 'Ciocan', 50, 2),
(2, 2, 'Surubelnita', 25, 10),
(3, 3, 'Masina de gaurit', 300, 1),
(4, 4, 'Flex', 400, 1),
(5, 5, 'Cheie franceza', 100, 3);

INSERT INTO Activitate (idC, idGaraj, dataA, beneficiu) VALUES
(1, 1, '2024-01-05', 1500),
(2, 2, '2024-01-12', 2000),
(3, 3, '2024-01-20', 1800),
(4, 4, '2024-01-25', 1700),
(5, 5, '2024-01-30', 2200);


-- creati o procedura stocata care primeste un client, un garaj, dataA si beneficiu ( e o activitate) 
-- actualizeaza data daca exista, daca nu insereaza

CREATE OR ALTER PROCEDURE exercitiul2
    @id_client INT,
    @id_garaj INT,
    @data_a DATE,
    @beneficiu INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Activitate WHERE idC = @id_client AND idGaraj = @id_garaj)
    BEGIN
        UPDATE Activitate
        SET dataA = @data_a, beneficiu = @beneficiu
        WHERE idC = @id_client AND idGaraj = @id_garaj;

        PRINT 'Activitate actualizată cu succes.';
    END
    ELSE
    BEGIN
        INSERT INTO Activitate (idC, idGaraj, dataA, beneficiu)
        VALUES (@id_client, @id_garaj, @data_a, @beneficiu);

        PRINT 'Activitate adăugată cu succes.';
    END
END;
GO

EXEC exercitiul2 1, 1, '2025-01-01', 2000;

--VARIANTA 2

CREATE OR ALTER FUNCTION ValidareActivitate(
	@id_client INT,
	@id_garaj INT,
	@data_a DATE,
	@beneficiu INT
)
RETURNS INT AS 
BEGIN
	DECLARE @count INT;
	SELECT @count = COUNT(*) FROM Activitate WHERE idC = @id_client and idGaraj = @id_garaj;

	IF  @count > 0
		RETURN 0
	RETURN 1
END
GO

GO
CREATE OR ALTER PROCEDURE AddActivitate
	@id_client INT,
	@nume_cl VARCHAR(100),
	@prenume_cl VARCHAR(100),
	@gen_cl VARCHAR(100),
	@vechime_cl VARCHAR(100),
 
	@id_garaj INT,
	@denumire_g VARCHAR(100),
	@strada_G VARCHAR(100),
	@numar_g VARCHAR(100),
	@localitate_g VARCHAR(100),

	@data_a DATE,
	@beneficiu INT

AS BEGIN
	DECLARE @validation_status INT;
	SELECT @validation_status = dbo.ValidareActivitate(@id_client, @id_garaj, @data_a, @beneficiu);

	IF (@validation_status = 0)
	BEGIN
		UPDATE Activitate
			SET dataA = @data_a, beneficiu = @beneficiu
			WHERE idC = @id_client and idGaraj = @id_garaj
			SELECT * FROM Activitate
		PRINT(N'Activitate modificata cu succes');
	END

	IF (@validation_status = 1)
	BEGIN
		INSERT INTO Client(idC,nume,prenume,gen,vechime)
		VALUES(@id_client,@nume_cl,@prenume_cl,@gen_cl,@vechime_cl)
		SELECT * FROM Client

		INSERT INTO Garaj(idGaraj,denumire,strada,numar,localitate)
		VALUES(@id_garaj,@denumire_g,@strada_G,@numar_g,@localitate_g)
		SELECT * FROM Garaj

		INSERT INTO Activitate(idC,idGaraj,dataA,beneficiu)
		VALUES (@id_client, @id_garaj, @data_a, @beneficiu);
		SELECT * FROM Activitate
		PRINT(N'Activitate noua adaugata cu succes');
	END

END
GO

/*
Creati o functie care afiseaza numele clientilor ce au desfasurat activitate 
in cel putin n garaje, unde n>=1 este parametrul functiei
*/

CREATE OR ALTER FUNCTION B(@N INT)
RETURNS TABLE AS
	RETURN (
		SELECT c.nume AS Nume,
			   c.prenume AS Prenume,
			   COUNT(DISTINCT a.idGaraj) AS Numar
		FROM Client c INNER JOIN Activitate a on a.idC = c.idC
		WHERE
			( SELECT COUNT(DISTINCT a.idGaraj) FROM Activitate a WHERE a.idC = c.idC )>= @N
		GROUP BY
			c.nume,c.prenume
	);

SELECT * FROM B(1)