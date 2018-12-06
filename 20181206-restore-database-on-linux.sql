RESTORE DATABASE AdventureWorks2014
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2014.bak'
WITH MOVE N'AdventureWorks2014_Data' TO '/var/opt/mssql/data/AdventureWorks2014_data.mdf',
     MOVE N'AdventureWorks2014_log' TO '/var/opt/mssql/data/AdventureWorks2014_log.ldf'