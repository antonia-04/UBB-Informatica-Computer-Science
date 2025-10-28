--- SUBIECT 1 - Gestiune Vanzari
CREATE DATABASE Vanzari
GO

USE Vanzari
GO

CREATE TABLE Client(
	idC INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(50),
	codF VARCHAR(15)
);

CREATE TABLE AgentVanzari(
	idA INT PRIMARY KEY IDENTITY,
	nume VARCHAR(50),
	prenume VARCHAR(50)
);

CREATE TABLE Produs(
	idP INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(80),
	um VARCHAR(50)
);

CREATE TABLE Factura(
	idF INT PRIMARY KEY IDENTITY,
	dataE DATETIME,
	idC INT FOREIGN KEY REFERENCES Client(idC),
	idA INT FOREIGN KEY REFERENCES AgentVanzari(idA)
);

CREATE TABLE Comanda(
	idComanda INT PRIMARY KEY IDENTITY,
	idF INT FOREIGN KEY REFERENCES Factura(idF),
	idP INT FOREIGN KEY REFERENCES Produs(idP),
	nrOrdine INT,
	pret INT,
	cantitate INT
);
DELETE Comanda
DROP TABLE Comanda

INSERT INTO Client (denumire, codF)
VALUES 
('Client A', '1234567890123'),
('Client B', '9876543210987'),
('Client C', '1122334455667');

INSERT INTO AgentVanzari (nume, prenume)
VALUES 
('Ion', 'Popescu'),
('Maria', 'Ionescu'),
('Andrei', 'Vasile');

INSERT INTO Produs (denumire, um)
VALUES 
('Produs 1', 'bucăți'),
('Produs 2', 'litri'),
('Produs 3', 'kg'),
('Produs 4', 'bucăți'),
('Produs 5', 'litri');

-- Factura 1
INSERT INTO Factura (dataE, idC, idA)
VALUES 
('2024-01-10', 1, 1),
-- Factura 2
('2024-01-15', 2, 2),
-- Factura 3
('2024-01-20', 3, 3);

-- Comenzi pentru Factura 1
INSERT INTO Comanda (idF, idP, nrOrdine, pret, cantitate)
VALUES 
(1, 1, 1, 50, 10), -- Produs 1
(1, 2, 2, 20, 5);  -- Produs 2

-- Comenzi pentru Factura 2
INSERT INTO Comanda (idF, idP, nrOrdine, pret, cantitate)
VALUES 
(2, 3, 1, 30, 3),  -- Produs 3
(2, 4, 2, 15, 8);  -- Produs 4

-- Comenzi pentru Factura 3
INSERT INTO Comanda (idF, idP, nrOrdine, pret, cantitate)
VALUES 
(3, 5, 1, 25, 6);  -- Produs 5

-- b) creati o procedura stocata care primeste o factura, un produs, nr de ordine, pret, cantitate si adauga noul produs facturii
-- daca exista se adauga un rand nou cu cantitatea negativa

CREATE OR ALTER PROCEDURE adaugare
	@idF INT, @idP INT, @nrOrdine INT, @pret INT, @cantitate INT
AS
BEGIN
	IF EXISTS( SELECT * FROM Comanda c WHERE c.idF = @idF AND c.idP = @idP AND c.nrOrdine = @nrOrdine)
		BEGIN 
			INSERT INTO Comanda(idF, idP, nrOrdine, pret, cantitate) VALUES
			(@idF, @idP, @nrOrdine, @pret, 0-@cantitate);
		END
	ELSE
		BEGIN 
			INSERT INTO Comanda(idF, idP, nrOrdine, pret, cantitate) VALUES
			(@idF, @idP, @nrOrdine, @pret, @cantitate);
		END
END;

SELECT * FROM Comanda

EXEC adaugare @idF = 1, @idP = 3, @nrOrdine = 3, @pret = 100, @cantitate = 5;


-- c) creati o vedere care afiseaza lista facturilor ce contin produsul Shaorma si a caror valoare este mai mare de 300 lei
-- lista va afisa pt fiecare factura: denumirea clientului, numarul facturii, data emiterii si valoarea totala

CREATE OR ALTER VIEW exercitiul3 AS
SELECT 
	f.idF AS NumarFactura,
	c.denumire AS Client,
	f.dataE AS DataEmiterii,
	SUM(co.pret * co.cantitate) AS ValoareTotala
FROM 
	Factura f
	INNER JOIN Client c ON f.idC = c.idC
	INNER JOIN Comanda co ON f.idF = co.idF
	INNER JOIN Produs p ON p.idP = co.idP
WHERE 
	p.denumire = 'Shaorma'
GROUP BY 
	c.denumire, f.idF, f.dataE
HAVING 
	SUM(co.pret * co.cantitate) > 300
GO

INSERT INTO Client (denumire, codF)
VALUES ('Client Shaorma', '5555555555555');

INSERT INTO AgentVanzari (nume, prenume)
VALUES ('Agent', 'Shaorma');

INSERT INTO Produs (denumire, um)
VALUES ('Shaorma', 'buc');

INSERT INTO Factura (dataE, idC, idA)
VALUES ('2024-02-05', 4, 4); -- Factura 4 (idF = 4)

INSERT INTO Comanda (idF, idP, nrOrdine, pret, cantitate)
VALUES 
(4, 6, 1, 50, 10), -- 500 lei total pentru Shaorma
(4, 1, 2, 20, 5);  -- alt produs pentru diversitate

SELECT * FROM exercitiul3;

-- d) creati o functie care afiseaza valoarea toatala a facturilor grupate pe lunile anului si pe agentiile de vanzare pt un anumit an,
-- ordonate crescator  in ordinea lunilor si a numelor agentilor
-- Coloanele Listei sunt: Luna, NumeAgent. PrenumeAgent, ValoareTotala

CREATE OR ALTER FUNCTION exercitiul4(@AN INT) 
RETURNS TABLE AS
RETURN (
	SELECT 
		DATENAME(MONTH, f.dataE) AS Luna,
        a.nume AS NumeAgent,
        a.prenume AS PrenumeAgent,
        SUM(c.pret * c.cantitate) AS ValoareTotala
	FROM 
		Factura f 
		INNER JOIN AgentVanzari a ON f.idA = a.idA 
		INNER JOIN Comanda c ON c.idF = f.idF
	WHERE YEAR(f.dataE) = @AN
	GROUP BY 
		DATENAME(MONTH	, f.dataE), MONTH(f.dataE), a.nume, a.prenume
	--ORDER BY MONTH(f.dataE), a.nume, a.prenume
);
SELECT * FROM exercitiul4(2024);
