use OnlineAntiqueBookStore
go


CREATE TABLE Version (
    versionNo INT PRIMARY KEY,
    modificationDate DATE DEFAULT GETDATE()
);

INSERT INTO Version (versionNo) VALUES (0);
GO

--Versiunea 1: modificarea tipului unei coloane
CREATE PROCEDURE do_version1 AS
BEGIN
    ALTER TABLE OrderB ALTER COLUMN status NVARCHAR(25);
    PRINT 'Coloana status din tabelul OrderB a fost modificata la NVARCHAR(25)';
    UPDATE Version SET versionNo = 1 WHERE versionNo = 0;
END;
GO

CREATE PROCEDURE undo_version1 AS
BEGIN
    ALTER TABLE OrderB ALTER COLUMN status VARCHAR(25);
    PRINT 'Coloana status din tabelul OrderB a revenit la VARCHAR(25)';
    UPDATE Version SET versionNo = 0 WHERE versionNo = 1;
END;
GO

--Versiunea 2: adaugare constrangere DEFAULT
CREATE PROCEDURE do_version2 AS
BEGIN
    ALTER TABLE OrderB ADD CONSTRAINT df_status DEFAULT 'Pending' FOR status;
    PRINT 'Valoarea implicita pentru coloana status din OrderB a fost setata la "Pending"';
    UPDATE Version SET versionNo = 2 WHERE versionNo = 1;
END;
GO

CREATE PROCEDURE undo_version2 AS
BEGIN
    ALTER TABLE OrderB DROP CONSTRAINT df_status;
    PRINT 'Valoarea implicita pentru coloana status din OrderB a fost eliminata';
    UPDATE Version SET versionNo = 1 WHERE versionNo = 2;
END;
GO

--Versiunea 3: tabela noua
CREATE PROCEDURE do_version3 AS
BEGIN
    CREATE TABLE Shipper (
        idShipper INT PRIMARY KEY IDENTITY(1,1),
        name NVARCHAR(80) NOT NULL,
        contactPhone VARCHAR(15),
        idAddress INT FOREIGN KEY REFERENCES Address(idAddress)
    );
    PRINT 'Tabelul Shipper a fost creat';
    UPDATE Version SET versionNo = 3 WHERE versionNo = 2;
END;
GO

CREATE PROCEDURE undo_version3 AS
BEGIN
    DROP TABLE Shipper;
    PRINT 'Tabelul Shipper a fost sters';
    UPDATE Version SET versionNo = 2 WHERE versionNo = 3;
END;
GO

--Versiunea 4: adaugare camp nou (adaugam in tabela noua)
CREATE PROCEDURE do_version4 AS
BEGIN
	ALTER TABLE Shipper ADD email NVARCHAR(50);
	PRINT 'Coloana email a fost adaugata in tabelul Shipper';
	UPDATE Version SET versionNo = 4 WHERE versionNo = 3;
END;
GO

CREATE PROCEDURE undo_version4 AS
BEGIN
	ALTER TABLE Shipper DROP COLUMN email;
	PRINT 'Coloana email din tabelul Shipper a fost stearsa';
	UPDATE Version SET versionNo = 3 WHERE versionNo = 4;
END;
GO
--Versiunea 5: constrangere cheie straina
CREATE PROCEDURE do_version5 AS
BEGIN
	ALTER TABLE Shipper 
    ADD idOrder INT CONSTRAINT fk_Shipper_OrderB_idOrder FOREIGN KEY REFERENCES OrderB(idOrder);
    PRINT 'Cheia straina idOrder a fost adaugata în tabelul Shipper';
    UPDATE Version SET versionNo = 5 WHERE versionNo = 4;
END;
GO

CREATE PROCEDURE undo_version5 AS
BEGIN
    ALTER TABLE Shipper DROP CONSTRAINT fk_Shipper_OrderB_idOrder;
    PRINT 'Cheia straina idOrder din tabelul Shipper a fost eliminata';
    UPDATE Version SET versionNo = 4 WHERE versionNo = 5;
END;
GO

ALTER TABLE Version ADD totalVersions INT DEFAULT 5;
go
ALTER TABLE Version drop column totalVersions;
go

CREATE PROCEDURE main @target_version INT 
AS
BEGIN
    DECLARE @current_version INT;
    DECLARE @total_versions INT;
    DECLARE @procedure_name NVARCHAR(50);  -- nume procedura

    SELECT @current_version = versionNo, @total_versions = totalVersions FROM Version;

    IF @target_version < 0 OR @target_version > @total_versions
    BEGIN
        PRINT 'Versiune invalida. Alegeti intre 0 si ' + CAST(@total_versions AS VARCHAR(10)) + '.';
        RETURN;
    END

	--upgrade
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

SELECT * from Version;


EXEC main @target_version = 0;


DROP PROCEDURE IF EXISTS do_version5;
DROP PROCEDURE IF EXISTS undo_version5;
DROP PROCEDURE IF EXISTS main;