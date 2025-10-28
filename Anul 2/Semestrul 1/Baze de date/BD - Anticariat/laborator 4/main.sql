USE OnlineAntiqueBookStore
GO

-- CURSOR: parcurge randurile unui rezultat, util pt a efectua operatii individuale asupra fiecarui rand
--         pt a procesa secvential
--  @@FETCH_STATUS - 0 succes, 1 nu mai exisa randuri, 2 eroare


ALTER PROCEDURE Testare (@TestId INT)
AS
BEGIN
	---timp de start & finish
	DECLARE @start DATETIME, @finish DATETIME;
	---start now
	SET @start = GETDATE()


	--STERGERE din toate tabelele


	DECLARE @numeTabel VARCHAR(20);
	---cursor pt tabelele care vor fi sterse, se sterge in functie de Position

	DECLARE cursor_tabele CURSOR FAST_FORWARD FOR
	SELECT Tables.Name FROM TestTables
	INNER JOIN Tables ON TestTables.TableID = Tables.TableID 
	WHERE TestTables.TestID = @TestId 
	ORDER BY TestTables.Position;

	OPEN cursor_tabele;
	FETCH NEXT FROM cursor_tabele INTO @numeTabel;
	 
	---creeaza si executa delete pt fiecare tabel
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @operatie NVARCHAR(100);  
		SET @operatie = N'DELETE FROM [' + @numeTabel + N']'; 

		EXEC sp_executesql @operatie;

		FETCH NEXT FROM cursor_tabele INTO @numeTabel;
	END

	CLOSE cursor_tabele;
	DEALLOCATE cursor_tabele;



	--inserare 

	DECLARE @istart1 DATETIME, @istart2 DATETIME, @istart3 DATETIME, @istart4 DATETIME,
	@ifinish1 DATETIME, @ifinish2 DATETIME, @ifinish3 DATETIME, @ifinish4 DATETIME
	DECLARE @nrRows INT   -- nr randuri pt fiecare tabel
	DECLARE @idTabel INT  -- id tabel
	DECLARE @procedura VARCHAR(40)  -- nume procedura de inserare
	DECLARE @j INT = 1      --contor pt tabelul curent

	-- cursor pt a parcurge tabelele de inserare
	DECLARE cursor_tabele CURSOR FAST_FORWARD FOR
	SELECT Tables.Name,Tables.TableID, TestTables.NoOfRows FROM TestTables INNER JOIN Tables ON TestTables.TableID = Tables.TableID WHERE TestTables.TestID = @TestId ORDER BY TestTables.Position DESC;
	
	OPEN cursor_tabele;
	FETCH NEXT FROM cursor_tabele INTO @numeTabel, @idTabel, @nrRows
	WHILE @@FETCH_STATUS = 0
	BEGIN
		---masuram timpul de inceput
		IF @j = 1 SET @istart1 = GETDATE();
        IF @j = 2 SET @istart2 = GETDATE();
        IF @j = 3 SET @istart3 = GETDATE();

		SET @procedura = CONCAT('Insert',@numeTabel)
		EXEC @procedura @nrRows

		---face inserarile si masuram timpul de sfarsit
		IF @j = 1 SET @ifinish1 = GETDATE();
        IF @j = 2 SET @ifinish2 = GETDATE();
        IF @j = 3 SET @ifinish3 = GETDATE();

		SET @j = @j+1
		FETCH NEXT FROM cursor_tabele INTO @numeTabel,@idTabel, @nrRows;
	END
	CLOSE cursor_tabele;

	---executare views

	DECLARE @idView INT
	DECLARE @vstart1 DATETIME,@vstart2 DATETIME,@vstart3 DATETIME,
	@vfinish1 DATETIME, @vfinish2 DATETIME, @vfinish3 DATETIME
	SET @j = 1
	DECLARE @numeView VARCHAR(50);

	--- cursor pt view
	DECLARE cursor_view CURSOR FAST_FORWARD FOR
    SELECT Views.Name, Views.ViewID
    FROM TestViews 
    INNER JOIN Views ON TestViews.ViewID = Views.ViewID 
    WHERE TestViews.TestID = @TestId 

    OPEN cursor_view;
    FETCH NEXT FROM cursor_view INTO @numeView, @idView;
    
	WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @j = 1 SET @vstart1 = GETDATE();
        IF @j = 2 SET @vstart2 = GETDATE();
        IF @j = 3 SET @vstart3 = GETDATE();
        
        -- Executarea SELECT pentru fiecare view
        DECLARE @query VARCHAR(MAX);
        SET @query = 'SELECT * FROM ' + @numeView;
        EXEC sp_executesql @query;

        IF @j = 1 SET @vfinish1 = GETDATE();
        IF @j = 2 SET @vfinish2 = GETDATE();
        IF @j = 3 SET @vfinish3 = GETDATE();

		SET @j = @j+1
        FETCH NEXT FROM cursor_view INTO @numeView, @idView;
    END
    CLOSE cursor_view;


	---am incheiat operatiile

	SET @finish = GETDATE()


	---populare tabele cu informatii despre testare


	--tabel TestRuns
	DECLARE @TestRunID INT;
	INSERT INTO TestRuns (Description,StartAt,EndAt) VALUES ('Testare?',@start,@finish)
	SELECT @TestRunID = MAX(TestRunID) FROM TestRuns 


	--tabel TestRunTables
	SET @j = 1
	OPEN cursor_tabele;
	FETCH NEXT FROM cursor_tabele INTO @numeTabel, @idTabel, @nrRows
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @j = 1 
            INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt) 
            VALUES (@TestRunID, @idTabel, @istart1, @ifinish1);
        IF @j = 2 
            INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt) 
            VALUES (@TestRunID, @idTabel, @istart2, @ifinish2);
        IF @j = 3 
            INSERT INTO TestRunTables (TestRunID, TableID, StartAt, EndAt) 
            VALUES (@TestRunID, @idTabel, @istart3, @ifinish3);

		SET @j = @j+1
		FETCH NEXT FROM cursor_tabele INTO @numeTabel, @idTabel, @nrRows;
	END
	CLOSE cursor_tabele;
	DEALLOCATE cursor_tabele;

	--tabel TestRunViews
	
	SET @j = 1
	OPEN cursor_view;
	FETCH NEXT FROM cursor_view INTO @numeView,@idView
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @j = 1 
            INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) 
            VALUES (@TestRunID, @idView, @vstart1, @vfinish1);
        IF @j = 2 
            INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt) 
            VALUES (@TestRunID,  @idView, @vstart2, @vfinish2);
        IF @j = 3 
            INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt) 
            VALUES (@TestRunID,  @idView, @vstart3, @vfinish3);
		SET @j = @j+1
		FETCH NEXT FROM cursor_view INTO @numeView,@idView;
	END
	CLOSE cursor_view;
	DEALLOCATE cursor_view;

END	


EXEC Testare 1

SELECT * FROM TestRuns;
DELETE FROM TestRuns;

SELECT * FROM Book;
SELECT * FROM Category;
SELECT * FROM BookCategory;

DELETE FROM BookCategory;
DELETE FROM Category;
DELETE FROM Book;


SELECT * FROM TestRunTables;
SELECT * FROM TestRunViews;