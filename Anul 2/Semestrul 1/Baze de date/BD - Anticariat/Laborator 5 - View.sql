--- LABORATOR 5

/*Un index non-clustered este o structură separată de datele tabelului.
Conține o copie a coloanelor indexate și un pointer către locația 
rândului în tabel (sau în indexul clustered, dacă există).*/

CREATE OR ALTER VIEW vw_ClientTotalBooks AS
SELECT 
    C.idClient,
    C.name AS ClientName,
    COUNT(OB.ISBN) AS TotalBooksOrdered
FROM 
    Client C
JOIN 
    OrderB O ON C.idClient = O.idClient
JOIN 
    OrderBook OB ON O.idOrder = OB.idOrder
GROUP BY 
    C.idClient, C.name;
GO

SELECT * FROM vw_ClientTotalBooks;
GO

CREATE OR ALTER VIEW vw_BookClientReviews AS
SELECT 
    B.title AS BookTitle,
    C.name AS ClientName,
    R.text AS ReviewText
FROM 
    Book B
JOIN 
    Review R ON B.ISBN = R.ISBN
JOIN 
    Client C ON R.idClient = C.idClient;
GO

SELECT * FROM vw_BookClientReviews;

CREATE NONCLUSTERED INDEX NIX_OrderBook_Order ON OrderBook(idOrder);
CREATE NONCLUSTERED INDEX IX_Review_Client_ISBN ON Review(idClient, ISBN) INCLUDE (text);
CREATE NONCLUSTERED INDEX NIX_OrderB_Client ON OrderB(idClient);


