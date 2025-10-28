CREATE DATABASE Competitii
GO
USE Competitii
GO

---------------------------------CREARE TABELE------------------------------------
CREATE TABLE Orase(
	id INT PRIMARY KEY IDENTITY,
	regiune VARCHAR(50),
	tara VARCHAR(50)
)
GO

CREATE TABLE Tipuri(
	id INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(50),
	descriere VARCHAR(50)
)
GO

CREATE TABLE Participanti(
	id INT PRIMARY KEY IDENTITY,
	nume VARCHAR(50),
	prenume VARCHAR(50),
	gen VARCHAR(50),
	data_nasterii DATE
)
GO

CREATE TABLE Competitii(
	id INT PRIMARY KEY IDENTITY,
	denumire VARCHAR(50),
	data_incepere DATE,
	data_finalizare DATE,
	id_tip INT FOREIGN KEY REFERENCES Tipuri(id),
	id_oras INT FOREIGN KEY REFERENCES Orase(id)
)
GO

CREATE TABLE CompetitiiParticipanti(
	id_competitie INT FOREIGN KEY REFERENCES Competitii(id),
	id_participant INT FOREIGN KEY REFERENCES Participanti(id),
	taxa INT,
	loc_obtinut INT,
	CONSTRAINT pk_CompetitiiParticipanti PRIMARY KEY(id_competitie, id_participant)
)
GO

----------------------------------------------------------------------------------------------
--------------------------------INSERARE VALORI-----------------------------------------------

INSERT INTO Orase(regiune,tara) VALUES
('Ardeal','Romania'),
('Banat','Romania'),
('Moldova','Romania'),
('Bucovina','Romania')
GO

INSERT INTO Tipuri(denumire,descriere) VALUES
('tip1','descriere1'),
('tip1','descriere2'),
('tip3','descriere3'),
('tip4','descriere4')
GO

INSERT INTO Participanti(nume,prenume,gen,data_nasterii) VALUES
('Bugnar','Andreea','feminin','2001-12-03'),
('Oltean','Anisia','feminin','2003-03-29'),
('Oarga','Claudia','feminin','2002-12-01'),
('Bidian','Alessia','feminin','2002-02-22')
GO

INSERT INTO Competitii(denumire,data_incepere,data_finalizare,id_oras,id_tip) VALUES
('competitie1','2022-11-03','2001-11-07',1,1),
('competitie2','2022-12-04','2001-12-08',2,2),
('competitie3','2023-10-05','2001-10-08',3,3),
('competitie4','2020-09-06','2001-09-09',4,4),
('competitie5','2021-08-07','2001-08-10',1,4)
GO

INSERT INTO CompetitiiParticipanti(id_competitie,id_participant,taxa,loc_obtinut) VALUES
(1,1,100,1),
(1,2,150,2),
(1,3,100,3),
(1,4,100,4),
(2,1,300,45),
(2,4,300,23),
(3,1,20,5),
(3,2,25,1),
(3,3,60,3),
(3,4,80,2)
GO

----------------------------------------------------------------------------------------------
--------------------------------UPDATE SAU INSERT---------------------------------------------

CREATE or ALTER PROCEDURE update_insert
@id_participant INT,
@id_competitie INT,
@taxa INT,
@loc_obtinut INT
AS
BEGIN
    IF (EXISTS (SELECT * FROM CompetitiiParticipanti 
            WHERE id_competitie = @id_competitie AND id_participant = @id_participant))
        UPDATE CompetitiiParticipanti SET taxa=@taxa, loc_obtinut=@loc_obtinut
        WHERE id_competitie = @id_competitie AND id_participant = @id_participant
    ELSE
        INSERT INTO CompetitiiParticipanti(id_competitie,id_participant,taxa,loc_obtinut) VALUES
        (@id_competitie,@id_participant,@taxa,@loc_obtinut)
END
GO


SELECT * FROM CompetitiiParticipanti
EXEC update_insert 1, 4, 100, 1

----------------------------------------------------------------------------------------------
--------------------DENUMIRILE COMPETITIILOR CU CEI MAI MULTI PARTICIPANTI--------------------

CREATE OR ALTER VIEW competitii_maxim_participanti AS
SELECT c.denumire FROM Competitii c INNER JOIN CompetitiiParticipanti cp on c.id=cp.id_competitie GROUP BY c.id,c.denumire
		HAVING COUNT(*)=
				(SELECT TOP 1 COUNT(*) AS NR_PARTICIPANTI FROM Competitii c inner join CompetitiiParticipanti cp on c.id=cp.id_competitie
					GROUP BY cp.id_competitie, c.denumire
					ORDER BY NR_PARTICIPANTI DESC)

---------------------------
SELECT TOP 1 COUNT(*) AS NR_PARTICIPANTI FROM Competitii c inner join CompetitiiParticipanti cp on c.id=cp.id_competitie
			GROUP BY cp.id_competitie, c.denumire
			ORDER BY NR_PARTICIPANTI DESC
---------------------------

SELECT * FROM competitii_maxim_participanti