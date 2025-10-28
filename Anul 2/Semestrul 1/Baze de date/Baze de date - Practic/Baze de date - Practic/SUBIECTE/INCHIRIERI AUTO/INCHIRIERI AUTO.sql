create database InchirieriAuto
go
use InchirieriAuto
go

create table Clienti(
id int primary key,
nume varchar(30),
prenume varchar(30));

create table Angajati(
id int primary key,
nume varchar(30),
prenume varchar(30));

create table Marci(
id int primary key,
denumire varchar(50));

create table Autovehicule(
id int primary key,
nr_mat varchar(12),
tip_motorizare varchar(30),
marca int foreign key references Marci(id));

create table Inchirieri(
id int primary key,
angajat int foreign key references Angajati(id),
client int foreign key references Clienti(id),
autovehicul int foreign key references Autovehicule(id),
data_ora_inchiriere datetime,
data_ora_returnare datetime);

insert into Clienti values
(1, 'Nume Client 1', 'Prenume Client 1'),
(2, 'Nume Client 2', 'Prenume Client 2'),
(3, 'Nume Client 3', 'Prenume Client 3');

insert into Angajati values
(1, 'Nume Angajat 1', 'Prenume Angajat 1'),
(2, 'Nume Angajat 2', 'Prenume Angajat 2'),
(3, 'Nume Angajat 3', 'Prenume Angajat 3');

insert into Marci values
(1, 'Porsche'),
(2, 'BMW'),
(3, 'Audi');

insert into Autovehicule values
(1, 'BV01CCC', 'benzina', 1),
(2, 'BV02CCC', 'motorina', 3),
(3, 'BV03CCC', 'benzina', 1),
(4, 'BV04CCC', 'benzina', 3),
(5, 'BV05CCC', 'motorina', 2),
(6, 'BV06CCC', 'gaz', 2);

insert into Inchirieri values
(1, 1, 1, 1, '2022-12-23 13:00:00', '2022-12-30 15:00:00');

create or alter procedure inserareUpdateInchirieri
@angajat int,
@client int,
@autovehicul int,
@data_inchiriere datetime,
@data_returnare datetime,
@tip bit
as
begin
	if(@tip='TRUE')
	begin
		declare @id int
		select top 1 @id=id from Inchirieri Order by id desc
		set @id=@id+1
		insert into Inchirieri values (@id,@angajat,@client,@autovehicul,@data_inchiriere,@data_returnare)
	end
	else
	begin
		update Inchirieri set data_ora_inchiriere=@data_inchiriere, data_ora_returnare=@data_returnare
		where client=@client and angajat=@angajat and autovehicul=@autovehicul
	end
end

exec inserareUpdateInchirieri 1, 2, 3, '2022-11-12 14:00:00', '2022-12-18 18:00:00', 'TRUE'
select* from Inchirieri
exec inserareUpdateInchirieri 1, 2, 5, '2023-01-12 14:00:00', '2023-01-18 18:00:00', 'TRUE'
exec inserareUpdateInchirieri 1, 3, 5, '2023-01-12 14:00:00', '2023-01-18 18:00:00', 'TRUE'
exec inserareUpdateInchirieri 1, 3, 6, '2023-01-12 14:00:00', '2023-01-18 18:00:00', 'TRUE'
exec inserareUpdateInchirieri 1, 1, 3, '2023-01-12 14:00:00', '2023-01-18 18:00:00', 'TRUE'

exec inserareUpdateInchirieri 2, 2, 5, '2023-01-12 14:00:00', '2023-01-18 18:00:00', 'TRUE'
exec inserareUpdateInchirieri 2, 3, 5, '2023-01-12 14:00:00', '2023-01-18 18:00:00', 'TRUE'
exec inserareUpdateInchirieri 2, 3, 6, '2023-01-12 14:00:00', '2023-01-18 18:00:00', 'TRUE'
exec inserareUpdateInchirieri 2, 1, 3, '2023-01-12 14:00:00', '2023-01-18 18:00:00', 'TRUE'

exec inserareUpdateInchirieri 2, 1, 3, '2023-01-18 14:00:00', '2023-01-19 18:00:00', 'TRUE'
exec inserareUpdateInchirieri 3, 2, 1, '2023-12-18 14:00:00', '2023-12-19 18:00:00', 'FALSE'

create or alter view listaAngajati
as
select a.nume, a.prenume, count(av.marca) as Cate from Angajati a 
inner join Inchirieri i on a.id=i.angajat
inner join Autovehicule av on av.id=i.autovehicul
inner join Marci m on av.marca=m.id
group by m.denumire,i.angajat, a.nume, a.prenume,i.data_ora_inchiriere
having m.denumire='BMW' and datepart(month,i.data_ora_inchiriere)=datepart(month, getdate())

select * from listaAngajati



---???????

create function listaMasiniLibere(@data_ora datetime)
returns table
as
return select av.nr_mat, m.denumire, av.tip_motorizare from Autovehicule av
inner join Marci m on m.id=av.marca
left join (select autovehicul from Inchirieri 
where data_ora_inchiriere<='2023-01-18 14:00:00' and data_ora_returnare>='2023-01-18 14:00:00'
group by autovehicul) i on i.autovehicul=av.id
where i.autovehicul is NULL

drop function listaMasiniLibere
select * from Inchirieri
select * from listaMasiniLibere('2023-01-18 14:00:00')

