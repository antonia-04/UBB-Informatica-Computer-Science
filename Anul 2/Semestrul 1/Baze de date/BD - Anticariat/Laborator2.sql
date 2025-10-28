USE OnlineAntiqueBookStore

---#1
--- numarul total de clienti care au cumparat carti din categoria fantasy
--- where, group by, >2 tabele
SELECT c.label AS Category, COUNT(DISTINCT cl.idClient) AS totalClients
FROM Client cl
JOIN OrderB o ON cl.idClient = o.idClient
JOIN OrderBook ob ON o.idOrder = ob.idOrder
JOIN Book b ON ob.ISBN = b.ISBN
JOIN BookCategory bc ON b.ISBN = bc.ISBN
JOIN Category c ON bc.idCategory = c.idCategory
WHERE c.label = 'Fantasy'
GROUP BY c.label;

---#2
--- selecteaza cartile(titlul) distincte care sunt in categoriile YA si fantasy si le ordoneaza desc dupa pret
--- where, order by, N-M, distinct
SELECT DISTINCT b.title, b.price
FROM Book b
JOIN BookCategory bc ON b.ISBN = bc.ISBN
JOIN Category c ON bc.idCategory = c.idCategory
WHERE c.label IN ('Young Adult', 'Fantasy')
ORDER BY b.price DESC;

---#3
---afiseaza detalii pentru o carte (titlu, pret) + le ia din alte tabele: author, publisher, provider
--- >2 tabele
SELECT b.title AS TITLE, b.price AS PRICE, a.name AS AUTHOR, p.name AS PUBLISHER, pr.name AS PROVIDER
FROM Book b
JOIN Author a ON b.idAuthor = a.idAuthor
JOIN Publisher p ON b.idPublisher = p.idPublisher
JOIN Provider pr ON b.idProvider = pr.idProvider;

---#4
--- selecteaza toate comenzile si afiseaza numele clientului + cartea din comenzi unde pretul este >14.99
--- where, >2 tabele
SELECT o.idOrder AS IdOrder, c.name AS Client, b.title AS Book
FROM OrderB o
JOIN Client c ON o.idClient = c.idClient
JOIN OrderBook ob ON o.idOrder = ob.idOrder
JOIN Book b ON ob.ISBN = b.ISBN
where b.price > 14.99
ORDER BY o.idOrder, b.title;

---#5
--- media ratingului pentru cartile din categoria Fantasy -> afiseaza titlu, autor, medie
--- >2 tabele, having, where, group by
---GROUP BY le grupeaza ca sa putem calcula media
SELECT b.title AS Title, a.name AS Author,  AVG(r.star) AS Rating
FROM Book b
JOIN Author a ON b.idAuthor = a.idAuthor
JOIN Review r ON b.ISBN = r.ISBN
JOIN BookCategory bc ON b.ISBN = bc.ISBN
JOIN Category c ON bc.idCategory = c.idCategory
WHERE c.label = 'Fantasy'
GROUP BY b.title, a.name 
HAVING AVG(r.star) > 3;

---#6
--- pentru fiecare editura sa se afiseze numele, adresa si numarul de carti publicate
--- >2 tabele, group by
SELECT p.name AS Publisher,p.website as Website, a.street AS Street, a.city AS City, a.country AS Country,    
COUNT(b.ISBN) AS TotalBooksPublished
FROM Publisher p
JOIN Address a ON p.idAddress = a.idAddress
LEFT JOIN Book b ON p.idPublisher = b.idPublisher
GROUP BY p.name,p.website, a.street, a.city, a.country;

---#7
---afiseaza numele autorilor care au publicat carti in categoria 'Fantasy'
---distinct, >2 tabele, where
SELECT DISTINCT a.name AS Author
FROM Author a
JOIN Book b ON a.idAuthor = b.idAuthor
JOIN BookCategory bc ON b.ISBN = bc.ISBN
JOIN Category c ON bc.idCategory = c.idCategory
WHERE c.label = 'Fantasy';

---#8
---afiseaza clientii (nume si adresa) care au mai mult de o comanda, impreuna cu nr de comenzi si suma cheltuita
---N-M (OrderB-OrderBook-Book), having
--- in plus: distinct, group by
SELECT 
    cl.name AS Client,
	a.street as Address,
    COUNT(ob.ISBN) AS TotalBooksOrdered,
    COUNT(DISTINCT o.idOrder) AS TotalOrders,
    SUM(b.price) AS TotalAmountSpent
FROM Client cl
JOIN Address a ON cl.idAddress = a.idAddress
JOIN OrderB o ON cl.idClient = o.idClient
JOIN OrderBook ob ON o.idOrder = ob.idOrder
JOIN Book b ON ob.ISBN = b.ISBN
GROUP BY cl.idClient, cl.name, a.street
HAVING COUNT(ob.ISBN) > 1;

---#9
---afiseaza recenziile tuturor cartilor din Classic Literature, numele si autorul
--- >2 tabele, (where)
SELECT b.title AS BookTitle, a.name AS AuthorName, r.text AS ReviewText
FROM Book b
JOIN Author a ON b.idAuthor = a.idAuthor
JOIN Review r ON b.ISBN = r.ISBN
JOIN BookCategory bc ON b.ISBN = bc.ISBN
JOIN Category c ON bc.idCategory = c.idCategory
WHERE c.label = 'Classic Literature';

---#10
--- pentru fiecare provider afiseaza cartile (titlu si editura) 
--- >2 tabele
SELECT pr.name AS ProviderName, b.title AS BookTitle, p.name AS PublisherName
FROM Provider pr
JOIN Book b ON pr.idProvider = b.idProvider
JOIN Publisher p ON b.idPublisher = p.idPublisher
ORDER BY pr.name, b.title;

