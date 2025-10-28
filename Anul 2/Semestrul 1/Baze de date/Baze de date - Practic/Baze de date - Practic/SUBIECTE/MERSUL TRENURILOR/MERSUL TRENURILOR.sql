CREATE DATABASE MersulTrenurilor
GO
USE MersulTrenurilor
GO
CREATE TABLE Tipuri
(
    Id_Tip INT PRIMARY KEY IDENTITY,
    Descriere VARCHAR(50)
)
GO

CREATE TABLE Trenuri
(
    Id_Tren INT PRIMARY KEY IDENTITY,
    Nume VARCHAR(50),
    Id_Tip INT FOREIGN KEY REFERENCES Tipuri(Id_Tip)
)
GO

CREATE TABLE Rute
(
    Id_Ruta INT PRIMARY KEY IDENTITY,
    Nume VARCHAR(50),
    Id_Tren INT FOREIGN KEY REFERENCES Trenuri(Id_Tren)
)
GO

CREATE TABLE Statii
(
    Id_Statie INT PRIMARY KEY IDENTITY,
    Nume VARCHAR(50)
)
GO

CREATE TABLE RuteStatii
(
    Id_Ruta INT FOREIGN KEY REFERENCES Rute(Id_Ruta),
    Id_Statie INT FOREIGN KEY REFERENCES Statii(Id_Statie),
    Ora_Sosirii TIME,
    Ora_Plecarii TIME,
    CONSTRAINT pk_RuteStatii PRIMARY KEY(Id_Ruta, Id_Statie)
)
GO


insert into Tipuri(descriere) values
('de marfa'),
('personal'),
('cfr'),
('tfc'),
('inter regio')
GO
 
select * from Tipuri
GO
 
insert into Trenuri(nume, Id_Tip) values
('Thomas', 1),
('Edison', 2),
('George', 3),
('Funnyrau', 2),
('Bratucu', 1),
('Cataciuciu', 1),
('Emicici', 2),
('Ioanana', 3),
('Mamarius', 2),
('Jan', 1)
GO
 
select * from Trenuri
GO
 
insert into Rute(nume, Id_Tren) values
('cluj-arad', 10),
('cluj-disneyland', 4),
('craiova-cracovia', 9),
('paris-micul-paris', 8),
('arad-brasov', 10),
('toma-city', 1),
('cluj-oradea', 8)
GO
 
select * from Rute
GO
 
insert into Statii(nume) values
('alesd'),
('oradea'),
('razboieni'),
('bratca'),
('campia turzii'),
('ohaba de sub piatra'),
('bucuresti nord'),
('cluj nord'),
('suncuius'),
('vaslui')
GO
 
select * from Rute
select * from Statii
GO
 
insert into RuteStatii(Id_Ruta, Id_Statie, Ora_Sosirii, Ora_Plecarii) values
(1, 1, '15:13', '15:14'),
(2, 2, '12:13', '12:30'),
(3, 3, '11:13', '11:20'),
(3, 4, '11:40', '11:50'),
(4, 4, '15:13', '15:20'),
(1, 5, '10:13', '10:15'),
(2, 3, '13:13', '13:15')
go

insert into RuteStatii values
(7,4,'11:40', '11:50');
GO

insert into RuteStatii values
(6,3,'11:40', '11:50');
GO


--UPDATE DACA EXISTA SAU INSERT ALTFEL-----------------------------------------------

create or alter procedure upsert_station
@numeRuta varchar(50),
@numeStatie varchar(50),
@oraSosire time,
@oraPlecare time
as
begin
    declare @idRuta int=0
    declare @idStatie int=0
 
    set @idRuta = (select top 1 Id_Ruta from Rute where Nume = @numeRuta)
    print @idRuta
 
    set @idStatie = (select top 1 Id_Statie from Statii where Nume = @numeStatie)
    print @idStatie
 
    if (exists (select * from RuteStatii 
            where Id_Ruta = @idRuta and Id_Statie = @idStatie))
        update RuteStatii set Ora_Sosirii=@oraSosire, Ora_Plecarii=@oraPlecare
        where Id_Ruta = @idRuta and Id_Statie = @idStatie
    else
        insert into RuteStatii(Id_Ruta, Id_Statie, Ora_Sosirii, Ora_Plecarii) values
        (@idRuta, @idStatie, @oraSosire, @oraPlecare)
end
go

--exec AdaugaMasina 3,1,1,13,2
--------------------------------------------------------------------------------------
 
select * from Rute
select * from Statii
select * from RuteStatii
 
exec upsert_station 'cluj-arad', 'oradea', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'alesd', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'razboieni', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'bratca', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'campia turzii', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'ohaba de sub piatra', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'bucuresti nord', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'suncuius', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'cluj nord', '10:30', '10:34'
exec upsert_station 'cluj-arad', 'vaslui', '10:30', '10:34'
 
select * from Rute
select * from Statii
select * from RuteStatii


--------------------------------------------------------------------------------------
----------------------------RUTE CU TOATE STATIILE------------------------------------

create or alter view ruteCuToateStatiile
as 
select Rute.Nume
from RuteStatii inner join Rute on RuteStatii.Id_Ruta = Rute.Id_Ruta
group by Rute.Id_Ruta, Rute.Nume
having count(*) = (Select count(*) from Statii)
go
 
select * from ruteCuToateStatiile

----------------------------------------------------------------------------------------------------
----------------------STATII CU MAI MULT DE UN TREN LA O ANUMITA ORA--------------------------------

create or alter function listaStatii(@ora time)
returns table
as
return select s.Id_Statie, s.Nume from Statii s inner join RuteStatii rs on rs.Id_Statie=s.Id_Statie
WHERE rs.Ora_Sosirii='11:40' 
group by s.Id_Statie, s.Nume
having count(*) > 1

exec upsert_station 'cluj-arad', 'vaslui', '11:40', '11:54'
exec upsert_station 'arad-brasov', 'vaslui', '11:40', '11:54'

select * from dbo.listaStatii('11:40')
----------------------------------------------------------------------------------------------------

