--exec sp_addmessage -- ¯ADNE REKORDY NIE ULEG£Y ZMIANIE
--@msgnum = 70011,
--@severity = 10,
--@msgtext = 'TRIGGER HAS NOT DO ANY CHANGES',
--@with_log = 'true';
--GO



DROP DATABASE IF EXISTS hotel;
create database hotel;
use hotel;

DROP TABLE IF EXISTS klienci;
CREATE TABLE klienci(
	idklienci int IDENTITY(1,1)PRIMARY KEY NOT NULL,
	imie nvarchar (20) NULL,
	nazwisko nvarchar (20) NULL,
	nr_dowodu_osobistego varchar(9) NULL,
	)

DROP TABLE IF EXISTS wyzywienie
	CREATE TABLE wyzywienie(
	idwyzywienia int IDENTITY(1,1)PRIMARY KEY NOT NULL,
	rodzajwyzywienia varchar(20)NULL,
	dieta varchar(20)NULL,
	cena money NULL)

DROP TABLE IF EXISTS pokoje
	CREATE TABLE pokoje(
	idpokoje int IDENTITY(1,1)PRIMARY KEY NOT NULL,
	maxosob int NULL,
	oplata_doba money NULL);

DROP TABLE IF EXISTS mieszkaniec
	CREATE TABLE mieszkaniec(
	id_mieszkanca int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_klienta int,
	id_wyzywienia int
	FOREIGN KEY("id_klienta") REFERENCES "klienci"("idklienci"),
	FOREIGN KEY("id_wyzywienia") REFERENCES "wyzywienie"("idwyzywienia")
	)

	DROP TABLE IF EXISTS pobyt
	CREATE TABLE pobyt(
	id int IDENTITY(1,1)PRIMARY KEY NOT NULL,
	data_zameldowania datetime NULL,
	data_odmeldowania datetime NULL,
	id_pokoju int NULL,
	mieszkaniec1 int NULL,
	mieszkaniec2 int NULL,
	mieszkaniec3 int NULL,
	mieszkaniec4 int NULL,
	lacznaoplata money
	FOREIGN KEY("mieszkaniec1") REFERENCES "mieszkaniec"("id_mieszkanca"),
	FOREIGN KEY("mieszkaniec2") REFERENCES "mieszkaniec"("id_mieszkanca"),
	FOREIGN KEY("mieszkaniec3") REFERENCES "mieszkaniec"("id_mieszkanca"),
	FOREIGN KEY("mieszkaniec4") REFERENCES "mieszkaniec"("id_mieszkanca"),
	FOREIGN KEY("id_pokoju") REFERENCES "pokoje"("idpokoje")
	);

	

	DROP TABLE IF EXISTS pracownicy
	CREATE TABLE pracownicy(
	idpracownicy int IDENTITY(1,1)PRIMARY KEY NOT NULL,
	imie nvarchar(20) NULL,
	nazwisko nvarchar(20)NULL,
	data_urodzenia date NULL,
	data_zatrudnienia date NULL,
	stanowisko nvarchar(30)NULL,
	pensja money NULL)

	



	INSERT INTO klienci VALUES
	('Jan','Kowalski','DAS370267'),
	('Katarzyna','Kowalska','SET539790'),
	('Anna','Chojnacka','AMJ211892'),
	('Aleksandra','Zaj¹c','AMJ591444'),
	('Damian','Kania','OYK457501'),
	('Józef','Skiba','WLV630331'),
	('Leokadia','Kaczmarek','LBT759426')

	INSERT INTO wyzywienie VALUES
	('B&B','Standardowa',20.00),
	('B&B','Standardowa+',25.00),
	('B&B','Weganska',25.00),
	('B&B','Wegetarianska',25.00),
	('FB','Standardowa',60.00),
	('FB','Standardowa+',70.00),
	('FB','Wegetarianska',70.00)


	INSERT INTO mieszkaniec VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7)


	INSERT INTO pokoje VALUES
	(2, 80),
	(2, 80),
	(2, 80),
	(3, 100),
	(3, 100),
	(3, 100),
	(4, 120),
	(4, 120),
	(4, 120),
	(4, 120)

	INSERT INTO pracownicy VALUES
	('Witold','Nowak','1968-03-23','2020-09-10','Dyrektor', 5000),
	('Mikolaj','B¹k','1978-05-21','2020-09-10','Zastepca dyrektora', 4000),
	('Andzej','Szabla','1990-03-23','2020-09-10','Recepcjonista', 3000),
	('Janusz','Grzyb','1996-03-23','2020-09-10','Recepcjonista', 3000),
	('Maria','Kowalska','1999-03-23','2020-09-10','Pokojowa', 2800),
	('Anna','Kot','1998-03-23','2020-09-10','Pokojowa', 2800),
	('Krzysztof','Król','1990-03-23','2020-09-10','Pokojowy', 2800)

	INSERT INTO pobyt VALUES
	(CAST(N'2020-11-19T12:00:00.000'AS DateTime),CAST(N'2020-11-20T12:00:00.000'AS DateTime), 1, 1, 2,NULL,NULL, 120.00),
	(CAST(N'2020-11-19T12:00:00.000'AS DateTime),CAST(N'2020-11-21T12:00:00.000'AS DateTime), 1, 1, 2,NULL,NULL, 120.00),
	(CAST(N'2020-11-19T12:00:00.000'AS DateTime),CAST(N'2020-11-20T12:00:00.000'AS DateTime), 2, 3,NULL,NULL,NULL, 120.00),
	(CAST(N'2020-11-19T12:00:00.000'AS DateTime),CAST(N'2020-11-20T12:00:00.000'AS DateTime), 3, 4,NULL,NULL,NULL, 120.00),
	(CAST(N'2020-11-20T12:00:00.000'AS DateTime),CAST(N'2020-11-21T12:00:00.000'AS DateTime), 4, 5,NULL,NULL,NULL, 160.00),
	(CAST(N'2020-11-23T12:00:00.000'AS DateTime),CAST(N'2020-11-24T12:00:00.000'AS DateTime), 5, 6,NULL,NULL,NULL, 190.00),
	(CAST(N'2020-11-25T12:00:00.000'AS DateTime),CAST(N'2020-11-26T12:00:00.000'AS DateTime), 5, 7,NULL,NULL,NULL, 190.00)

GO

create trigger sprawdzNrDowodu 
on klienci
instead of insert
as
begin try
declare @nrdowodu varchar(9);
declare @checker int;
declare @cErrMsg NVARCHAR(2048);

set @checker = 1
set @nrdowodu =(select nr_dowodu_osobistego from inserted);


IF OBJECT_ID('tempdb..#tempTable')IS NOT NULL DROP TABLE #tempTable

create table #temptable(
litera varchar(1),
wartosc int
)

declare @i as int= 10;
declare @litera as int= 65;


while @i <=35
begin

insert into #temptable values(char(@litera), @i)

set @litera = @litera + 1;
set @i = @i + 1;

end


declare @litera1 char;
declare @litera2 char;
declare @litera3 char;

set @litera1 =SUBSTRING(@nrdowodu,1,1)
set @litera2 =SUBSTRING(@nrdowodu,2,1)
set @litera3 =SUBSTRING(@nrdowodu,3,1)

declare @wartosc1 int;
declare @wartosc2 int;
declare @wartosc3 int;

set @wartosc1 =(select wartosc from #temptable where litera = @litera1)
set @wartosc2 =(select wartosc from #temptable where litera = @litera2)
set @wartosc3 =(select wartosc from #temptable where litera = @litera3)

declare @wynik as int

declare @liczbakontrolna int;
set @liczbakontrolna =SUBSTRING(@nrdowodu,4,1)

set @wynik =(@wartosc1 * 7)+
			(@wartosc2 * 3)+
			(@wartosc3 )+
			(SUBSTRING(@nrdowodu,5,1)*7)+
			(SUBSTRING(@nrdowodu,6,1)*3)+
			(SUBSTRING(@nrdowodu,7,1)*1)+
			(SUBSTRING(@nrdowodu,8,1)*7)+
			(SUBSTRING(@nrdowodu,9,1)*3)


set @checker = @wynik % 10

IF(@checker = @liczbakontrolna)
BEGIN
BEGIN TRANSACTION;
insert into klienci select imie,nazwisko,nr_dowodu_osobistego from inserted;

COMMIT TRANSACTION;
END

else

BEGIN
BEGIN SET @cErrMsg='Nieprawid³owy nr dowodu osobistego'RAISERROR (@cErrMsg, 16, 1)WITH NOWAIT,SETERROR END
END

end try

begin catch
IF @@TRANCOUNT> 0
BEGIN
ROLLBACK TRANSACTION
END;

DECLARE @cErrMsg2 NVARCHAR(2048)
SET @cErrMsg2=ERROR_MESSAGE()
RAISERROR (@cErrMsg2, 16, 1)WITH NOWAIT,SETERROR

end catch;
GO

-- TRIGGER 
IF EXISTS (SELECT * FROM sys.triggers WHERE NAME= 'checkMieszkaniec' AND type='TR' AND is_instead_of_trigger=	1)
	DROP TRIGGER checkMieszkaniec
GO
CREATE TRIGGER checkMieszkaniec
ON mieszkaniec -- NA TABELI PRACOWNICY
INSTEAD OF UPDATE,INSERT -- INSERTA i DELETA
AS 

IF NOT EXISTS(SELECT idklienci FROM klienci,inserted WHERE idklienci=inserted.id_klienta)
BEGIN
RAISERROR(100000,16,1); -- Nie mozna zameldowac mieszkanca, ktory nie jest klientem
END
ELSE
BEGIN
IF NOT EXISTS(SELECT idwyzywienia FROM wyzywienie, inserted WHERE id_wyzywienia=inserted.id_wyzywienia)
BEGIN
RAISERROR(100010,16,1); -- Nie mozna zameldowac mieszkanca, ktory nie wybral opcji wyzywienia
END
ELSE
BEGIN
IF EXISTS(SELECT mieszkaniec.id_mieszkanca FROM mieszkaniec,inserted WHERE mieszkaniec.id_mieszkanca=inserted.id_mieszkanca)
BEGIN
RAISERROR(100020,16,1); -- Nie mozna dodac mieszkanca z podanym ID. Juz taki istnieje.
END
ELSE
BEGIN

IF EXISTS(SELECT * FROM deleted)
BEGIN
-- UPDATE
Update mieszkaniec SET id_klienta=(SELECT id_klienta FROM inserted), id_wyzywienia=(SELECT id_wyzywienia FROM inserted) WHERE id_mieszkanca=(SELECT id_mieszkanca FROm inserted);
END
ELSE
BEGIN
INSERT INTO mieszkaniec VALUES((SELECT id_klienta FROM inserted), (SELECT id_wyzywienia FROM inserted));
-- INSERT
END
END
END
END


-- PROCEDURY

-- USUWANIE PROCEDURY DO USUWANIA POBYTU
SET NOCOUNT, XACT_ABORT ON;
IF EXISTS (SELECT * FROM sys.procedures WHERE name= 'usunPobyt' AND type='P')
DROP PROCEDURE usunPobyt
GO
-- TWORZENIE PROCEDURY DO USUWANIA POBYTU
CREATE PROCEDURE usunPobyt(
@ID_USUWANEGO_POBYTU INT)
AS  
BEGIN TRY
SET NOCOUNT ON -- NIE ZWRACAJ INFORMACJI O ZMODYFIKOWANYCH REKORDACH
IF NOT EXISTS(SELECT id FROm pobyt WHERE pobyt.id=@ID_USUWANEGO_POBYTU)
BEGIN
RAISERROR(100030,16,1); -- Nie mozna usunac podanym z podanym ID. Taki nie istnieje.
END

BEGIN TRANSACTION; -- ROZPOCZÊCIE TRANSAKCJI
DELETE pobyt WHERE id=@ID_USUWANEGO_POBYTU;
COMMIT TRANSACTION;--COMMITOWANIE TRANSAKCJI
 END TRY -- KONIEC BLOKU ,,TRY"
 BEGIN CATCH -- ROZPOCZECIE BLOKU ,,CATCH"

       IF @@TRANCOUNT > 0 -- WARUNEK JE¯ELI ILOŒÆ PRZERWANYCH TRANSAKCJI JEST WIÊKSZA OD 0
       BEGIN
          ROLLBACK TRANSACTION -- TO ROLLBACKUJ TRANSAKCJE
       END;
	   
       	DECLARE @cErrMsg NVARCHAR(2048) -- DEKLARACJA ZMIENNEJ DO PRZECHOWYWANIA WIADOMOŒCI O B£ÊDZIE
		SET @cErrMsg= ERROR_MESSAGE() -- POBIERANIE ZG£OSZONEGO WCZEŒNIEJ B£ÊDU(JEŒLI WYST¥PI£ OCZYWIŒCIE)
		RAISERROR (@cErrMsg, 16, 1) WITH NOWAIT, SETERROR -- WYWO£YWANIE KOMUNIKATU O TYM B£ÊDZIE
		
    END CATCH; -- KONIEC INSTRUKCJI CATCH
SET NOCOUNT OFF;-- PRZYWROC INFORMOWANIE O ZMODYFIKOWANYCH REKORDACH
GO





-- USUWANIE PROCEDURY DO POKAZYWANIA POBYTU
SET NOCOUNT, XACT_ABORT ON;
IF EXISTS (SELECT * FROM sys.procedures WHERE name= 'pokazPobyty' AND type='P')
DROP PROCEDURE pokazPobyty
GO
-- TWORZENIE PROCEDURY DO POKAZYWANIA POBYTU
CREATE PROCEDURE pokazPobyty
AS  
BEGIN 
SET NOCOUNT ON -- NIE ZWRACAJ INFORMACJI O ZMODYFIKOWANYCH REKORDACH
BEGIN TRANSACTION; -- ROZPOCZÊCIE TRANSAKCJI
--SELECT data_zameldowania, data_odmeldowania, id_pokoju,(SELECT CONCAT(imie,' ',nazwisko)AS 'GOSC 1' FROM klienci JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci JOIN pobyt ON pobyt.mieszkaniec1=mieszkaniec.id_mieszkanca WHERE id_mieszkanca=mieszkaniec1),(SELECT CONCAT(imie,' ',nazwisko)AS 'GOSC 2' FROM klienci JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci JOIN pobyt ON pobyt.mieszkaniec2=mieszkaniec.id_mieszkanca WHERE id_mieszkanca=mieszkaniec2),(SELECT CONCAT(imie,' ',nazwisko)AS 'GOSC 3' FROM klienci JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci JOIN pobyt ON pobyt.mieszkaniec3=mieszkaniec.id_mieszkanca WHERE id_mieszkanca=mieszkaniec3),(SELECT CONCAT(imie,' ',nazwisko)AS 'GOSC 4' FROM klienci JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci JOIN pobyt ON pobyt.mieszkaniec4=mieszkaniec.id_mieszkanca WHERE id_mieszkanca=mieszkaniec4) FROM pobyt;

CREATE TABLE #tempTable(
id int IDENTITY(1,1)PRIMARY KEY NOT NULL,
	data_zameldowania datetime NULL,
	data_odmeldowania datetime NULL,
	id_pokoju int NULL,
	mieszkaniec1 varchar(50),
	mieszkaniec2 varchar(50),
	mieszkaniec3 varchar(50),
	mieszkaniec4 varchar(50),
	lacznaoplata money
)

DECLARE @IDK INT;
DECLARE my_cursor CURSOR FOR
SELECT id FROM pobyt

OPEN my_cursor
FETCH NEXT FROM my_cursor INTO @IDK

WHILE @@FETCH_STATUS=0
BEGIN
DECLARE @danepersonalne VARCHAR(50);
DECLARE @danepersonalne2 VARCHAR(50);
DECLARE @danepersonalne3 VARCHAR(50);
DECLARE @danepersonalne4 VARCHAR(50);

SET @danepersonalne= (SELECT CONCAT(imie,' ',nazwisko) FROM klienci
JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci
JOIN pobyt ON pobyt.mieszkaniec1=mieszkaniec.id_mieszkanca
WHERE pobyt.id=@IDK);


IF EXISTS(SELECT mieszkaniec2 FROM pobyt WHERE pobyt.id=@IDK)
BEGIN
SET @danepersonalne2= (SELECT CONCAT(imie,' ',nazwisko) FROM klienci
JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci
JOIN pobyt ON pobyt.mieszkaniec2=mieszkaniec.id_mieszkanca
WHERE pobyt.id=@IDK);
END
ELSE
BEGIN
SET @danepersonalne2='BRAK';
END

IF EXISTS(SELECT mieszkaniec3 FROM pobyt WHERE pobyt.id=@IDK)
BEGIN
SET @danepersonalne3= (SELECT CONCAT(imie,' ',nazwisko) FROM klienci
JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci
JOIN pobyt ON pobyt.mieszkaniec3=mieszkaniec.id_mieszkanca
WHERE pobyt.id=@IDK);
END
ELSE
BEGIN
SET @danepersonalne3='BRAK';
END



IF EXISTS(SELECT mieszkaniec4 FROM pobyt WHERE pobyt.id=@IDK)
BEGIN
SET @danepersonalne4= (SELECT CONCAT(imie,' ',nazwisko) FROM klienci
JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci
JOIN pobyt ON pobyt.mieszkaniec4=mieszkaniec.id_mieszkanca
WHERE pobyt.id=@IDK);
END
ELSE
BEGIN
SET @danepersonalne4='BRAK';
END

SET IDENTITY_INSERT #tempTable ON;
INSERT #tempTable(id,data_zameldowania,data_odmeldowania,id_pokoju,mieszkaniec1,mieszkaniec2,mieszkaniec3,mieszkaniec4,lacznaoplata) VALUES (@IDK,(SELECT data_zameldowania FROM pobyt WHERE pobyt.id=@IDK),(SELECT data_odmeldowania FROM pobyt WHERE pobyt.id=@IDK),(SELECT id_pokoju FROM pobyt WHERE pobyt.id=@IDK),@danepersonalne,@danepersonalne2,@danepersonalne3,@danepersonalne4, (SELECT lacznaoplata FROM pobyt WHERE pobyt.id=@IDK));
SET IDENTITY_INSERT #tempTable OFF;

FETCH NEXT FROM my_cursor INTO @IDK

END
CLOSE my_cursor
DEALLOCATE my_cursor

SELECT id,data_zameldowania,data_odmeldowania,id_pokoju,mieszkaniec1,mieszkaniec2,mieszkaniec3,mieszkaniec4,lacznaoplata FROM #tempTable


COMMIT TRANSACTION;--COMMITOWANIE TRANSAKCJI
END
SET NOCOUNT OFF;-- PRZYWROC INFORMOWANIE O ZMODYFIKOWANYCH REKORDACH
GO
GO
--SELECT * FROm pobyt;
--EXEC pokazPobyty 
--SELECT * FROM pobyt WHERE id=3;
--SELECT * FROM mieszkaniec 
--SELECT * FROM klienci


--SELECT CONCAT((SELECT data_zameldowania, data_odmeldowania, id_pokoju, CONCAT(imie,' ',nazwisko)AS 'GOSC 1' FROM pobyt
--JOIN mieszkaniec ON mieszkaniec.id_mieszkanca=mieszkaniec1
--JOIN klienci ON klienci.idklienci=mieszkaniec.id_klienta),' ',(SELECT DISTINCT CONCAT(imie,' ',nazwisko)AS 'GOSC 2' FROM pobyt
--JOIN mieszkaniec ON mieszkaniec.id_mieszkanca=mieszkaniec2
--JOIN klienci ON klienci.idklienci=mieszkaniec.id_klienta),' ',(SELECT DISTINCT CONCAT(imie,' ',nazwisko)AS 'GOSC 3' FROM pobyt
--JOIN mieszkaniec ON mieszkaniec.id_mieszkanca=mieszkaniec3
--JOIN klienci ON klienci.idklienci=mieszkaniec.id_klienta),' ',(SELECT DISTINCT CONCAT(imie,' ',nazwisko)AS 'GOSC 4' FROM pobyt
--JOIN mieszkaniec ON mieszkaniec.id_mieszkanca=mieszkaniec4
--JOIN klienci ON klienci.idklienci=mieszkaniec.id_klienta) )FROM pobyt


--,(SELECT CONCAT(imie,' ',nazwisko)AS 'GOSC 2' FROM klienci JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci JOIN pobyt ON pobyt.mieszkaniec2=mieszkaniec.id_mieszkanca WHERE id_mieszkanca=mieszkaniec2),(SELECT CONCAT(imie,' ',nazwisko)AS 'GOSC 3' FROM klienci JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci JOIN pobyt ON pobyt.mieszkaniec3=mieszkaniec.id_mieszkanca WHERE id_mieszkanca=mieszkaniec3),(SELECT CONCAT(imie,' ',nazwisko)AS 'GOSC 4' FROM klienci JOIN mieszkaniec ON mieszkaniec.id_klienta=klienci.idklienci JOIN pobyt ON pobyt.mieszkaniec4=mieszkaniec.id_mieszkanca WHERE id_mieszkanca=mieszkaniec4) FROM pobyt;




-- USUWANIE PROCEDURY DO DODAWANIA POBYTU
SET NOCOUNT, XACT_ABORT ON;
IF EXISTS (SELECT * FROM sys.procedures WHERE name= 'DodajPobyt' AND type='P')
DROP PROCEDURE DodajPobyt
GO
-- TWORZENIE PROCEDURY DO USUWANIA POBYTU
CREATE PROCEDURE DodajPobyt(
@DATA_ZAMELDOWANIA DATE,
@DATA_ODMELDOWANIA DATE,
@ID_POKOJU INT,
@m1 INT,
@m2 INT,
@m3 INT,
@m4 INT,
@oplata MONEY)
AS  
BEGIN TRY
SET NOCOUNT ON -- NIE ZWRACAJ INFORMACJI O ZMODYFIKOWANYCH REKORDACH

IF NOT EXISTS(SELECT idpokoje FROm pokoje WHERE pokoje.idpokoje=@ID_POKOJU)
BEGIN
RAISERROR(100030,16,1); -- POKOJ Z PODANYM ID NIE ISTNIEJE
END

IF @DATA_ZAMELDOWANIA=''
BEGIN
SET @DATA_ZAMELDOWANIA=GETDATE();
END

IF @m1='' AND @m2='' AND @m3='' AND @m4=''
BEGIN
RAISERROR(10040,16,1); -- NIE MOZNA WPROWADZIC POBYTU BEZ CO NAJMNIEJ 1 MIESZKANCA
END

IF @DATA_ODMELDOWANIA<@DATA_ZAMELDOWANIA
BEGIN
RAISERROR(10050,16,1); -- DATA ODMELDOWANIA NIE MO¯E WYSTÊPOWAÆ PRZED DAT¥ WPROWADZENIA SIÊ.
END

IF @DATA_ODMELDOWANIA=''
BEGIN
RAISERROR(10060,16,1); -- NIE OBSLUGUJEMY WYNAJMOW DO CZASU NIEOKRESLONEGO. PODAJ DATE ODMELDOWANIA.
END

DECLARE @LICZBA_GOSCI INT
SET @LICZBA_GOSCI=0;

IF @m1 != ''
BEGIN
SET @LICZBA_GOSCI=@LICZBA_GOSCI+1;
END

IF @m2 != ''
BEGIN
SET @LICZBA_GOSCI=@LICZBA_GOSCI+1;
END

IF @m3 != ''
BEGIN
SET @LICZBA_GOSCI=@LICZBA_GOSCI+1;
END

IF @m4 != ''
BEGIN
SET @LICZBA_GOSCI=@LICZBA_GOSCI+1;
END

IF @LICZBA_GOSCI>(SELECT maxosob FROM pokoje WHERE idpokoje=@ID_POKOJU)
BEGIN
RAISERROR(10070,16,1); -- LICZBA GOSCI PRZEKRACZA LICZBE DOSTEPNYCH MIEJSC W PODANYM POKOJU
END

IF @oplata<=0
BEGIN
RAISERROR(10080,16,1); -- NIE PRACUJEMY ZA DARMO, WPROWADZ poprawna wartosc oplaty za wynajem
END

BEGIN TRANSACTION; -- ROZPOCZÊCIE TRANSAKCJI

INSERT INTO pobyt VALUES (@DATA_ZAMELDOWANIA,@DATA_ODMELDOWANIA,@ID_POKOJU,@m1,@m2,@m3,@m4,@oplata);

COMMIT TRANSACTION;--COMMITOWANIE TRANSAKCJI
 END TRY -- KONIEC BLOKU ,,TRY"
 BEGIN CATCH -- ROZPOCZECIE BLOKU ,,CATCH"

       IF @@TRANCOUNT > 0 -- WARUNEK JE¯ELI ILOŒÆ PRZERWANYCH TRANSAKCJI JEST WIÊKSZA OD 0
       BEGIN
          ROLLBACK TRANSACTION -- TO ROLLBACKUJ TRANSAKCJE
       END;
	   
       	DECLARE @cErrMsg NVARCHAR(2048) -- DEKLARACJA ZMIENNEJ DO PRZECHOWYWANIA WIADOMOŒCI O B£ÊDZIE
		SET @cErrMsg= ERROR_MESSAGE() -- POBIERANIE ZG£OSZONEGO WCZEŒNIEJ B£ÊDU(JEŒLI WYST¥PI£ OCZYWIŒCIE)
		RAISERROR (@cErrMsg, 16, 1) WITH NOWAIT, SETERROR -- WYWO£YWANIE KOMUNIKATU O TYM B£ÊDZIE
		
    END CATCH; -- KONIEC INSTRUKCJI CATCH
SET NOCOUNT OFF;-- PRZYWROC INFORMOWANIE O ZMODYFIKOWANYCH REKORDACH
GO


-- USUWANIE PROCEDURY DO AKTUALIZOWANIA POBYTU
SET NOCOUNT, XACT_ABORT ON;
IF EXISTS (SELECT * FROM sys.procedures WHERE name= 'ZaaktualizujPobyt' AND type='P')
DROP PROCEDURE ZaaktualizujPobyt
GO
-- TWORZENIE PROCEDURY DO AKTUALIZOWANIA POBYTU
CREATE PROCEDURE ZaaktualizujPobyt(
@DATA_ZAMELDOWANIA DATE,
@DATA_ODMELDOWANIA DATE,
@ID_POKOJU INT,
@m1 INT,
@m2 INT,
@m3 INT,
@m4 INT,
@oplata MONEY,
@ID_UPDATE INT)
AS  
BEGIN TRY
SET NOCOUNT ON -- NIE ZWRACAJ INFORMACJI O ZMODYFIKOWANYCH REKORDACH

IF NOT EXISTS (SELECT id FROM pobyt WHERE id=@ID_UPDATE)
BEGIN
RAISERROR(10090,16,1); -- NIE ODNALEZIONO POBYTU, KTORY PROBUJESZ ZAAKTUALIZOWAC
END

IF NOT EXISTS(SELECT idpokoje FROm pokoje WHERE pokoje.idpokoje=@ID_POKOJU)
BEGIN
RAISERROR(100030,16,1); -- POKOJ Z PODANYM ID NIE ISTNIEJE
END

IF @DATA_ZAMELDOWANIA=''
BEGIN
SET @DATA_ZAMELDOWANIA=GETDATE();
END

IF @m1='' AND @m2='' AND @m3='' AND @m4=''
BEGIN
RAISERROR(10040,16,1); -- NIE MOZNA WPROWADZIC POBYTU BEZ CO NAJMNIEJ 1 MIESZKANCA
END

IF @DATA_ODMELDOWANIA<@DATA_ZAMELDOWANIA
BEGIN
RAISERROR(10050,16,1); -- DATA ODMELDOWANIA NIE MO¯E WYSTÊPOWAÆ PRZED DAT¥ WPROWADZENIA SIÊ.
END

IF @DATA_ODMELDOWANIA=''
BEGIN
RAISERROR(10060,16,1); -- NIE OBSLUGUJEMY WYNAJMOW DO CZASU NIEOKRESLONEGO. PODAJ DATE ODMELDOWANIA.
END

DECLARE @LICZBA_GOSCI INT
SET @LICZBA_GOSCI=0;

IF @m1 != ''
BEGIN
SET @LICZBA_GOSCI=@LICZBA_GOSCI+1;
END

IF @m2 != ''
BEGIN
SET @LICZBA_GOSCI=@LICZBA_GOSCI+1;
END

IF @m3 != ''
BEGIN
SET @LICZBA_GOSCI=@LICZBA_GOSCI+1;
END

IF @m4 != ''
BEGIN
SET @LICZBA_GOSCI=@LICZBA_GOSCI+1;
END

IF @LICZBA_GOSCI>(SELECT maxosob FROM pokoje WHERE idpokoje=@ID_POKOJU)
BEGIN
RAISERROR(10070,16,1); -- LICZBA GOSCI PRZEKRACZA LICZBE DOSTEPNYCH MIEJSC W PODANYM POKOJU
END

IF @oplata<=0
BEGIN
RAISERROR(10080,16,1); -- NIE PRACUJEMY ZA DARMO, WPROWADZ poprawna wartosc oplaty za wynajem
END

BEGIN TRANSACTION; -- ROZPOCZÊCIE TRANSAKCJI

UPDATE pobyt SET data_zameldowania=@DATA_ZAMELDOWANIA, data_odmeldowania=@DATA_ODMELDOWANIA, id_pokoju=@ID_POKOJU, mieszkaniec1=@m1, mieszkaniec2=@m2, mieszkaniec3=@m3, mieszkaniec4=@m4, lacznaoplata=@oplata WHERE id=@ID_UPDATE;

COMMIT TRANSACTION;--COMMITOWANIE TRANSAKCJI
 END TRY -- KONIEC BLOKU ,,TRY"
 BEGIN CATCH -- ROZPOCZECIE BLOKU ,,CATCH"

       IF @@TRANCOUNT > 0 -- WARUNEK JE¯ELI ILOŒÆ PRZERWANYCH TRANSAKCJI JEST WIÊKSZA OD 0
       BEGIN
          ROLLBACK TRANSACTION -- TO ROLLBACKUJ TRANSAKCJE
       END;
	   
       	DECLARE @cErrMsg NVARCHAR(2048) -- DEKLARACJA ZMIENNEJ DO PRZECHOWYWANIA WIADOMOŒCI O B£ÊDZIE
		SET @cErrMsg= ERROR_MESSAGE() -- POBIERANIE ZG£OSZONEGO WCZEŒNIEJ B£ÊDU(JEŒLI WYST¥PI£ OCZYWIŒCIE)
		RAISERROR (@cErrMsg, 16, 1) WITH NOWAIT, SETERROR -- WYWO£YWANIE KOMUNIKATU O TYM B£ÊDZIE
		
    END CATCH; -- KONIEC INSTRUKCJI CATCH
SET NOCOUNT OFF;-- PRZYWROC INFORMOWANIE O ZMODYFIKOWANYCH REKORDACH
GO

--EXEC DodajPobyt '2020-01-01','2020-01-03',3,3,null,null,5,100
--EXEC pokazPobyty
--EXEC ZaaktualizujPobyt '2020-01-01','2020-01-03',3,3,null,null,5,1009,1
--EXEC pokazPobyty





-- ADDITIONAL PROCEDURES

-- USUWANIE PROCEDURY DO POKAZYWANIA POKOI
SET NOCOUNT, XACT_ABORT ON;
IF EXISTS (SELECT * FROM sys.procedures WHERE name= 'pokazPokoje' AND type='P')
DROP PROCEDURE pokazPokoje
GO
-- TWORZENIE PROCEDURY DO POKAZYWANIA POKOI
CREATE PROCEDURE pokazPokoje
AS  
BEGIN 
SET NOCOUNT ON -- NIE ZWRACAJ INFORMACJI O ZMODYFIKOWANYCH REKORDACH
BEGIN TRANSACTION; -- ROZPOCZÊCIE TRANSAKCJI
SELECT idpokoje AS 'ID POKOJU', maxosob AS 'MAKSYMALNA ILOSC OSOB W POKOJU' FROM pokoje
COMMIT TRANSACTION;--COMMITOWANIE TRANSAKCJI
END
SET NOCOUNT OFF;-- PRZYWROC INFORMOWANIE O ZMODYFIKOWANYCH REKORDACH
GO
GO

-- USUWANIE PROCEDURY DO POKAZYWANIA MIESZKANCOW
SET NOCOUNT, XACT_ABORT ON;
IF EXISTS (SELECT * FROM sys.procedures WHERE name= 'pokazMieszkancow' AND type='P')
DROP PROCEDURE pokazMieszkancow
GO
-- TWORZENIE PROCEDURY DO POKAZYWANIA MIESZKANCOW
CREATE PROCEDURE pokazMieszkancow
AS  
BEGIN 
SET NOCOUNT ON -- NIE ZWRACAJ INFORMACJI O ZMODYFIKOWANYCH REKORDACH
BEGIN TRANSACTION; -- ROZPOCZÊCIE TRANSAKCJI

SELECT id_mieszkanca, CONCAT(imie,' ',nazwisko) AS 'KLIENT', CONCAT('[',rodzajwyzywienia,'] - ',dieta) AS 'WYZYWIENIE'  FROM mieszkaniec JOIN klienci ON klienci.idklienci=mieszkaniec.id_klienta JOIN wyzywienie ON wyzywienie.idwyzywienia=mieszkaniec.id_wyzywienia

COMMIT TRANSACTION;--COMMITOWANIE TRANSAKCJI
END
SET NOCOUNT OFF;-- PRZYWROC INFORMOWANIE O ZMODYFIKOWANYCH REKORDACH
GO
GO

EXEC pokazMieszkancow
EXEC pokazPokoje
EXEC pokazPobyty


--SELECT * FROM klienci
--SELECT * FROm mieszkaniec
--SELECT * FROM pobyt
--SELECT * FROM pokoje
--SELECT * FROM pracownicy
--SELECT * FROm wyzywienie




