USE OnlineAntiqueBookStore
GO

--Crearea tabelelor care sunt legate de View
DELETE FROM Tables
SET IDENTITY_INSERT Tables ON;
INSERT INTO Tables(TableID, Name) VALUES
	(1, 'Book'),
	(2, 'Category'),
	(3, 'BookCategory');
SET IDENTITY_INSERT Tables OFF;

--Cream un View pt un singur tabel (PK)
CREATE VIEW View_Category AS
SELECT 
    idCategory AS IDCategorie,
    label AS Eticheta,
    description AS Descriere
FROM 
    Category;

--Cream un View pentru cele 2 tabele (PK+FK)
CREATE VIEW View_BookCategory AS
SELECT 
    b.ISBN AS ISBN,
    b.title AS Titlu,
    c.label AS Categoria,
    c.description AS Descriere
FROM 
    Book b
INNER JOIN 
    BookCategory bc ON b.ISBN = bc.ISBN
INNER JOIN 
    Category c ON bc.idCategory = c.idCategory;

--Cream un View ce contine o comanda SELECT pe cel putin 2 tabele
-- si avand o clauza GROUP BY
CREATE VIEW View_BookCategoryGroup AS
SELECT 
    c.label AS Categoria,
    COUNT(bc.ISBN) AS NumarCarti,
    AVG(b.price) AS PretMediu
FROM 
    Category c
INNER JOIN 
    BookCategory bc ON c.idCategory = bc.idCategory
INNER JOIN 
    Book b ON bc.ISBN = b.ISBN
GROUP BY 
    c.label;

--In View adaugam View-urile create mai sus
SET IDENTITY_INSERT Views ON;
INSERT INTO Views(ViewID, Name) VALUES
	(1, 'View_Category'),
	(2, 'View_BookCategory'),
	(3, 'View_BookCategoryGroup');
SET IDENTITY_INSERT Views OFF;

DELETE FROM Tables
SET IDENTITY_INSERT Tables ON;
INSERT INTO Tables(TableID, Name) VALUES
	(1, 'Book'),
	(2, 'Category'),
	(3, 'BookCategory');
SET IDENTITY_INSERT Tables OFF;

SET IDENTITY_INSERT Tests ON;
INSERT INTO Tests (TestID, Name) 
VALUES (1, 'Test');
SET IDENTITY_INSERT Tests OFF;

SELECT * FROM Tests;


INSERT INTO TestViews(TestID,ViewID) VALUES
	(1,1),
	(1,2),
	(1,3);


INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES
	(1,1,1000,3),
	(1,2,1000,2),
	(1,3,1000,1);


---verficari 
SELECT * FROM Tables;
SELECT * FROM Tests;
SELECT * FROM Views;

