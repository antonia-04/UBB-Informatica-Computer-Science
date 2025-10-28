USE OnlineAntiqueBookStore;
GO;

SELECT * FROM Address
SELECT * FROM Author
SELECT * FROM Publisher
SELECT * FROM Category
SELECT * FROM Provider
SELECT * FROM Book
SELECT * FROM BookCategory
SELECT * FROM Client
SELECT * FROM Account
SELECT * FROM OrderB
SELECT * FROM OrderBook
SELECT * FROM Review

-- Crearea procedurilor stocate
CREATE PROCEDURE GenerateAddresses (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Address (street, city, country)
        VALUES (
            'Street ' + CAST(@i AS VARCHAR(10)),
            'City ' + CAST(@i AS VARCHAR(10)),
            'Country ' + CAST(@i AS VARCHAR(10))
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateAuthors (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Author (name, country)
        VALUES (
            'Author ' + CAST(@i AS VARCHAR(10)),
            'Country ' + CAST(@i AS VARCHAR(10))
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GeneratePublishers (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Publisher (name, contact, website, idAddress)
        VALUES (
            'Publisher ' + CAST(@i AS VARCHAR(10)),
            'contact' + CAST(@i AS VARCHAR(10)) + '@publisher.com',
            'www.publisher' + CAST(@i AS VARCHAR(10)) + '.com',
            (SELECT TOP 1 idAddress FROM Address ORDER BY NEWID())
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateCategories (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Category (label, description)
        VALUES (
            'Category ' + CAST(@i AS VARCHAR(10)),
            'Description for Category ' + CAST(@i AS VARCHAR(10))
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateProviders (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Provider (name, contactPhone, idAddress)
        VALUES (
            'Provider ' + CAST(@i AS VARCHAR(10)),
            '123-456-' + RIGHT('0000' + CAST(@i AS VARCHAR(4)), 4),
            (SELECT TOP 1 idAddress FROM Address ORDER BY NEWID())
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateBooks (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Book (ISBN, title, price, year, idAuthor, idPublisher, idProvider)
        VALUES (
            1000000000 + @i,
            'Book Title ' + CAST(@i AS VARCHAR(10)),
            CAST(RAND() * 100 AS DECIMAL(10, 2)),
            1900 + CAST(RAND() * 123 AS INT),
            (SELECT TOP 1 idAuthor FROM Author ORDER BY NEWID()),
            (SELECT TOP 1 idPublisher FROM Publisher ORDER BY NEWID()),
            (SELECT TOP 1 idProvider FROM Provider ORDER BY NEWID())
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateBookCategories (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO BookCategory (ISBN, idCategory)
        VALUES (
            (SELECT TOP 1 ISBN FROM Book ORDER BY NEWID()),
            (SELECT TOP 1 idCategory FROM Category ORDER BY NEWID())
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE OR ALTER PROCEDURE GenerateClients (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Client (name, idAddress)
        VALUES (
            'Client ' + CAST(@i AS VARCHAR(10)),
            (SELECT TOP 1 idAddress FROM Address ORDER BY NEWID())
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateAccounts (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Account (idAccount, email, pass)
        VALUES (
            @i,
            'client' + CAST(@i AS VARCHAR(10)) + '@example.com',
            'password' + CAST(@i AS VARCHAR(10))
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateOrders (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO OrderB (idClient, date, status, totalPrice)
        VALUES (
            (SELECT TOP 1 idClient FROM Client ORDER BY NEWID()),
            DATEADD(DAY, -CAST(RAND() * 365 AS INT), GETDATE()),
            CASE WHEN RAND() > 0.5 THEN 'Shipped' ELSE 'Processing' END,
            CAST(RAND() * 1000 AS DECIMAL(10, 2))
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateOrderBooks (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO OrderBook (idOrder, ISBN)
        VALUES (
            (SELECT TOP 1 idOrder FROM OrderB ORDER BY NEWID()),
            (SELECT TOP 1 ISBN FROM Book ORDER BY NEWID())
        );
        SET @i = @i + 1;
    END;
END;
GO

CREATE PROCEDURE GenerateReviews (@numRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @numRows
    BEGIN
        INSERT INTO Review (idClient, ISBN, text, star)
        VALUES (
            (SELECT TOP 1 idClient FROM Client ORDER BY NEWID()),
            (SELECT TOP 1 ISBN FROM Book ORDER BY NEWID()),
            'Review text ' + CAST(@i AS VARCHAR(10)),
            CAST(RAND() * 5 + 1 AS INT)
        );
        SET @i = @i + 1;
    END;
END;
GO

-- Executarea procedurilor pentru generarea datelor
EXEC GenerateAddresses 100; 
EXEC GenerateAuthors 50; 
EXEC GeneratePublishers 20; 
EXEC GenerateCategories 10;
EXEC GenerateProviders 30; 
EXEC GenerateBooks 500; 
EXEC GenerateBookCategories 1000; 
EXEC GenerateClients 200; 
EXEC GenerateAccounts 200; 
EXEC GenerateOrders 1000; 
EXEC GenerateOrderBooks 2000; 
EXEC GenerateReviews 3000; 
GO