-- LABORATOR 5 - CRUD
USE OnlineAntiqueBookStore
GO
/*C - CREATE or INSERT
  R - SELECT
  U - UPDATE
  D - DELETE
*/

/*
Operatii CRUD incapsulate in proceduri stocate pt >5 tabele din BD
(cel putin o relatie many-to-many)
-> parametrii, functii (formatare, validare date), constrangeri pe tabela/coloana pt validarea datelor
- mai mult de 2 views pt tabelele selectate pt op. CRUD
pt tabelele folosite creati indecsi non-clustered
*/

-- Tabele: Client, OrderB, OrderBook, Book, Review

-- CLIENT

CREATE OR ALTER PROCEDURE InsertClient
    @name VARCHAR(80),
    @phone VARCHAR(10),
    @idAddress INT
AS
BEGIN
    -- validare: numele clientului nu trebuie să fie null sau gol
    IF @name IS NULL OR LTRIM(RTRIM(@name)) = ''
    BEGIN
        PRINT 'Cannot insert client: Name is required.';
        RETURN;
    END

    -- validare: adresa trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM Address WHERE idAddress = @idAddress)
    BEGIN
        PRINT 'Cannot insert client: Address does not exist.';
        RETURN;
    END

    -- inserare
    INSERT INTO Client (name, phone, idAddress)
    VALUES (@name, @phone, @idAddress);

    PRINT 'Client inserted successfully.';
END;
GO

CREATE OR ALTER PROCEDURE GetClient
    @idClient INT 
AS
BEGIN
    IF @idClient IS NULL
    BEGIN
        -- select simplu: toti clientii
        SELECT * FROM Client;
    END
    ELSE
    BEGIN
        -- select complex: clientul specific
        SELECT * FROM Client WHERE idClient = @idClient;
    END
END;
GO

CREATE OR ALTER PROCEDURE UpdateClient
    @idClient INT,
    @name VARCHAR(80) = NULL,
    @phone VARCHAR(10) = NULL,
    @idAddress INT = NULL
AS
BEGIN
    -- validare: clientul trebuie sa existe
    IF NOT EXISTS (SELECT 1 FROM Client WHERE idClient = @idClient)
    BEGIN
        PRINT 'Cannot update client: Client does not exist.';
        RETURN;
    END

    -- validare: adresa trebuie să existe (dacă este furnizată)
    IF @idAddress IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Address WHERE idAddress = @idAddress)
    BEGIN
        PRINT 'Cannot update client: Address does not exist.';
        RETURN;
    END

    -- actualizare
    UPDATE Client
    SET 
        name = ISNULL(@name, name),
        phone = ISNULL(@phone, phone),
        idAddress = ISNULL(@idAddress, idAddress)
    WHERE idClient = @idClient;

    PRINT 'Client updated successfully.';
END;
GO

CREATE OR ALTER PROCEDURE DeleteClient
    @idClient INT
AS
BEGIN
    -- validare: Clientul trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM Client WHERE idClient = @idClient)
    BEGIN
        PRINT 'Cannot delete client: Client does not exist.';
        RETURN;
    END

    DELETE FROM OrderBook WHERE idOrder IN (SELECT idOrder FROM OrderB WHERE idClient = @idClient);
    DELETE FROM OrderB WHERE idClient = @idClient;
    DELETE FROM Account WHERE idAccount = @idClient;
    DELETE FROM Client WHERE idClient = @idClient;
	DELETE FROM Review WHERE idClient = @idClient;

    PRINT 'Client deleted successfully.';
END;
GO

-- RULARE

EXEC InsertClient @name = 'Maria', @phone = '1234567890', @idAddress = 1;
EXEC GetClient @idClient = 1;
EXEC UpdateClient @idClient = 1, @phone = '0987654321';
EXEC DeleteClient @idClient = 1;
GO

-- BOOK

CREATE OR ALTER PROCEDURE InsertBook
    @ISBN INT,
    @title VARCHAR(100),
    @price DECIMAL(10, 2),
    @year INT,
    @idAuthor INT,
    @idPublisher INT,
    @idProvider INT
AS
BEGIN
    -- validare: ISBN nu trebuie sa existe deja
    IF EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        PRINT 'Cannot insert book: ISBN already exists.';
        RETURN;
    END

    -- validare: Autorul trebuie sa existe
    IF NOT EXISTS (SELECT 1 FROM Author WHERE idAuthor = @idAuthor)
    BEGIN
        PRINT 'Cannot insert book: Author does not exist.';
        RETURN;
    END

    -- validare: Editura trebuie sa existe
    IF NOT EXISTS (SELECT 1 FROM Publisher WHERE idPublisher = @idPublisher)
    BEGIN
        PRINT 'Cannot insert book: Publisher does not exist.';
        RETURN;
    END

    -- validare: Furnizorul trebuie sa existe
    IF NOT EXISTS (SELECT 1 FROM Provider WHERE idProvider = @idProvider)
    BEGIN
        PRINT 'Cannot insert book: Provider does not exist.';
        RETURN;
    END

    INSERT INTO Book (ISBN, title, price, year, idAuthor, idPublisher, idProvider)
    VALUES (@ISBN, @title, @price, @year, @idAuthor, @idPublisher, @idProvider);

    PRINT 'Book inserted successfully.';
END;
GO

CREATE OR ALTER PROCEDURE GetBook
    @ISBN INT 
AS
BEGIN
     SELECT * FROM Book WHERE ISBN = @ISBN;
END;
GO

CREATE OR ALTER PROCEDURE UpdateBook
    @ISBN INT,
    @price DECIMAL(10, 2)
AS
BEGIN
    -- validare: Cartea trebuie sa existe
    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        PRINT 'Cannot update book: Book does not exist.';
        RETURN;
    END

    UPDATE Book
    SET 
        price = @price
    WHERE ISBN = @ISBN;

    PRINT 'Book updated successfully.';
END;
GO

CREATE OR ALTER PROCEDURE DeleteBook
    @ISBN INT
AS
BEGIN
    -- validare: Cartea trebuie sa existe
    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        PRINT 'Cannot delete book: Book does not exist.';
        RETURN;
    END
	-- sterge in cascada
    DELETE FROM BookCategory WHERE ISBN = @ISBN;
    DELETE FROM Book WHERE ISBN = @ISBN;

    PRINT 'Book deleted successfully.';
END;
GO

--RULARE
EXEC InsertBook 
    @ISBN = 123456, 
    @title = '1984', 
    @price = 19.99, 
    @year = 1949, 
    @idAuthor = 1, 
    @idPublisher = 1, 
    @idProvider = 1;

EXEC GetBook @ISBN = 123456;
EXEC UpdateBook @ISBN = 123456, @price = 24.99;
EXEC DeleteBook @ISBN = 123456;
GO

--ORDERB

CREATE OR ALTER PROCEDURE InsertOrderB
    @idClient INT,
    @date DATETIME,
    @status VARCHAR(25),
    @totalPrice DECIMAL(10, 2)
AS
BEGIN
    -- validare: clientul trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM Client WHERE idClient = @idClient)
    BEGIN
        PRINT 'Cannot insert order: Client does not exist.';
        RETURN;
    END

    -- inserare
    INSERT INTO OrderB (idClient, date, status, totalPrice)
    VALUES (@idClient, @date, @status, @totalPrice);

    PRINT 'Order inserted successfully.';
END;
GO

CREATE OR ALTER PROCEDURE GetOrderB
    @idOrder INT 
AS
BEGIN
    IF @idOrder IS NULL
    BEGIN
        -- select simplu: toate comenzile
        SELECT * FROM OrderB;
    END
    ELSE
    BEGIN
        -- select complex: comanda specifică
        SELECT * FROM OrderB WHERE idOrder = @idOrder;
    END
END;
GO

CREATE OR ALTER PROCEDURE UpdateOrderB
    @idOrder INT,
    @status VARCHAR(25) = NULL,
    @totalPrice DECIMAL(10, 2) = NULL
AS
BEGIN
    -- validare: comanda trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM OrderB WHERE idOrder = @idOrder)
    BEGIN
        PRINT 'Cannot update order: Order does not exist.';
        RETURN;
    END

    -- actualizare
    UPDATE OrderB
    SET 
        status = ISNULL(@status, status),
        totalPrice = ISNULL(@totalPrice, totalPrice)
    WHERE idOrder = @idOrder;

    PRINT 'Order updated successfully.';
END;
GO

CREATE OR ALTER PROCEDURE DeleteOrderB
    @idOrder INT
AS
BEGIN
    -- validare: comanda trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM OrderB WHERE idOrder = @idOrder)
    BEGIN
        PRINT 'Cannot delete order: Order does not exist.';
        RETURN;
    END

    -- ștergere în cascadă: șterge mai întâi înregistrările asociate din orderbook
    DELETE FROM OrderBook WHERE idOrder = @idOrder;

    -- șterge comanda
    DELETE FROM OrderB WHERE idOrder = @idOrder;

    PRINT 'Order deleted successfully.';
END;
GO

-- bloc de rulare pentru orderb

EXEC InsertOrderB @idClient = 3, @date = '2023-10-01', @status = 'Pending', @totalPrice = 100.00;
EXEC GetOrderB @idOrder = 1;
EXEC UpdateOrderB @idOrder = 1, @status = 'Completed';
EXEC DeleteOrderB @idOrder = 1;
GO

--ORDERBOOK

CREATE OR ALTER PROCEDURE InsertOrderBook
    @idOrder INT,
    @ISBN INT
AS
BEGIN
    -- validare: comanda trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM OrderB WHERE idOrder = @idOrder)
    BEGIN
        PRINT 'Cannot insert order book: Order does not exist.';
        RETURN;
    END

    -- validare: cartea trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        PRINT 'Cannot insert order book: Book does not exist.';
        RETURN;
    END

    -- inserare
    INSERT INTO OrderBook (idOrder, ISBN)
    VALUES (@idOrder, @ISBN);

    PRINT 'Order book inserted successfully.';
END;
GO

CREATE OR ALTER PROCEDURE GetOrderBook
    @idOrder INT,
    @ISBN INT 
AS
BEGIN
    IF @idOrder IS NULL AND @ISBN IS NULL
    BEGIN
        -- select simplu: toate asocierile
        SELECT * FROM OrderBook;
    END
    ELSE IF @idOrder IS NOT NULL AND @ISBN IS NULL
    BEGIN
        -- select complex: toate cărțile dintr-o comandă specifică
        SELECT * FROM OrderBook WHERE idOrder = @idOrder;
    END
    ELSE IF @idOrder IS NULL AND @ISBN IS NOT NULL
    BEGIN
        -- select complex: toate comenzile pentru o carte specifică
        SELECT * FROM OrderBook WHERE ISBN = @ISBN;
    END
    ELSE
    BEGIN
        -- select complex: asocierea specifică
        SELECT * FROM OrderBook WHERE idOrder = @idOrder AND ISBN = @ISBN;
    END
END;
GO

CREATE OR ALTER PROCEDURE UpdateOrderBook
    @oldIdOrder INT,
    @oldISBN INT,
    @newIdOrder INT = NULL,
    @newISBN INT = NULL
AS
BEGIN
    -- validare: asocierea veche trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM OrderBook WHERE idOrder = @oldIdOrder AND ISBN = @oldISBN)
    BEGIN
        PRINT 'Cannot update order book: Association does not exist.';
        RETURN;
    END

    -- validare: noua comandă trebuie să existe (dacă este furnizată)
    IF @newIdOrder IS NOT NULL AND NOT EXISTS (SELECT 1 FROM OrderB WHERE idOrder = @newIdOrder)
    BEGIN
        PRINT 'Cannot update order book: New order does not exist.';
        RETURN;
    END

    -- validare: noua carte trebuie să existe (dacă este furnizată)
    IF @newISBN IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @newISBN)
    BEGIN
        PRINT 'Cannot update order book: New book does not exist.';
        RETURN;
    END

    -- actualizare
    UPDATE OrderBook
    SET 
        idOrder = ISNULL(@newIdOrder, idOrder),
        ISBN = ISNULL(@newISBN, ISBN)
    WHERE idOrder = @oldIdOrder AND ISBN = @oldISBN;

    PRINT 'Order book updated successfully.';
END;
GO

CREATE OR ALTER PROCEDURE DeleteOrderBook
    @idOrder INT,
    @ISBN INT
AS
BEGIN
    -- validare: asocierea trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM OrderBook WHERE idOrder = @idOrder AND ISBN = @ISBN)
    BEGIN
        PRINT 'Cannot delete order book: Association does not exist.';
        RETURN;
    END

    -- ștergere
    DELETE FROM OrderBook WHERE idOrder = @idOrder AND ISBN = @ISBN;

    PRINT 'Order book deleted successfully.';
END;
GO

-- RULARE

EXEC InsertOrderBook @idOrder = 1, @ISBN = 123456;
EXEC GetOrderBook @idOrder = 1, @ISBN = 123456;
EXEC UpdateOrderBook @oldIdOrder = 1, @oldISBN = 123456, @newISBN = 654321;
EXEC DeleteOrderBook @idOrder = 1, @ISBN = 654321;
GO

-- REVIEW

CREATE OR ALTER PROCEDURE InsertReview
    @idClient INT,
    @ISBN INT,
    @text VARCHAR(150),
    @star INT
AS
BEGIN
    -- validare: clientul trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM Client WHERE idClient = @idClient)
    BEGIN
        PRINT 'Cannot insert review: Client does not exist.';
        RETURN;
    END

    -- validare: cartea trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM Book WHERE ISBN = @ISBN)
    BEGIN
        PRINT 'Cannot insert review: Book does not exist.';
        RETURN;
    END

    -- validare: rating-ul trebuie să fie între 1 și 5
    IF @star < 1 OR @star > 5
    BEGIN
        PRINT 'Cannot insert review: Star rating must be between 1 and 5.';
        RETURN;
    END

    -- inserare
    INSERT INTO Review (idClient, ISBN, text, star)
    VALUES (@idClient, @ISBN, @text, @star);

    PRINT 'Review inserted successfully.';
END;
GO

CREATE OR ALTER PROCEDURE GetReview
    @idClient INT,
    @ISBN INT 
AS
BEGIN
    IF @idClient IS NULL AND @ISBN IS NULL
    BEGIN
        -- select simplu: toate recenziile
        SELECT * FROM Review;
    END
    ELSE IF @idClient IS NOT NULL AND @ISBN IS NULL
    BEGIN
        -- select complex: toate recenziile unui client
        SELECT * FROM Review WHERE idClient = @idClient;
    END
    ELSE IF @idClient IS NULL AND @ISBN IS NOT NULL
    BEGIN
        -- select complex: toate recenziile pentru o carte
        SELECT * FROM Review WHERE ISBN = @ISBN;
    END
    ELSE
    BEGIN
        -- select complex: recenzia specifică
        SELECT * FROM Review WHERE idClient = @idClient AND ISBN = @ISBN;
    END
END;
GO

CREATE OR ALTER PROCEDURE UpdateReview
    @idClient INT,
    @ISBN INT,
    @text VARCHAR(150) = NULL,
    @star INT = NULL
AS
BEGIN
    -- validare: recenzia trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM Review WHERE idClient = @idClient AND ISBN = @ISBN)
    BEGIN
        PRINT 'Cannot update review: Review does not exist.';
        RETURN;
    END

    -- validare: rating-ul trebuie să fie între 1 și 5 (dacă este furnizat)
    IF @star IS NOT NULL AND (@star < 1 OR @star > 5)
    BEGIN
        PRINT 'Cannot update review: Star rating must be between 1 and 5.';
        RETURN;
    END

    -- actualizare
    UPDATE Review
    SET 
        text = ISNULL(@text, text),
        star = ISNULL(@star, star)
    WHERE idClient = @idClient AND ISBN = @ISBN;

    PRINT 'Review updated successfully.';
END;
GO

CREATE OR ALTER PROCEDURE DeleteReview
    @idClient INT,
    @ISBN INT
AS
BEGIN
    -- validare: recenzia trebuie să existe
    IF NOT EXISTS (SELECT 1 FROM Review WHERE idClient = @idClient AND ISBN = @ISBN)
    BEGIN
        PRINT 'Cannot delete review: Review does not exist.';
        RETURN;
    END

    -- ștergere
    DELETE FROM Review WHERE idClient = @idClient AND ISBN = @ISBN;

    PRINT 'Review deleted successfully.';
END;
GO

-- RULARE
EXEC InsertReview @idClient = 1, @ISBN = 123456, @text = 'Great book!', @star = 5;
EXEC GetReview @idClient = 1, @ISBN = 123456;
EXEC UpdateReview @idClient = 1, @ISBN = 123456, @text = 'Amazing book!';
EXEC DeleteReview @idClient = 1, @ISBN = 123456;
GO