USE BookStore
GO
-- CERINTA 1

-- DIRTY READS
-- modif anul unei carti dar facem roll back
-- tranzatia 2 va citi modificarea desi nu se va salva in DB
BEGIN TRAN
UPDATE Book SET year = 2020 WHERE ISBN = 1
WAITFOR DELAY '00:00:10' 
ROLLBACK TRAN

SELECT * FROM Book


-- NON-REPEATABLE READS
-- T1: delay + update + commit

INSERT INTO Book(ISBN, title, price, year, idAuthor, idPublisher, idProvider) 
VALUES (201, 'Test Book', 50.00, 2020, 1, 1, 1)
BEGIN TRAN
WAITFOR DELAY '00:00:10' -- T2 face primul SELECT
UPDATE Book SET price = 55.00 WHERE ISBN = 201 -- update
COMMIT TRAN

SELECT * FROM Book


-- PHANTOM READS 
-- T1: delay + insert + commit
-- simulam un phantom read: T1 insert intre cele 2 selecturi din T2
BEGIN TRAN
WAITFOR DELAY '00:00:10' -- T2 face primul SELECT general din Book
INSERT INTO Book(ISBN, title, price, year, idAuthor, idPublisher, idProvider) 
VALUES (300,'Phantom Book', 30.00, 2024, 1, 1, 1)
COMMIT TRAN


-- DEADLOCK 
-- simulam un deadlock: T1 update Book, apoi Category
-- T2 face invers
USE BookStore
BEGIN TRAN
UPDATE Book SET price = price + 1 WHERE ISBN = 1
WAITFOR DELAY '00:00:10' 
UPDATE Category SET label = 'Updated T1' WHERE idCategory = 1
COMMIT TRAN

-- CERINTA 2

CREATE OR ALTER PROCEDURE DeadLock1 AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

    BEGIN TRY
        BEGIN TRAN

        -- primul lock pe Book
        UPDATE Book SET price = price + 1 WHERE ISBN = 1

        -- pauza pt celalalt thread
        WAITFOR DELAY '00:00:10'

        -- al doilea lock pe Category
        UPDATE Category SET label = 'Updated by DeadLock1' WHERE idCategory = 1

        COMMIT TRAN
        SELECT 'DeadLock1 OK' AS MSG
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRAN
        SELECT ERROR_MESSAGE() AS MSG
    END CATCH
END
GO