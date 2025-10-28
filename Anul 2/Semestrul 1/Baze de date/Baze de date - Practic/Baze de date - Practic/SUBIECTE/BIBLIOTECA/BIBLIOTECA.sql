CREATE DATABASE Biblioteca
GO
USE Biblioteca
GO

CREATE TABLE Librarii(
	id INT PRIMARY KEY IDENTITY,
	nume VARCHAR(50),
	adresa VARCHAR(50)
)
GO

CREATE TABLE Domenii(
	id INT PRIMARY KEY IDENTITY,
	descriere VARCHAR(50)
)
GO

CREATE TABLE Autori(
	id INT PRIMARY KEY IDENTITY,
	nume varchar(50)
)
GO

CREATE TABLE Carti(
	id INT PRIMARY KEY IDENTITY,
	titlu VARCHAR(50),
	id_domeniu INT FOREIGN KEY REFERENCES Domenii(id)
)
GO

--imi trebuie CartiAutori si CartiLibrarii

CREATE TABLE CartiAutori(
	id_carte INT FOREIGN KEY REFERENCES Carti(id),
	id_autor INT FOREIGN KEY REFERENCES Autori(id),
	CONSTRAINT pk_CartiAutori PRIMARY KEY (id_carte, id_autor)
)
GO

CREATE TABLE CartiLibrarii(
	id_carte INT FOREIGN KEY REFERENCES Carti(id),
	id_librarie INT FOREIGN KEY REFERENCES Librarii(id),
	data_cumparare DATE,
	CONSTRAINT pk_CartiLibrarii PRIMARY KEY (id_carte, id_librarie)
)
GO

-------INSERARI---------
INSERT INTO Librarii(nume,adresa) VALUES
('nume1','adresa1'),
('nume2','adresa2'),
('nume3','adresa3'),
('nume4','adresa4'),
('nume5','adresa5')
GO
select * from Domenii
INSERT INTO Domenii(descriere) VALUES
('domeniu1'),
('domeniu2'),
('domeniu3'),
('domeniu4'),
('domeniu5')
GO

INSERT INTO Autori(nume) VALUES
('nume1'),
('nume2'),
('nume3'),
('nume4'),
('nume5')
GO

INSERT INTO Carti(titlu,id_domeniu) VALUES
('titlu1',1),
('titlu2',2),
('titlu3',3),
('titlu4',4),
('titlu5',5),
('titlu6',1),
('titlu7',2)
GO
select * from Carti

INSERT INTO CartiAutori(id_carte,id_autor) VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(2,4),
(2,5),
(3,3),
(4,5),
(6,1),
(6,2),
(7,5)
GO

select * from CartiAutori

INSERT INTO CartiLibrarii(id_carte,id_librarie,data_cumparare) VALUES
(1,1,'2022.12.03'),
(1,2,'2009.12.03'),
(1,3,'2013.12.03'),
(2,1,'2014.12.03'),
(3,1,'2015.12.03'),
(5,2,'2088.12.03'),
(4,2,'2021.12.03')
GO


--PROCEDURA DE ADAUGAT AUTOR LA CARTE
CREATE or ALTER PROCEDURE cerinta1 @id_carte INT, @nume_autor VARCHAR(50)
AS
BEGIN
	declare @id_autor int = 0

	IF(not exists (SELECT TOP 1 id FROM Autori WHERE nume = @nume_autor))
	BEGIN
		INSERT INTO Autori(nume) VALUES (@nume_autor)
		SET @id_autor = (SELECT TOP 1 id FROM Autori WHERE nume = @nume_autor)
		INSERT INTO CartiAutori(id_carte,id_autor) VALUES (@id_carte,@id_autor)
	END
	ELSE
	BEGIN
		SET @id_autor = (SELECT TOP 1 id FROM Autori WHERE nume = @nume_autor)
		IF(exists (SELECT * FROM CartiAutori WHERE id_carte = @id_carte and id_autor = @id_autor))
			print 'AUTORUL E DEJA ASOCIAT CARTII!!!'
		ELSE
			INSERT INTO CartiAutori(id_carte,id_autor) VALUES (@id_carte,@id_autor)
	END

END

exec cerinta1 1,'nume4'
select * from Autori
SELECT * FROM CartiAutori


---VIEW CU LIBRARII CARE AU AVUT MINIM 3 CARTI CUMPARATE DIN 2010 PANA IN PREZENT (SI NR DE CARTI)
CREATE OR ALTER VIEW cerinta2
AS
SELECT l.nume,COUNT(*) AS NR_CARTI_CUMPARATE FROM Librarii l inner join CartiLibrarii cl on l.id=cl.id_librarie WHERE cl.data_cumparare>='01.01.2010'
GROUP BY l.id,l.nume
HAVING COUNT(*)>=3

SELECT * FROM cerinta2

---FUNCTIE CU CARTI SCRISE DE UN NR N DE AUTORI, ORDONATE DUPA TITLU (LIBRARIA, ADRESA, TITLU, NR_AUTORI)
--nu are niciun sens??? o carte poate fi la mai multe librarii si o carte cu nr ala de autori ar putea sa nu fie la nicio librarie/ayaye afisez de mai multe ori librariile 
create or alter function cerinta3(@nr_autori int)
returns table
as
return select c.titlu, l.nume as nume_librarie, l.adresa as adresa_librarie, count(*) as nr_autori 
from Carti c inner join CartiAutori ca on c.id=ca.id_carte left join CartiLibrarii cl on c.id=cl.id_carte left join Librarii l on cl.id_librarie=l.id
group by c.id,c.titlu,l.nume,l.adresa
having count(*) = @nr_autori


select * from dbo.cerinta3(6)
select * from CartiAutori
---------------------------------------------