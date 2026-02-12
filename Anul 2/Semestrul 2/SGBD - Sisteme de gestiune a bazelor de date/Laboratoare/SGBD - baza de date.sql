CREATE DATABASE BookStore
go
use BookStore
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


INSERT INTO Address (street, city, country) VALUES 
('313 Mystery St', 'Seattle', 'USA'),
('14 Gothic Rd', 'Edinburgh', 'Scotland'),
('88 Enlightenment Ave', 'San Francisco', 'USA'),
('42 Braveheart St', 'Glasgow', 'Scotland'),
('209 Knowledge Ln', 'New Delhi', 'India'),
('Bulevardul Unirii', 'Bucuresti', 'Romania'),
('Strada Lascar Catargiu', 'Iasi', 'Romania'),
('Calea Victoriei', 'Bucuresti', 'Romania'),
('Calea Turzii', 'Cluj-Napoca', 'Romania');

INSERT INTO Author (name, country) VALUES 
('Veronica Roth', 'USA'),
('George Orwell', 'UK'),
('Suzanne Collins', 'USA'),
('Paulo Coelho', 'Brazil'),
('Malcolm Gladwell', 'Canada'),
('Mihai Eminescu', 'Romania'),
('Ion Creanga', 'Romania'),
('Mircea Eliade', 'Romania'),
('Andrei Plesu', 'Romania'),
('Irina Binder', 'Romania'),
('Rick Riordan', 'USA'),
('Emily Bronte', 'UK'),
('Jane Austen', 'UK'),
('Julia Quinn', 'USA');

INSERT INTO Publisher (name, contact, website, idAddress) VALUES 
('Scholastic Inc.', 'contact@scholastic.com', 'www.scholastic.com', 1),
('Macmillan Publishers', 'contact@macmillan.com', 'www.macmillan.com', 2),
('Bloomsbury', 'info@bloomsbury.com', 'www.bloomsbury.com', 3),
('Crown Publishing', 'info@crownpublishing.com', 'www.crownpublishing.com', 4),
('Harvill Secker', 'contact@harvillsecker.com', 'www.harvillsecker.com', 5),
('Humanitas', 'contact@humanitas.ro', 'www.humanitas.ro', 6),
('Polirom', 'contact@polirom.ro', 'www.polirom.ro', 7),
('Curtea Veche', 'contact@curteaveche.ro', 'www.curteaveche.ro', 8);

INSERT INTO Category (label, description) VALUES 
('Fantasy', 'books with magical or supernatural elements'),
('Science Fiction', 'books set in futuristic settings or involving advanced technology'),
('Self-Help', 'books focused on personal growth and problem-solving skills'),
('Historical Fiction', 'fictional stories set in real historical settings'),
('Biography', 'books about the life stories of notable individuals'),
('Young Adult', 'books aimed at young adult readers'),
('Romance', 'books focusing on romantic relationships'),
('Nonfiction', 'books based on factual information'),
('Classic Literature', 'timeless books by renowned authors'),
('Personal Development', 'books that help improve personal skills and knowledge');

INSERT INTO Provider (name, contactPhone, idAddress) VALUES 
('EpicReads Distributors', '678-123-4567', 1),
('BestBooks Supplies', '789-234-5678', 2),
('Infinite Knowledge', '890-345-6789', 3),
('BookSource Global', '901-456-7890', 4),
('BrightMinds Publishers', '012-567-8901', 5);

INSERT INTO Book (ISBN, title, price, year, idAuthor, idPublisher, idProvider) VALUES 
(1, 'Divergent', 17.99, 2011, 1, 1, 1),
(2, '1984', 13.99, 1949, 2, 2, 2),
(3, 'The Hunger Games', 15.99, 2008, 3, 3, 3),
(4, 'The Alchemist', 12.99, 1988, 4, 4, 4),
(5, 'Outliers: The Story of Success', 14.99, 2008, 5, 5, 5),
(6, 'Poezii', 29.99, 1883, 6, 6, 1),
(7, 'Amintiri din copil?rie', 24.99, 1870, 7, 7, 2),
(8, 'Maitreyi', 19.99, 1933, 8, 6, 3),
(9, 'Despre frumuse?ea uitat? a vie?ii', 34.99, 2011, 9, 6, 4),
(10, 'Fluturi', 39.99, 2013, 10, 8, 5),
(11, 'Pride and Prejudice', 19.99, 1813, 13, 3, 3),
(12, 'Percy Jackson and The Lightning Thief', 19.99, 2005, 11, 1, 1),
(13, 'Percy Jackson and The Sea of Monsters', 19.99, 2006, 11, 1, 1),
(14, 'Percy Jackson and The Titan Curse', 19.99, 2007, 11, 1, 2),
(15, 'Percy Jackson and The Battle of the Labyrinth', 14.99, 2008, 11, 1, 3),
(16, 'Percy Jackson and The Last Olympian', 16.00, 2009, 11, 1, 1),
(17, 'Carve the Mark', 18.00, 2016, 1, 1, 3);

INSERT INTO BookCategory (ISBN, idCategory) VALUES 
(1, 1), -- Divergent - Fantasy
(1, 6), -- Divergent - Young Adult
(2, 2), -- 1984 - Science Fiction
(2, 9), -- 1984 - Classic Literature
(3, 1), -- The Hunger Games - Fantasy
(3, 6), -- The Hunger Games - Young Adult
(4, 7), -- The Alchemist - Romance
(4, 3), -- The Alchemist - Self-Help
(5, 10), -- Outliers - Personal Development
(6, 9), -- Poezii - Classic Literature
(7, 9), -- Amintiri din copilarie - Classic Literature
(8, 7), -- Maitreyi - Romance
(9, 10), -- Despre frumusetea uitata a vietii - Personal Development
(10, 7), -- Fluturi - Romance
(11, 9), -- Pride and Prejudice - Classic Literature
(12, 1), -- Percy Jackson and The Lightning Thief - Fantasy
(13, 1), -- Percy Jackson and The Sea of Monsters - Fantasy
(14, 1), -- Percy Jackson and The Titan's Curse - Fantasy
(15, 1), -- Percy Jackson and The Battle of the Labyrinth - Fantasy
(16, 1), -- Percy Jackson and The Last Olympian - Fantasy
(17, 2); -- Carve the Mark - Science Fiction

INSERT INTO Client (name, phone, idAddress) VALUES 
('Michael Johnson', '1111111111', 1),
('Sarah Parker', '2222222222', 2),
('Emily Brown', '3333333333', 3),
('Daniel Wilson', '4444444444', 4),
('Laura Thompson', '5555555555', 5),
('Alexandru Popescu', '0765123456', 6),
('Ioana Marinescu', '0745123456', 7),
('Cristina Ionescu', '0735123456', 8);

INSERT INTO Account (idAccount, email, pass) VALUES 
(1, 'michael.johnson@example.com', 'mikePass123'),
(2, 'sarah.parker@example.com', 'sarahPass!'),
(3, 'emily.brown@example.com', 'emilyPass@2024'),
(4, 'daniel.wilson@example.com', 'danielPass#789'),
(5, 'laura.thompson@example.com', 'lauraPass@abc'),
(6, 'alexandru.popescu@example.com', 'alexPop!456'),
(7, 'ioana.marinescu@example.com', 'ioanaPass#123'),
(8, 'cristina.ionescu@example.com', 'cristi2024!');

INSERT INTO OrderB (idClient, date, status, totalPrice) VALUES 
(1, '2023-09-01', 'Delivered', 45.99),
(2, '2023-09-02', 'Shipped', 29.99),
(3, '2023-09-03', 'Processing', 33.99),
(4, '2023-09-04', 'Cancelled', 18.99),
(5, '2023-09-05', 'Delivered', 9.99),
(6, '2023-09-06', 'Shipped', 25.99),
(1, '2023-09-07', 'Delivered', 48.98),
(2, '2023-09-08', 'Processing', 28.98),
(1, '2023-10-01', 'Delivered', 79.98),
(2, '2023-10-02', 'Processing', 39.99),
(3, '2023-10-03', 'Shipped', 65.97),
(4, '2023-10-04', 'Cancelled', 29.99),
(5, '2023-10-05', 'Delivered', 99.99),
(6, '2023-10-06', 'Shipped', 54.98);

INSERT INTO OrderBook (idOrder, ISBN) VALUES 
(1, 1), -- Michael Johnson - Divergent
(2, 2), -- Sarah Parker - 1984
(3, 3), -- Emily Brown - The Hunger Games
(4, 4), -- Daniel Wilson - The Alchemist
(5, 5), -- Laura Thompson - Outliers
(6, 7), -- Alexandru Popescu - Amintiri din copil?rie
(7, 1), -- 7 - Michael Johnson - Divergent
(7, 2), -- 7 - Michael Johnson - 1984
(8, 3), -- 8 - Sarah Parker - The Hunger Games
(8, 4); -- 8 - Sarah Parker - The Alchemist

INSERT INTO Review (idClient, ISBN, text, star) VALUES 
(1, 1, 'Divergent was thrilling and engaging.', 4),
(2, 2, '1984 is thought-provoking and disturbing.', 5),
(3, 3, 'The Hunger Games kept me on the edge of my seat!', 5),
(4, 4, 'A philosophical journey through life.', 4),
(5, 5, 'Insightful book on success and hard work.', 5),
(6, 7, 'O poveste frumoas despre copilarie!', 4);




SELECT * FROM Author;
SELECT * FROM Book;
SELECT @@SERVERNAME;
