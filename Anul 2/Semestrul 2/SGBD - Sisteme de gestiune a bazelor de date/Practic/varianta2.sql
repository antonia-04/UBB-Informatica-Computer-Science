CREATE DATABASE Concurs
USE Concurs

CREATE TABLE TipPremiu (
    id INT PRIMARY KEY IDENTITY(1,1),
    nume NVARCHAR(100) NOT NULL,
    anual BIT NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('activ', 'inactiv')) NOT NULL,
    nrMaximCastigatoriPeAn INT NOT NULL
);

CREATE TABLE Premiu (
    id INT PRIMARY KEY IDENTITY(1,1),
    idTipPremiu INT FOREIGN KEY REFERENCES TipPremiu(id),
    nume NVARCHAR(100) NOT NULL,
    sponsor NVARCHAR(100),
    an INT NOT NULL,
    numeCastigator NVARCHAR(100),
    varsta INT NOT NULL
);


INSERT INTO TipPremiu (nume, anual, status, nrMaximCastigatoriPeAn)
VALUES 
('Premiul Excelentei', 1, 'activ', 3),
('Premiul Inovatiei', 1, 'activ', 2),
('Premiul Special', 0, 'inactiv', 1);

INSERT INTO Premiu (idTipPremiu, nume, sponsor, an, numeCastigator, varsta)
VALUES
(1, 'Premiul Excelentei 2023', 'Microsoft', 2023, 'Ana Popescu', 17),
(1, 'Premiul Excelentei 2023', 'Microsoft', 2023, 'Ion Ionescu', 16),
(1, 'Premiul Excelentei 2023', 'Microsoft', 2023, 'Maria Georgescu', 15),
(2, 'Premiul Inovatiei 2023', 'Google', 2023, 'George Vlad', 19),
(2, 'Premiul Inovatiei 2024', 'Google', 2024, 'Alina Radu', 18),
(3, 'Premiul Special 2021', 'Apple', 2021, 'Elena Dinu', 17);

SELECT * FROM Premiu
SELECT * FROM TipPremiu


-- scrieti un sql care returneaza toate tipurile de premii pentru care exista minim 3 castigatori
SELECT tp.id, tp.nume, COUNT(p.id) AS nrCastigatori
FROM TipPremiu tp
JOIN Premiu p ON tp.id = p.idTipPremiu
GROUP BY tp.id, tp.nume
HAVING COUNT(p.id) >= 3;

---  scrieti un sql care returneaza varsta medie a castigatorilor sub varsta de 18 ani
SELECT AVG(CAST(varsta AS FLOAT)) AS varsta_medie_sub_18
FROM Premiu
WHERE varsta < 18;


CREATE INDEX idx_premiu_idTipPremiu ON Premiu(idTipPremiu);
