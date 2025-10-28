CREATE DATABASE OnlineAntiqueBookStore
go
use OnlineAntiqueBookStore
go

CREATE TABLE Address (
	idAddress INT PRIMARY KEY IDENTITY(1,1),
	street varchar(100),
	city varchar(50),
	country varchar(50)
);

CREATE TABLE Author(
	idAuthor INT PRIMARY KEY IDENTITY(1,1),
	name nvarchar(80),
	country nvarchar(80),
)

CREATE TABLE Publisher(
	idPublisher INT PRIMARY KEY IDENTITY(1,1),
	name nvarchar(80),
	contact nvarchar(80),
	website VARCHAR(100),
	idAddress INT FOREIGN KEY REFERENCES Address(idAddress)
)

CREATE TABLE Category(
	idCategory INT PRIMARY KEY IDENTITY(1,1),
	label nvarchar(50),
	description nvarchar(100)
)

CREATE TABLE Provider(
	idProvider INT PRIMARY KEY IDENTITY(1,1),
	name nvarchar(80),
	contactPhone VARCHAR(15),
	idAddress INT FOREIGN KEY REFERENCES Address(idAddress)
)

CREATE TABLE Book(
	ISBN INT PRIMARY KEY,
	title varchar(100),
	price DECIMAL(10, 2),	
	year int,
	idAuthor INT FOREIGN KEY REFERENCES Author(idAuthor),
	idPublisher INT FOREIGN KEY REFERENCES Publisher(idPublisher),
	idProvider INT FOREIGN KEY REFERENCES Provider(idProvider)
)

CREATE TABLE BookCategory (
	ISBN INT FOREIGN KEY REFERENCES Book(ISBN),
	idCategory INT FOREIGN KEY REFERENCES Category(idCategory),
	CONSTRAINT pk_BookCategory PRIMARY KEY (ISBN, idCategory)
);


CREATE TABLE Client(
	idClient INT PRIMARY KEY IDENTITY(1,1),
	name varchar(80),
	phone varchar(10),
	idAddress INT FOREIGN KEY REFERENCES Address(idAddress)
)

CREATE TABLE Account(
	idAccount INT UNIQUE FOREIGN KEY REFERENCES Client(idClient),
	email varchar(50) NOT NULL,
	pass varchar(25) NOT NULL,
	CONSTRAINT fk_Account_Client PRIMARY KEY (idAccount)

)

CREATE TABLE OrderB(
	idOrder INT PRIMARY KEY IDENTITY(1,1),
	idClient INT FOREIGN KEY REFERENCES Client(idClient),
	date DATETIME,
	status varchar(25),
	totalPrice DECIMAL(10, 2)
)


CREATE TABLE OrderBook(
	idOrder INT FOREIGN KEY REFERENCES OrderB(idOrder),
	ISBN INT FOREIGN KEY REFERENCES Book(ISBN),
	CONSTRAINT pk_OrderBook PRIMARY KEY (idOrder, ISBN)
)



CREATE TABLE Review(
	idClient INT FOREIGN KEY REFERENCES Client(idClient),
	ISBN INT FOREIGN KEY REFERENCES Book(ISBN),
	CONSTRAINT pk_Review PRIMARY KEY (idClient, ISBN),
	text varchar(150),
	star INT CHECK (star BETWEEN 1 AND 5),
)


