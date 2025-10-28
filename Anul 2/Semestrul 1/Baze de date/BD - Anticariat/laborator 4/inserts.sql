USE OnlineAntiqueBookStore
GO;

CREATE OR ALTER PROCEDURE InsertCategory (@nrRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    --DBCC CHECKIDENT (Category, RESEED, 0);
    WHILE @i <= @nrRows
    BEGIN
        INSERT INTO Category (label, description) 
        VALUES 
            ('Label' + CAST(@i AS NVARCHAR(50)), 
             'Description' + CAST(@i AS NVARCHAR(100)));
        SET @i = @i + 1;
    END
END
GO

CREATE OR ALTER PROCEDURE InsertBook (@nrRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    --DBCC CHECKIDENT (Book, RESEED, 0);
    WHILE @i <= @nrRows
    BEGIN
        INSERT INTO Book (ISBN, title, price, year, idAuthor, idPublisher, idProvider)
        VALUES 
            (@i, 
             'Title' + CAST(@i AS VARCHAR(100)), 
             ROUND(RAND(CHECKSUM(NEWID())) * 100 + 10, 2), 
             FLOOR(RAND(CHECKSUM(NEWID())) * (2023 - 1900 + 1)) + 1900, 
             1, 1, 1);
        SET @i = @i + 1;
    END
END
GO


CREATE OR ALTER PROCEDURE InsertBookCategory (@nrRows INT)
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i <= @nrRows
    BEGIN
        INSERT INTO BookCategory (ISBN, idCategory)
        VALUES 
            ((SELECT TOP 1 ISBN FROM Book ORDER BY NEWID()), 
             (SELECT TOP 1 idCategory FROM Category ORDER BY NEWID()));
        SET @i = @i + 1;
    END
END
GO
