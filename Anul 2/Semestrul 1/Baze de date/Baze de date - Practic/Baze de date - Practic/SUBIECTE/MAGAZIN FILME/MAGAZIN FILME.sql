create database MagazinFilme
go
use MagazinFilme
go



create table Regizori(
id int primary key,
nume varchar(30),
data_nasterii date);

create table Tari(
id int primary key,
nume varchar(50));

create table Tipuri(
id int primary key,
denumire varchar(50));

create table Actori(
id int primary key,
nume varchar (50),
tara int foreign key references Tari(id));

create table Clienti(
id int primary key,
nume varchar(50));

create table Filme(
id int  primary key,
titlu varchar(50),
durata int,
an int, 
pret float,
regizor int foreign key references Regizori(id));

create table ActoriFilme(
actor int foreign key references Actori(id),
film int foreign key references Filme(id),
constraint pk_ActoriFilme primary key (actor, film));

create table TipuriFilme(
tip int foreign key references Tipuri(id),
film int foreign key references Filme(id),
constraint pk_TipuriFilme primary key(tip,film));

create table Inchirieri(
client int foreign key references Clienti(id),
film int foreign key references Filme(id),
constraint ok_Inchirieri primary key (client, film),
data_inchiriere datetime,
data_returnare datetime);

insert into Tari values
(1, 'Romania'),
(2, 'USA');

insert into Regizori values
(1, 'Nume1', '1987-03-14'),
(2, 'Nume2', '1990-06-18');

insert into Tipuri values
(1, 'artistic'),
(2, 'documentar');

insert into Actori values
(1, 'Actor1', 1),
(2, 'Actor2', 2),
(3, 'Actor3',1);

insert into Clienti values
(1, 'Client1'),
(2, 'Client2');

insert into Filme values
(1,'Poveste x', 120, 2020, 15,1),
(2,'Poveste y', 90, 2012, 10,2),
(3,'titlu', 120, 2010, 15,1);

insert into Filme values
(4,'titlu4', 120, 2020, 15,1);

insert into Filme values
(5,'titlu5', 120, 2020, 15,1);

insert into Filme values
(6,'titlu6', 120, 2021, 34,1);
insert into Filme values
(7,'titlu7', 120, 2021, 34,1);

insert into ActoriFilme values
(1,2),
(1, 3),
(2, 1),
(2, 2),
(3,2),
(3,3);

insert into ActoriFilme values
(1,1),
(1, 4);

insert into TipuriFilme values
(1,1),
(1,2),
(2,2),
(2,3);

insert into Inchirieri values
(1,1,'2023-01-12 13:00:00', '2023-01-18 17:00:00'),
(1,2,'2023-01-12 13:00:00', '2023-01-18 17:00:00'),
(2,3,'2023-01-10 13:00:00', '2023-01-11 17:00:00'),
(2,1,'2023-01-10 13:00:00', '2023-01-11 17:00:00');


insert into Clienti values
(3, 'Nume3'),
(4,'Nume4');
insert into Inchirieri values
(1,6,'2023-01-12 13:00:00', '2023-01-18 17:00:00'),
(2,6,'2023-01-12 13:00:00', '2023-01-18 17:00:00');

insert into Inchirieri values
(1,7,'2023-01-12 13:00:00', '2023-01-18 17:00:00');

select * from Filme where titlu like '%Poveste%'

create or alter view Actori4Filme
as
select a.nume from Actori a inner join ActoriFilme af on af.actor=a.id
group by a.nume
having count(*)>3

select * from Actori4Filme


create or alter procedure FilmeNeinchiriate
as
begin
	select f.titlu,f.durata,f.an,f.pret,f.regizor from Filme f left join Inchirieri i 
	on i.film=f.id
	where i.film is NULL
end

exec FilmeNeinchiriate

create function CatiClienti()
returns int as
begin
	declare @cate int
	select @cate=count(*) from (select i.client from Inchirieri i inner join Filme f on f.id=i.film
	where f.pret>30 and an=2021
	Group by i.client) as Clienti
	return @cate
end

print dbo.CatiClienti()