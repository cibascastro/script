https://www.c-sharpcorner.com/UploadFile/c1f7d5/how-to-recover-deleted-and-drop-data-and-tables-in-sql-serve/


SELECT  
[CURRENT LSN],      
OPERATION,  
[TRANSACTION ID],  
[BEGIN TIME],  
[TRANSACTION NAME],  
[TRANSACTION SID],  
ALLOCUNITNAME  
FROM  
FN_DBLOG (NULL, NULL)  
WHERE 
--ALLOCUNITNAME = 'CMI.TB_BASE_CORRECAO'
--AND 
--[TRANSACTION NAME] LIKE 'TRUNCATE%'
--AND 
[BEGIN TIME] >= '2018/11/12 00:00:00:000'


