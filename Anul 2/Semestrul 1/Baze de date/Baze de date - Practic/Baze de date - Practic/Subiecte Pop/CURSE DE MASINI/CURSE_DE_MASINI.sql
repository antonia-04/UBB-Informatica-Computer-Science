create database CurseDeMasini
go

use CurseDeMasini
go

create table TipuriMasini(
	id_tip int primary key identity,
	denumire varchar(50),
	descriere varchar(50)
)

create table Masini(
	id_masina int primary key identity,
	nr_inmatriculare varchar(10),
	brand varchar(50),
	model int,
	culoare varchar(50),
	tip int foreign key references TipuriMasini(id_tip)
)

create table Locatii(
	id_locatie int primary key identity,
	tara varchar(50),
	regiune varchar(50),
	oras varchar(50)
)

create table Curse(
	id_cursa int primary key identity,
	denumire varchar(50),
	data_inceput date,
	data_final date,
	locatie int foreign key references Locatii(id_locatie)
)

create table MasiniCurse(
	id_masina int foreign key references Masini(id_masina),
	id_cursa int foreign key references Curse(id_cursa),
	punct_pornire int,
	punct_sosire int,
	locul_ocupat int
	constraint pk_MasiniCurse primary key (id_masina, id_cursa)
)

insert into TipuriMasini(denumire, descriere) values ('denumire1', 'descriere1'),('denumire2', 'descriere2'),('denumire3', 'descriere3')

insert into Masini(nr_inmatriculare, brand, model, culoare, tip) values ('SM 24 AGP', 'BMW', 2020,'negru',1), ('BH 77 BLS', 'AUDI', 2021, 'gri', 1), ('SM 07 WMW', 'MERCEDES', 2022, 'alb', 2)

insert into Locatii(tara, regiune, oras) values ('tara1', 'regiune1', 'oras1'),('tara2', 'regiune2', 'oras2'),('tara3', 'regiune3', 'oras3')

insert into Curse(denumire, data_inceput, data_final, locatie) values('denumire1', '2021-12-02', '2021-12-10', 1), ('denumire2','2021-10-02', '2021-10-10', 2),('denumire3','2021-09-02', '2021-09-10', 2),('denumire4','2022-01-02', '2022-01-10', 2)

insert into MasiniCurse(id_masina, id_cursa, punct_pornire, punct_sosire, locul_ocupat) values (1,1,1,23,2), (1,2,1,15,1), (1,3,1,17,2),(1,4,1,21,3)

create or alter procedure AdaugaMasina @masina int, @cursa int, @pornire int, @sosire int, @loc int
as
begin
	if(exists(select * from Masini where id_masina=@masina) and exists(select * from Curse where id_cursa=@cursa))
		begin
			if(exists(select * from MasiniCurse where id_masina=@masina and id_cursa=@cursa))
				begin
					update MasiniCurse set punct_pornire=@pornire, punct_sosire=@sosire 
					where id_masina=@masina and id_cursa=@cursa
					print 'Datele s-au actualizat!'
				end
			else
				begin
					insert into MasiniCurse(id_masina, id_cursa, punct_pornire, punct_sosire, locul_ocupat)
					values (@masina, @cursa, @pornire, @sosire, @loc)
					print 'Masina a fost adaugata cursei!'
				end
		end
	else
		begin
			print 'Datele sunt invalide!'
		end 
end

exec AdaugaMasina 3,1,1,13,2

select * from MasiniCurse



create or alter function functie()
returns table
as
	return select M.nr_inmatriculare, count(*) as Nr_curse
	from Masini M inner join MasiniCurse MC on MC.id_masina=M.id_masina
	group by M.nr_inmatriculare
	having count(*)>=3



select * from dbo.functie()