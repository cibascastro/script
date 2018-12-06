WAITFOR DELAY '00:00:20';
SET DEADLOCK_PRIORITY HIGH
IF OBJECT_ID('TEMPDB..#TMPWHO') IS NOT NULL DROP TABLE #TMPWHO
CREATE TABLE #TMPWHO
(SPID INT, ECID INT, STATUS VARCHAR(150), LOGINAME VARCHAR(150),
HOSTNAME VARCHAR(150), BLK INT, DBNAME VARCHAR(150), CMD VARCHAR(150), REQUESTID INT)
INSERT INTO #TMPWHO
EXEC SP_WHO
DECLARE @SPID INT
DECLARE @TSTRING VARCHAR(15)
DECLARE @GETSPID CURSOR
SET @GETSPID =   CURSOR FOR
SELECT SPID
FROM #TMPWHO
WHERE DBNAME IN  ('SISLAME_ES') AND LOGINAME IN ('SISLAMEES') 
OPEN @GETSPID
FETCH NEXT FROM @GETSPID INTO @SPID
WHILE @@FETCH_STATUS = 0
BEGIN
SET @TSTRING = 'KILL ' + CAST(@SPID AS VARCHAR(5))
EXEC(@TSTRING)
FETCH NEXT FROM @GETSPID INTO @SPID
END
CLOSE @GETSPID
DEALLOCATE @GETSPID
DROP TABLE #TMPWHO
GO 10000  