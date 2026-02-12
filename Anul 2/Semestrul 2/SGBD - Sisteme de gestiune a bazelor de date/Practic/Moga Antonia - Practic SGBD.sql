CREATE DATABASE Practic;
USE Practic
GO
--- SUBIECT 13

-- PARINTE
CREATE TABLE Muzeu(
	idMuzeu INT PRIMARY KEY IDENTITY(1,1),
	denumire nvarchar(80),
	tip nvarchar(80),
	an int,
	nrExp int
);
-- COPIL
CREATE TABLE Expozitie(
	idExpozitie INT PRIMARY KEY,
	denumireE nvarchar(80),
	descriere nvarchar(80),
	dataD nvarchar(80),
	dataI nvarchar(80),
	idMuzeu INT FOREIGN KEY REFERENCES Muzeu(idMuzeu)
);

DROP TABLE Muzeu;
DROP TABLE Expozitie;

SELECT * FROM Muzeu;
SELECT * FROM Expozitie;

INSERT INTO Muzeu (denumire, tip, an, nrExp) VALUES ('Muzeul National', 'Istorie', 1990, 5);
INSERT INTO Muzeu (denumire, tip, an, nrExp) VALUES ('Muzeul de Arta', 'Arta', 1985, 8);
INSERT INTO Muzeu (denumire, tip, an, nrExp) VALUES ('Muzeul Cluj-Napoca', 'Istorie', 1980, 9);
INSERT INTO Muzeu (denumire, tip, an, nrExp) VALUES ('Muzeul Cluj-Napoca', 'Arta', 1975, 8);

INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (1, 'Expozitie Pictura', 'Picturi celebre', '2024-05-01', '2024-06-01', 2);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (2, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 1);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (3, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 3);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (4, 'Expozitie Istorie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 3);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (5, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (6, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);


INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (7, 'Expozitie Pictura', 'Picturi celebre', '2024-05-01', '2024-06-01', 2);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (8, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 1);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (9, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 3);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (10, 'Expozitie Istorie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 3);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (11, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (12, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);

INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (13, 'Expozitie Pictura', 'Picturi celebre', '2024-05-01', '2024-06-01', 2);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (14, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 1);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (15, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 3);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (16, 'Expozitie Istorie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 3);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (17, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (18, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);

INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (19, 'Expozitie Pictura', 'Picturi celebre', '2024-05-01', '2024-06-01', 2);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (20, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 1);


INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (21, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (22, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);

INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (23, 'Expozitie Pictura', 'Picturi celebre', '2024-05-01', '2024-06-01', 2);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (24, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 1);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (25, 'Expozitie Istorie', 'Obiecte istorice', '2024-04-10', '2024-05-10', 3);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (26, 'Expozitie Istorie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 3);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (27, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);
INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (28, 'Expozitie Geografie', 'Obiecte celebre', '2024-04-10', '2024-05-10', 4);

INSERT INTO Expozitie (idExpozitie, denumireE, descriere, dataD, dataI, idMuzeu) 
VALUES (29, 'Expozitie Pictura', 'Picturi celebre', '2024-05-01', '2024-06-01', 2);


SELECT * FROM Muzeu;
SELECT * FROM Expozitie;


-- 3) selecteaza denumirea exp din muzeele din CJ si care au fost gazduite in 2024
-- REGEX 
SELECT e.denumireE FROM Expozitie e
	JOIN Muzeu m ON e.idMuzeu = m.idMuzeu WHERE m.denumire LIKE '%Cluj-Napoca%'
	AND (e.dataD LIKE '2024%' OR e.dataI LIKE '2024%')


-- 2) selecteaza denumirea muzeelor care au avut nr maxim de exp

--SELECT TOP 1 m.denumire, COUNT(e.idExpozitie) AS nrExpozitii FROM Muzeu m
--	LEFT JOIN Expozitie e ON m.idMuzeu = e.idMuzeu
--	GROUP BY m.denumire
--	ORDER BY COUNT(e.idExpozitie) DESC;

SELECT TOP 1 m.denumire, COUNT(e.idExpozitie) AS nrExpozitii FROM Muzeu m
	LEFT JOIN Expozitie e ON m.idMuzeu = e.idMuzeu
	GROUP BY m.denumire
	ORDER BY nrExpozitii DESC;

-- 4) creati un index pentru interogarile de mai sus -> aratati ca este folosit afisand planul de executie pt interogare

-- index coloana folosita pt filtrare si cautare
CREATE INDEX IX_Expozitie_idMuzeu ON Expozitie(idMuzeu);

CREATE INDEX IX_Expozitie_idMuzeu_dataD ON Expozitie(idMuzeu, dataD);



--- ASTA E IMBRICATA NU E BUNA
SELECT m.denumire, COUNT(e.idExpozitie) AS nrExpozitii FROM Muzeu m
	LEFT JOIN Expozitie e ON m.idMuzeu = e.idMuzeu
	GROUP BY m.denumire
	HAVING COUNT(e.idExpozitie) = (
		SELECT TOP 1 COUNT(e2.idExpozitie)
		FROM Muzeu m2
		LEFT JOIN Expozitie e2 ON m2.idMuzeu = e2.idMuzeu
		GROUP BY m2.denumire
		ORDER BY COUNT(e2.idExpozitie) DESC
	)