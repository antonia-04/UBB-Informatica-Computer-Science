-- 1)
CREATE TABLE TipBursa (
	tipbursa_id INT PRIMARY KEY IDENTITY,
	nume VARCHAR(50),
	categorie VARCHAR(50),
	statut VARCHAR(50),
	nr_maxim_burse INT
);

CREATE TABLE Bursa (
	bursa_id INT PRIMARY KEY IDENTITY,
	tipbursa_id INT,
	denumire VARCHAR(50),
	student VARCHAR(50),
	an INT,
	valoare_lunara INT,
	facultate VARCHAR(50)
	CONSTRAINT fk_Bursa FOREIGN KEY (tipbursa_id) REFERENCES TipBursa(tipbursa_id) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM Bursa
SELECT * FROM TipBursa

-- 2)
SELECT TB.nume AS TIP_BURSA, COUNT(B.tipbursa_id) AS NUMAR_BENEFICIARI
FROM TipBursa TB
INNER JOIN Bursa B ON TB.tipbursa_id = B.tipbursa_id -- sau RIGHT JOIN
GROUP BY TB.nume
HAVING COUNT(B.tipbursa_id) >= 5
ORDER BY NUMAR_BENEFICIARI DESC;

-- 3)
SELECT AVG(B.valoare_lunara) AS BURSA_MEDIE_UTCN
FROM Bursa B
WHERE B.facultate LIKE 'UTCN';

-- 4)
GO
CREATE INDEX NCLSTR_IDX ON Bursa(valoare_lunara, facultate);
DROP INDEX NCLSTR_IDX ON Bursa;
