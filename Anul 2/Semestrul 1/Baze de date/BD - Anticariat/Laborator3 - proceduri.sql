USE OnlineAntiqueBookStore;
GO

CREATE TABLE Version (
    versionNo INT PRIMARY KEY,    
    totalVersions INT             
);

INSERT INTO Version (versionNo, totalVersions) VALUES (0, 5);
GO
-- Versiunea 1: modificarea tip o coloana
CREATE PROCEDURE do_version1 AS
BEGIN
    ALTER TABLE OrderB ALTER COLUMN status NVARCHAR(25);
    PRINT 'Coloana status din tabelul OrderB a fost modificata la NVARCHAR(25)';
END;
GO

CREATE PROCEDURE undo_version1 AS
BEGIN
    ALTER TABLE OrderB ALTER COLUMN status VARCHAR(25);
    PRINT 'Coloana status din tabelul OrderB a revenit la VARCHAR(25)';
END;
GO

-- Versiunea 2: adaugare constrangere DEFAULT pentru un camp
CREATE PROCEDURE do_version2 AS
BEGIN
    ALTER TABLE OrderB ADD CONSTRAINT df_status DEFAULT 'Pending' FOR status;
    PRINT 'Valoarea implicita pentru coloana status din OrderB a fost setata la "Pending"';
END;
GO

CREATE PROCEDURE undo_version2 AS
BEGIN
    ALTER TABLE OrderB DROP CONSTRAINT df_status;
    PRINT 'Valoarea implicita pentru coloana status din OrderB a fost eliminata';
END;
GO

-- Versiunea 3: creare tabel nou & stergere tabel
CREATE PROCEDURE do_version3 AS
BEGIN
    CREATE TABLE Shipper (
        idShipper INT PRIMARY KEY IDENTITY(1,1),
        name NVARCHAR(80) NOT NULL,
        contactPhone VARCHAR(15),
        idAddress INT FOREIGN KEY REFERENCES Address(idAddress)
    );
    PRINT 'Tabelul Shipper a fost creat';
END;
GO

CREATE PROCEDURE undo_version3 AS
BEGIN
    DROP TABLE Shipper;
    PRINT 'Tabelul Shipper a fost sters';
END;
GO

-- Versiunea 4: adaugare un camp nou
CREATE PROCEDURE do_version4 AS
BEGIN
    ALTER TABLE Shipper ADD email NVARCHAR(50);
    PRINT 'Coloana email a fost adaugata in tabelul Shipper';
END;
GO

CREATE PROCEDURE undo_version4 AS
BEGIN
    ALTER TABLE Shipper DROP COLUMN email;
    PRINT 'Coloana email din tabelul Shipper a fost stearsa';
END;
GO

-- Versiunea 5: adaugare constrangere cheie straina 
CREATE PROCEDURE do_version5 AS
BEGIN
    ALTER TABLE Shipper 
    ADD idOrder INT CONSTRAINT fk_Shipper_OrderB_idOrder FOREIGN KEY REFERENCES OrderB(idOrder);
    PRINT 'Cheia straina fk_Shipper_OrderB_idOrder a fost adaugata in tabelul Shipper';
END;
GO

CREATE PROCEDURE undo_version5 AS
BEGIN
    ALTER TABLE Shipper DROP CONSTRAINT fk_Shipper_OrderB_idOrder;
    PRINT 'Cheia straina fk_Shipper_OrderB_idOrder din tabelul Shipper a fost eliminata';
END;
GO

CREATE PROCEDURE main @target_version INT 
AS
BEGIN
    DECLARE @current_version INT;
    DECLARE @total_versions INT;      
    DECLARE @procedure_name NVARCHAR(50); 

    SELECT @current_version = versionNo, @total_versions = totalVersions FROM Version;

    IF @target_version < 0 OR @target_version > @total_versions
    BEGIN
        PRINT 'Versiune invalida. Alegeti intre 0 si ' + CAST(@total_versions AS VARCHAR(10)) + '.';
        RETURN;
    END

    -- upgrade
    IF @current_version < @target_version
    BEGIN
        WHILE @current_version < @target_version
        BEGIN
            SET @current_version = @current_version + 1;
            SET @procedure_name = 'do_version' + CAST(@current_version AS NVARCHAR(10));
            EXEC (@procedure_name);
            UPDATE Version SET versionNo = @current_version;
        END
    END

    -- downgrade
    ELSE IF @current_version > @target_version
    BEGIN
        WHILE @current_version > @target_version
        BEGIN
            SET @procedure_name = 'undo_version' + CAST(@current_version AS NVARCHAR(10));
            EXEC (@procedure_name);
            SET @current_version = @current_version - 1;
            UPDATE Version SET versionNo = @current_version;
        END
    END
    ELSE
    BEGIN
        PRINT 'Baza de date este deja la versiunea ceruta.';
    END
END;
GO

SELECT * FROM Version;
GO

-- rulare 
EXEC main @target_version = 20;



DROP PROCEDURE IF EXISTS do_version1, undo_version1, do_version2, undo_version2,
                      do_version3, undo_version3, do_version4, undo_version4,
                      do_version5, undo_version5, main;
GO
