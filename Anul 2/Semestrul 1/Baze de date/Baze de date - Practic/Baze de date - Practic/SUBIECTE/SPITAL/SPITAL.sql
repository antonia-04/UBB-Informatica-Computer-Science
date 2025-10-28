--SPITAL
CREATE DATABASE Spital
GO
 
USE Spital
GO

CREATE TABLE Departamente(
	id_departament int primary key,
	nume varchar(50),
	non_stop bit,
)

CREATE TABLE Doctori(
	id_doctor int primary key,
	nume varchar(50),
	data_nasterii date,
	id_departament int foreign key references Departamente(id_departament)
)

CREATE TABLE Pacienti(
	id_pacient int primary key,
	nume varchar(50),
	data_nasterii date
)

CREATE TABLE DoctoriPacienti(
	id_doctor int foreign key references Doctori(id_doctor),
	id_pacient int foreign key references Pacienti(id_pacient),
	PRIMARY KEY(id_doctor, id_pacient)
)

CREATE TABLE Boli(
	id_boala int primary key,
	denumire varchar(100),
)

CREATE TABLE BoliPacienti(
	id_boala int foreign key references Boli(id_boala),
	id_pacient int foreign key references Pacienti(id_pacient)
)

CREATE TABLE Tratamente(
	id_tratament int primary key,
	denumire varchar(60),
)

CREATE TABLE BoliTratamente(
	id_boala int foreign key references Boli(id_boala),
	id_tratament int foreign key references Tratamente(id_tratament),
	primary key(id_boala, id_tratament)
)

--inserez valori
insert into Departamente(id_departament,nume,non_stop) values
(1,'pediatrie',1),
(2,'oncologie',0),
(3,'diabet',1),
(4,'si aici e pediatrie',0)
GO
select * from Departamente

insert into Boli(id_boala,denumire) values
(1,'diabet'),
(2,'cancer'),
(3,'miopie'),
(4,'insuficienta renala')

insert into Pacienti(id_pacient,nume,data_nasterii) values
(1,'Ana','03.12.2001'),
(2,'Bianca','02.02.2002'),
(3,'Catalin','06.12.2002'),
(4,'Diana','09.10.2008'),
(5,'Emilian','10.05.2000'),
(6,'Florina','02.06.2003')

insert into BoliPacienti(id_boala,id_pacient) values
(1,1),
(1,2),
(1,3),
(1,4),
(3,1),
(3,2),
(2,5),
(2,6)

insert into BoliPacienti(id_boala,id_pacient) values
(4,1),
(4,2),
(4,3),
(4,4)

insert into BoliPacienti(id_boala,id_pacient) values
(4,5),
(4,6)

select * from BoliPacienti

--INTEROGARE DEPARTAMENTE CARE CONTIN "pediatrie"
SELECT * FROM Departamente WHERE nume LIKE '%pediatrie%'

--FUNCTIE PT CATE BOLI DE CARE SUFERA MAI MULT DE 3 PACIENTI EXISTA
SELECT COUNT(*) FROM
(
	SELECT id_boala
	FROM BoliPacienti
	GROUP BY id_boala
	HAVING count(*) > 3;
) t

CREATE OR ALTER FUNCTION cerinta1 ()
RETURNS int
AS
BEGIN 

	DECLARE @nr INT
	SELECT @nr=COUNT(*) FROM (SELECT id_boala FROM BoliPacienti GROUP BY id_boala HAVING count(*)>3) t
	RETURN @nr

END;
go


--VIEW PT TRATAMENTE CARE INCEP CU A SI SUNT FOLOSITE PT MAI MULT DE 2 BOLI
CREATE VIEW cerinta2 AS
	SELECT BT.id_tratament
	FROM Tratamente T INNER JOIN BoliTratamente BT ON T.id_tratament = BT.id_tratament
	WHERE denumire LIKE 'A%'
	GROUP BY BT.id_tratament
	HAVING COUNT(*) > 2;
GO

insert into Tratamente(id_tratament,denumire) values
(1,'acesta'),
(2,'celalalt'),
(3,'astalalt'),
(4,'aaaaa'),
(5,'nu1'),
(6,'nu2'),
(7,'nu3')

insert into BoliTratamente(id_boala,id_tratament) values
(1,1),
(1,2),
(1,3),
(2,1),
(3,1),
(2,2),
(3,2)

insert into BoliTratamente(id_boala,id_tratament) values
(2,3),
(3,3),
(4,3)

select * from cerinta2

--VIEW PT DEPARTAMENTE NON STOP CAREA AU MAI MULT DE 3 DOCTORI ASIGNATI

insert into Doctori(id_doctor,nume,data_nasterii,id_departament) values
(1,'Gigel1','12.03.2004',1),
(2,'Gigel2','12.03.2004',1),
(3,'Gigel3','12.03.2004',1),
(4,'Gigel4','12.03.2004',1),
(5,'Gigel5','12.03.2004',2),
(6,'Gigel6','12.03.2004',2),
(7,'Gigel7','12.03.2004',2),
(8,'Gigel8','12.03.2004',2),
(9,'Gigel9','12.03.2004',3),
(10,'Gigel10','12.03.2004',3),
(11,'Gigel11','12.03.2004',3),
(12,'Gigel12','12.03.2004',3)

CREATE OR ALTER VIEW cerinta3 AS
	SELECT D2.id_departament AS ID_DEPARTAMENT
	FROM Doctori D1 INNER JOIN Departamente D2 ON D1.id_departament = D2.id_departament
	WHERE non_stop=1
	GROUP BY D2.id_departament
	HAVING COUNT(*) > 3;
GO

select * from cerinta3


