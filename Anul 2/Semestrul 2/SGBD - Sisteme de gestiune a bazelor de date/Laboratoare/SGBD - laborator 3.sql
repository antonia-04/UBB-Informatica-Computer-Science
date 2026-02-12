USE BookStore
GO

--- 1) o procedura stocata care insereaza date pt entitati ce se afla intr-o relatie M-N
--- daca o operatie esueaza, se face roll-back pt tot

-- functie de validare text
CREATE OR ALTER FUNCTION dbo.validare_Text (@text varchar(100))
RETURNS BIT
AS
BEGIN
    DECLARE @flag BIT = 1;
    IF @text IS NULL OR @text = ''
        SET @flag = 0;
    RETURN @flag;
END
GO

-- functie validare ISBN (numar pozitiv si obligatoriu)
CREATE OR ALTER FUNCTION dbo.validare_ISBN (@isbn INT)
RETURNS BIT
AS
BEGIN
    DECLARE @flag BIT = 1;
    IF @isbn IS NULL OR @isbn <= 0
        SET @flag = 0;
    RETURN @flag;
END
GO
--- CERINTA 1
-- procedura adaugare Book + Category + BookCategory
CREATE OR ALTER PROCEDURE AddBookCategory 
    @ISBN INT, @title VARCHAR(100), @price DECIMAL(10,2), @year INT, @idAuthor INT, @idPublisher INT, @idProvider INT,
    @label NVARCHAR(50), @description NVARCHAR(100)
AS
BEGIN
    BEGIN TRAN
    BEGIN TRY
        -- validari
        IF dbo.validare_ISBN(@ISBN) <> 1
        BEGIN
            PRINT 'ISBN invalid';
            RAISERROR('ISBN invalid',14,1);
        END
        
        IF dbo.validare_Text(@title) <> 1
        BEGIN
            PRINT 'Titlu invalid';
            RAISERROR('Titlu invalid',14,1);
        END
        
        IF dbo.validare_Text(@label) <> 1
        BEGIN
            PRINT 'Label categorie invalid';
            RAISERROR('Label categorie invalid',14,1);
        END
        
        -- insert Book
        INSERT INTO Book(ISBN, title, price, year, idAuthor, idPublisher, idProvider)
        VALUES (@ISBN, @title, @price, @year, @idAuthor, @idPublisher, @idProvider);
        
        PRINT 'Carte adaugata!';

        -- insert Category
        INSERT INTO Category(label, description)
        VALUES (@label, @description);

        PRINT 'Categorie adaugata!';

        DECLARE @idCategory INT;
        SELECT TOP 1 @idCategory = idCategory
        FROM Category
        WHERE label = @label
        ORDER BY idCategory DESC; -- luam ultima categorie adaugata

        -- insert BookCategory
        INSERT INTO BookCategory(ISBN, idCategory)
        VALUES (@ISBN, @idCategory);

        PRINT 'Legatura Book-Category adaugata!';

        COMMIT TRAN
        SELECT 'Transaction committed!' AS Status;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN
        PRINT ERROR_MESSAGE();
        SELECT 'Transaction rollbacked!' AS Status;
    END CATCH
END
GO


SELECT * FROM Book;
SELECT * FROM Category;
SELECT * FROM BookCategory;

--- NU UITA SA SCHIMBI ISBN
-- SUCCESS
EXECUTE AddBookCategory 
    678, 'Carte cerinta 1', 99.10, 2025, 1, 1, 1, 
    'Cerinta1', 'descriere';      

EXECUTE AddBookCategory 
    -3, 'Carte cerinta 1', 99.99, 2025, 1, 1, 1,       -- ISBN invalid
    'Test', 'Test';      

EXECUTE AddBookCategory 
    12399, 'Introducere in SQL', 99.99, 2025, 1, 1, 1,       
    '', 'descriere';      -- invalid Category

--- 2) o procedura stocata ce insereaza date pt entitati ce se afla intr-o relatie M-N
--- daca o operatie de inserare esueaza va trebui sa se pastreze cat mai mult posibil din ce s-a modif pana atunci

CREATE OR ALTER PROCEDURE AddBookAndCategory_SingleProc
    @ISBN INT, 
    @title VARCHAR(100), 
    @price DECIMAL(10, 2), 
    @year INT, 
    @idAuthor INT, 
    @idPublisher INT, 
    @idProvider INT,
    @label NVARCHAR(50), 
    @description NVARCHAR(100)
AS
BEGIN
    DECLARE @BookSuccess BIT = 0;
    DECLARE @CategorySuccess BIT = 0;
    DECLARE @idCategory INT = NULL;
    
    -- transaction 1: insert Book & validari
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- validari
        IF dbo.validare_ISBN(@ISBN) <> 1
            RAISERROR('ISBN invalid', 16, 1);
            
        IF dbo.validare_Text(@title) <> 1
            RAISERROR('Titlu invalid', 16, 1);
            
        -- insert Book
        INSERT INTO Book (ISBN, title, price, year, idAuthor, idPublisher, idProvider)
        VALUES (@ISBN, @title, @price, @year, @idAuthor, @idPublisher, @idProvider);
        
        SET @BookSuccess = 1;
        COMMIT TRANSACTION;
        PRINT 'Book inserted successfully!!';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        PRINT 'Book insertion failed: ' + ERROR_MESSAGE();
    END CATCH
    
    -- transaction 2: insert Category & validari
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- validari
        IF dbo.validare_Text(@label) <> 1
            RAISERROR('Label invalid', 16, 1);
            
        -- insert Category
        INSERT INTO Category (label, description)
        VALUES (@label, @description);
        
        SET @idCategory = SCOPE_IDENTITY();
        SET @CategorySuccess = 1;
        COMMIT TRANSACTION;
        PRINT 'Category inserted successfully!!';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        PRINT 'Category insertion failed: ' + ERROR_MESSAGE();
    END CATCH
    
    -- transaction 3: Insert BookCategory -> doar daca celelalte 2 sunt cu succes
    IF @BookSuccess = 1 AND @CategorySuccess = 1
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;
            
            -- validari
            IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
                RAISERROR('Book does not exist', 16, 1);
                
            IF NOT EXISTS (SELECT 1 FROM Category WHERE idCategory = @idCategory)
                RAISERROR('Category does not exist', 16, 1);
                
            -- insert 
            INSERT INTO BookCategory (ISBN, idCategory)
            VALUES (@ISBN, @idCategory);
            
            COMMIT TRANSACTION;
            PRINT 'Book-Category link created successfully';
        END TRY
        BEGIN CATCH
            IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
            PRINT 'Book-Category link creation failed: ' + ERROR_MESSAGE();
        END CATCH
    END
    ELSE
    BEGIN
        PRINT 'Book-Category link not attempted due to previous failures';
    END
    
    -- return overall status
    IF @BookSuccess = 1 AND @CategorySuccess = 1
    BEGIN
        PRINT 'All operations completed successfully';
        RETURN 1;
    END
    ELSE
    BEGIN
        PRINT 'Some operations failed:<';
        RETURN 0;
    END
END

SELECT * FROM Category;
SELECT * FROM Book;
SELECT * FROM BookCategory;

--- NU UITA SA SCHIMBI ISBN
-- succes
EXEC AddBookAndCategory_SingleProc 
    876, 'Test Book2', 49.99, 2023, 1, 1, 1,
    'Test2 Category', 'Test Description';

-- ISBN invalid
EXEC AddBookAndCategory_SingleProc 
    -1, 'Test Book2', 49.99, 2023, 1, 1, 1,
    'Test2 Category', 'Test Description';

-- label categorie invalid
EXEC AddBookAndCategory_SingleProc 
    678, 'Test Book', 49.99, 2023, 1, 1, 1,
    '', 'Test2 Description';