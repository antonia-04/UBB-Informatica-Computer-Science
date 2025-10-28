CREATE DATABASE Politie
GO

USE Politie
GO

CREATE TABLE Sectii(
	id_sectie int primary key,
	denumire varchar(50),
	adresa varchar(50)
)

CREATE TABLE Sectoare(
	id_sector int primary key,
	denumire varchar(50)
)

CREATE TABLE Grade(
	id_grad int primary key,
	denumire varchar(50)
)

CREATE TABLE Politisti(
	id_politist int primary key,
	nume varchar(50),
	id_sectie int foreign key references Sectii(id_sectie),
	id_grad int foreign key references Grade(id_grad)
)

CREATE TABLE Programari(
	id_politist int foreign key references Politisti(id_politist),
	id_sector int foreign key references Sectoare(id_sector),
	PRIMARY KEY(id_politist, id_sector),
	ora_intrare DATETIME,
	ora_iesire DATETIME
)


--PROCEDURA CE ADAUGA (SAU DA UPDATE) PROGRAMARE

create or alter procedure cerinta1
@id_politist varchar(50),
@id_sector varchar(50),
@ora_intrare datetime,
@ora_iesire datetime
as
begin
    if (exists (select * from Programari 
            where id_politist = @id_politist and id_sector = @id_sector))
        update Programari set ora_intrare=@ora_intrare, ora_iesire=@ora_iesire
        where id_politist = @id_politist and id_sector = @id_sector
    else
        insert into Programari(id_politist, id_sector, ora_intrare, ora_iesire) values
        (@id_politist, @id_sector, @ora_intrare, @ora_iesire)
end
go
 
insert into Sectii(id_sectie,denumire,adresa) values
(1,'nr1','asta1'),
(2,'nr2','asta2'),
(3,'nr3','asta3'),
(4,'nr4','asta4'),
(5,'nr5','asta5')

select * from Sectii

insert into Grade(id_grad,denumire) values
(1,'boss'),
(2,'politist simplu'),
(3,'politist corupt'),
(4,'politist cu bani'),
(5,'detectiv')

insert into Politisti(id_politist,nume,id_sectie,id_grad) values
(1,'Ion1',1,1),
(2,'Ion2',1,2),
(3,'Ion3',1,3),
(4,'Ion4',2,4),
(5,'Ion5',3,5)

insert into Politisti(id_politist,nume,id_sectie,id_grad) values
(6,'Ion0',1,5)

insert into Politisti(id_politist,nume,id_sectie,id_grad) values
(7,'Ion7',3,5)

insert into Sectoare(id_sector,denumire) values
(1,'sector1'),
(2,'sector2'),
(3,'sector3'),
(4,'sector4'),
(5,'sector5')
 
exec cerinta1 1, 1, '2022-05-11T10:40:58', '2022-05-11T18:30:58'
exec cerinta1 1, 2, '2022-05-11T10:40:58', '2022-05-11T18:30:58'
exec cerinta1 2, 3, '2022-06-11T18:40:58', '2022-06-11T00:30:58'
select * from Programari

--VIEW CU POLITISTI ALFABETIC DUPA SECTIE SI NUME CU NR ORE LUCRATE

create or alter view cerinta2
as 
select p.id_sectie, p.Nume, ore.NR_ORE_LUCRATE
from Politisti p left join (select p1.id_politist, 8*count(*) as NR_ORE_LUCRATE from Politisti p1 inner join Programari p2 on p1.id_politist=p2.id_politist
group by p1.id_politist) ore on p.id_politist=ore.id_politist 
group by p.id_sectie, p.Nume, ore.NR_ORE_LUCRATE
ORDER BY p.id_sectie, p.Nume ASC
OFFSET 0 ROWS
go

SELECT * FROM cerinta2

----------------------------------------------------
select p.id_sectie, p.Nume, ore.NR_ORE_LUCRATE
from Politisti p left join (select p1.id_politist, 8*count(*) as NR_ORE_LUCRATE from Politisti p1 inner join Programari p2 on p1.id_politist=p2.id_politist
group by p1.id_politist) ore on p.id_politist=ore.id_politist 
group by p.id_sectie, p.Nume, ore.NR_ORE_LUCRATE
ORDER BY p.id_sectie, p.Nume ASC

select p1.id_politist, 8*count(*) as NR_ORE_LUCRATE from Politisti p1 inner join Programari p2 on p1.id_politist=p2.id_politist
group by p1.id_politist
----------------------------------------------------


--FUNCTIE PT POLITISTI CU MAI MULT DE O PROGRAMARE LA O ANUMITA ORA SI DATA (VARIANTA 1 -ORICE ORA, CAUT PRINTRE TOATE
create OR alter function cerinta3_1()
returns table
as

return
select p1.id_politist from Politisti p1 inner join Programari p2 on p1.id_politist=p2.id_politist
group by p1.id_politist,p2.ora_intrare
having count (*)>1


select * from dbo.cerinta3_1()

----------------------------------------------------
select p1.id_politist from Politisti p1 inner join Programari p2 on p1.id_politist=p2.id_politist
group by p1.id_politist,p2.ora_intrare
having count (*)>1
----------------------------------------------------

--VARIANTA 2, DACA TREBE EU SA DAU DATA SI ORA
create or alter function cerinta3_2(@ora_intrare datetime)
returns table
as

return 
select p1.id_politist from Politisti p1 inner join Programari p2 on p1.id_politist=p2.id_politist
where p2.ora_intrare=@ora_intrare
group by p1.id_politist
having count(*) > 1


select * from dbo.cerinta3_2('2022-06-11T10:40:58')