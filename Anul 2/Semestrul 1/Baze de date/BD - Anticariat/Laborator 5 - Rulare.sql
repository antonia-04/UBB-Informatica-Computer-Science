USE OnlineAntiqueBookStore;

-- Inserare date
EXEC InsertAuthor @name = 'George Orwell', @country = 'United Kingdom';
EXEC InsertPublisher @name = 'Penguin Books', @contact = 'contact@penguin.com', @website = 'www.penguin.com', @idAddress = 1;
EXEC InsertClient @name = 'John Doe', @phone = '1234567890', @idAddress = 1;
EXEC InsertBook @ISBN = 123456, @title = '1984', @price = 19.99, @year = 1949, @idAuthor = 1, @idPublisher = 1, @idProvider = 1;
EXEC InsertBookCategory @ISBN = 123456, @idCategory = 1;

-- Selectare date
EXEC GetAuthor @idAuthor = 1;
EXEC GetPublisher @idPublisher = 1;
EXEC GetClient @idClient = 1;
EXEC GetBook @ISBN = 123456;
EXEC GetBookCategory @ISBN = 123456, @idCategory = 1;

-- Actualizare date
EXEC UpdateAuthor @idAuthor = 1, @name = 'George Orwell', @country = 'UK';
EXEC UpdatePublisher @idPublisher = 1, @contact = 'support@penguin.com';
EXEC UpdateClient @idClient = 1, @phone = '0987654321';
EXEC UpdateBook @ISBN = 123456, @price = 24.99;
EXEC UpdateBookCategory @oldISBN = 123456, @oldIdCategory = 1, @newISBN = 654321;

-- Stergere date
EXEC DeleteBookCategory @ISBN = 654321, @idCategory = 1;
EXEC DeleteBook @ISBN = 123456;
EXEC DeleteClient @idClient = 1;
EXEC DeletePublisher @idPublisher = 1;
EXEC DeleteAuthor @idAuthor = 1;

-- Testare view-uri
SELECT * FROM vw_BooksWithAuthors;
SELECT * FROM vw_OrdersWithClients;
SELECT * FROM vw_BooksWithCategories;

-- Verificare utilizare indecsi
SELECT 
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    user_seeks,
    user_scans,
    user_lookups,
    user_updates
FROM 
    sys.dm_db_index_usage_stats us
JOIN 
    sys.indexes i ON us.object_id = i.object_id AND us.index_id = i.index_id
WHERE 
    OBJECT_NAME(i.object_id) IN ('Book', 'Author', 'Client', 'OrderB', 'BookCategory');