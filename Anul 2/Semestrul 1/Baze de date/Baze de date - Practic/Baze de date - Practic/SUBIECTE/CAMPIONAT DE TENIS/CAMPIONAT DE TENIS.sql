create database CampionatDeTenis
go
use CampionatDeTenis
go

create table Turnee(
id int primary key,
loc varchar(50),
data_inceput datetime,
data_final datetime);

create table Jucatori(
id int primary key,
nume varchar(50),
puncte int,
premii int);

create table Arene(
id int primary key,
nume varchar(50));



create table Partide(
id int primary key,
jucator1 int foreign key references Jucatori(id),
jucator2 int foreign key references Jucatori(id),
arena int foreign key references Arene(id),
turneu int foreign key references Turnee(id),
data_ora datetime,
puncte_juc1 int,
puncte_juc2 int,
premiu_juc1 int,
premiu_juc2 int,
castigator int foreign key references Jucatori(id));


insert into Turnee(id,loc, data_inceput, data_final) values (1,'oradea','2023-01-02', '2023-02-02')
insert into Jucatori(id,nume, puncte, premii) values (1,'a',15,2500),(2,'b',16,2000), (3,'c',17,2100), (4,'d',5,1500), (5,'e',10,1900)
insert into Arene(id,nume) values (1,'arena1'), (2,'arena2')
insert into Partide(id,jucator1, jucator2, arena, turneu, data_ora, puncte_juc1, puncte_juc2,premiu_juc1,premiu_juc2, castigator)
values (1,1,2,1,1,'2023-01-10 13:00', 20,17,1000,800,1),(2,3,4,2,1,'2023-01-10 13:00', 20,17,1000,800,3),
(3,1,3,1,1,'2023-01-10 17:00', 20,17,1000,800,1), (4,2,4,2,1,'2023-01-10 17:00', 20,17,1000,800,2)


create or alter procedure insertPartida
@j1 int,
@j2 int,
@arena int,
@turneu int,
@data_ora datetime,
@pj1 int,
@pj2 int,
@premiuj1 int,
@premiuj2 int,
@castigator int
as
begin
	declare @id int
	declare @exista int
	select top 1 @id=id from Partide order by id desc
	set @id=@id+1
	select @exista=id From Partide where 
	(@j1=jucator1 and @j2=jucator2 and @data_ora=data_ora) or (@j1=jucator1 and @j2=jucator2 and @turneu=turneu)
	if(@exista is null)
	begin
		insert into Partide values 
		(@id, @j1, @j2, @arena, @turneu, @data_ora, @pj1, @pj2, @premiuj1, @premiuj2, @castigator)
	end
end

exec insertPartida 1,2,1,1,'2023-01-10 13:00',20,120,2133,1232,2
exec insertPartida 1,4,1,1,'2023-01-10 13:00',20,120,2133,1232,2
select * from Partide



----------------- VARIANTA 1 CU ORDER BY IN VIEW CEEA CE E URAT
create or alter view listaJucatori
as
select j.nume , p.PartideCastigate from Jucatori j left join (select j.id, count(*) as PartideCastigate from Jucatori j inner join Partide p on p.castigator=j.id
group by j.id) p on p.id=j.id 
group by j.id, j.nume , p.PartideCastigate
order by p.PartideCastigate desc OFFSET 0 rows

select * from listaJucatori

-----------------VARIANTA 2 CU ORDER BY IN SELECT PE VIEW CEEA CE E MAI FRUMOS

create or alter view listaJucatori
as
select j.nume , p.PartideCastigate from Jucatori j left join (select j.id, count(*) as PartideCastigate from Jucatori j inner join Partide p on p.castigator=j.id
group by j.id) p on p.id=j.id 
group by j.id, j.nume , p.PartideCastigate
--order by p.PartideCastigate desc OFFSET 0 rows

select * from listaJucatori ORDER BY PartideCastigate desc
-----------------


create OR alter function Jucator(@id int)
returns varchar(60)
as
begin
	declare @puncte int
	declare @premii int
	set @puncte =0
	set @premii =0
	select @puncte=puncte, @premii=premii from Jucatori where id=@id
	select @puncte=@puncte+puncte_juc1,@premii=@premii+premiu_juc1  from Partide p inner join Jucatori j on j.id=p.jucator1
	where p.jucator1=@id
	select @puncte=@puncte+puncte_juc2 , @premii=@premii+premiu_juc2 from Partide p inner join Jucatori j on j.id=p.jucator2
	where p.jucator2=@id

	return (str(@puncte)+' '+str(@premii))
end

print dbo.Jucator(1)
select * from Jucatori where id =1
select * from Partide 

select premii from Jucatori where id=1
select premiu_juc1  from Partide p inner join Jucatori j on j.id=p.jucator1 where p.jucator1=1