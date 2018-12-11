Clear-Host

################################
########## PARAMETERS ##########
################################ 

$SFTPIP         = '192.168.20.14'
$SFTPPort       = '6798'
$SFTPPath       = '/BKP-CAEDDC02DB02/'
$systemDatabase = 'S:\CL01-INST02-BACKUP\SYSTEM_DATABASES'
$currentYear    = (Get-Date).Year
$numberMonth    =  Get-Date -UFormat %m
$currentMonth   = (Get-Culture).DateTimeFormat.GetMonthName($numberMonth)
$fullPath       = "$systemDatabase\$currentYear\$currentMonth\"

# database Intraction
$SQLServer = "DBSERVER02\DBSERVER02" #use Server\Instance for named SQL instances!

Clear
Write-Host "========================================================================================================================================================"
Write-Host "== Used parameters =="
Write-Host "========================================================================================================================================================"
Write-Host "Server Name             :" $SQLServer
Write-Host "SFTP                    :" $SFTPIP
Write-Host "SFTP Path               :" $SFTPPath
Write-Host "Backup Path             :" $fullPath
Write-Host "========================================================================================================================================================"



# CRIA AS CREDENCIAIS DE ACESSO PARA O SFTP
$UserName = "seu-usuario"
$SecurePassword = "sua-senha" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword

# ABRE A SESSAO NO SFTP
$Session = New-SFTPSession -ComputerName $SFTPIP -Port $SFTPPort -Credential $Credentials

# VERIFICA SE O ARQUIVO EXISTE
$fileExistsServidores = Get-SFTPChildItem -SFTPSession $Session  -Path $SFTPPath -Recursive | Select-Object FullName | where-Object FullName -like "*Servidores.txt"
$fileExistsVinculos   = Get-SFTPChildItem -SFTPSession $Session  -Path $SFTPPath -Recursive | Select-Object FullName | where-Object FullName -like "*Vinculos.txt"

$a = ($fileExistsServidores | Measure-Object).Count
$b = ($fileExistsVinculos | Measure-Object).Count

#Write-Output $a
#Write-Output $b

# ARQUIVO SERVIDORES
if ($a -eq 1)  {    
    Write-Output "Arquivo Servidores existe e sera transferido para o servidor de banco de dados."   
    # DOWNLOAD ARQUIVO   
    Get-SFTPFile -SFTPSession $Session -RemoteFile "/SIARES/SIARES/Servidores.txt" -LocalPath $databasePath -Overwrite -NoProgress 
}   
else  {      
    Write-Output "O arquivo Servidores nao existe no SFTP. Operacao sera abortada."
}

# ARQUIVO VINCULO
if ($b -eq 1)  {    
    Write-Output "Arquivo Vinculo existe e sera transferido para o servidor de banco de dados."   
    # DOWNLOAD ARQUIVO   
    Get-SFTPFile -SFTPSession $Session -RemoteFile "/SIARES/SIARES/Vinculos.txt" -LocalPath $databasePath -Overwrite -NoProgress    
   
}   
else  {      
    Write-Output "O arquivo Vinculo nao existe no SFTP. Operacao sera abortada." 

}




#End :database Intraction
#Clear-Host


##########################################




# Get current Month
$systemDatabase         = 'S:\CL01-INST02-BACKUP\SYSTEM_DATABASES'
$currentYear            = (Get-Date).Year
$numerMonth             =  Get-Date -UFormat %m
$currentMonth           = (Get-Culture).DateTimeFormat.GetMonthName($numerMonth)
$fullPathSystemDatabase = "$systemDatabase\$currentYear\$currentMonth\FULL"

Write-Host $fullPathSystemDatabase

#Get-ChildItem $fullPathSystemDatabase

# pega o arquivo de backup de ontem
@(Get-ChildItem $fullPathSystemDatabase\*.* -Recurse | Where {$_.Extension -eq '.bak' -and $_.LastWriteTime -ge (Get-Date).AddDays(-1)}) | Select-Object FullName |

ForEach-Object {
    $_.FullName

}

###############################################

Clear-Host

################################
########## PARAMETERS ##########
################################ 

$SFTPIP         = '192.168.20.14'
$SFTPPort       = '6798'
$SFTPPath       = '/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/'
$systemDatabase = 'S:\CL01-INST02-BACKUP\SYSTEM_DATABASES'
$currentYear    = (Get-Date).Year
$numberMonth     =  Get-Date -UFormat %m
$currentMonth   = (Get-Culture).DateTimeFormat.GetMonthName($numberMonth)
$fullPath       = "$systemDatabase\$currentYear\$currentMonth\"

# database Intraction
$SQLServer = "DBSERVER02\DBSERVER02" #use Server\Instance for named SQL instances!

Clear
Write-Host "========================================================================================================================================================"
Write-Host "== Used parameters =="
Write-Host "========================================================================================================================================================"
Write-Host "Server Name             :" $SQLServer
Write-Host "SFTP                    :" $SFTPIP
Write-Host "SFTP Path               :" $SFTPPath
Write-Host "Backup Path             :" $fullPath
Write-Host "========================================================================================================================================================"



# CRIA AS CREDENCIAIS DE ACESSO PARA O SFTP
$UserName = "caedbackup"
$SecurePassword = "caedbackup@caed.2013" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword

# ABRE A SESSAO NO SFTP
$Session = New-SFTPSession -ComputerName $SFTPIP -Port $SFTPPort -Credential $Credentials


#Copy-Item -Path "/S:/CL01-INST02-BACKUP/SYSTEM_DATABASES/2018/OCTOBER/FULL/model/model_20181006230.BAK" -Destination "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/" -ToSession $Session

#Get-SFTPFile -SFTPSession $Session -LocalPath "S:\CL01-INST02-BACKUP\SYSTEM_DATABASES\2018\OCTOBER\FULL\model\model_20181006230.BAK" -LocalPath "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/" -Overwrite -NoProgress 


Get-SFTPFile -SFTPSession $Session -LocalPathFile "/S:/CL01-INST02-BACKUP/SYSTEM_DATABASES/2018/OCTOBER/FULL/model/model_20181006230.BAK" -RemotePath "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/" -Overwrite -NoProgress 


#Write-Host $fileExistsServidores


#######################################

Clear-Host

################################
########## PARAMETERS ##########
################################ 

# Get current Month
$systemDatabase         = 'S:\CL01-INST02-BACKUP\SYSTEM_DATABASES'
$currentYear            = (Get-Date).Year
$numerMonth             =  Get-Date -UFormat %m
$currentMonth           = (Get-Culture).DateTimeFormat.GetMonthName($numerMonth)
$fullPathSystemDatabase = "$systemDatabase\$currentYear\$currentMonth\FULL"

# Path SFTP
$sftpPath               = "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/SYSTEM_DATABASES/"
$fullSFTPPath           = "$sftpPath/$currentYear/$currentMonth/FULL/"


# CRIA AS CREDENCIAIS DE ACESSO PARA O SFTP
$UserName = "caedbackup"
$SecurePassword = "caedbackup@caed.2013" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword
#$LocalFile = "S:\CL01-INST02-BACKUP\SYSTEM_DATABASES\2018\OCTOBER\FULL\model\model_20181006230.BAK" 

# ABRE A SESSAO NO SFTP
$Session = New-SFTPSession -ComputerName $SFTPIP -Port $SFTPPort -Credential $Credentials

# ENVIO O ARQUIVO DO WINDOWS PARA O LINUX
#Set-SFTPFile -SFTPSession $Session -LocalFile $Localfile -RemotePath "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/" -Overwrite

#$a = "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/SYSTEM_DATABASES/2018"

$pathExists = Get-SFTPChildItem -SFTPSession $Session  -Path $sftpPath -Recursive | Select-Object FullName | where-Object FullName -eq $fullSFTPPath

$countpath = ($pathExists | Measure-Object).Count

#write-host $countpath

if ($countpath -eq 1)  {    
    Write-Output "Arquivo Servidores existe e sera transferido para o servidor de banco de dados."   
}   
else  {      
    Write-Output "O diretorio nao existe no SFTP. O path sera criado."
    New-SFTPItem -SFTPSession $Session -Path $fullSFTPPath -ItemType Directory 
}




# CREATE DIRECTORY IN REMOTE FILE
# New-SFTPItem -SFTPSession $Session -Path "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/TESTE/TESTE" -ItemType Directory 

#########################

Clear-Host

################################
########## PARAMETERS ##########
################################ 

# Get current Month
$systemDatabase         = 'S:\CL01-INST02-BACKUP\SYSTEM_DATABASES'
$currentYear            = (Get-Date).Year
$numerMonth             =  Get-Date -UFormat %m
$currentMonth           = (Get-Culture).DateTimeFormat.GetMonthName($numerMonth)
$fullPathSystemDatabase = "$systemDatabase\$currentYear\$currentMonth\FULL"

# Path SFTP
$sftpPath               = "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/SYSTEM_DATABASES"
$fullSFTPPath           = "$sftpPath/$currentYear/$currentMonth/"

# CRIA AS CREDENCIAIS DE ACESSO PARA O SFTP
$UserName = "caedbackup"
$SecurePassword = "caedbackup@caed.2013" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword
#$LocalFile = "S:\CL01-INST02-BACKUP\SYSTEM_DATABASES\2018\OCTOBER\FULL\model\model_20181006230.BAK" 

# ABRE A SESSAO NO SFTP
$Session = New-SFTPSession -ComputerName $SFTPIP -Port $SFTPPort -Credential $Credentials

WRITE-HOST $fullSFTPPath

# pega o arquivo de backup de ontem
@(Get-ChildItem $fullPathSystemDatabase\*.* -Recurse | Where {$_.Extension -eq '.bak' -and $_.LastWriteTime -ge (Get-Date).AddDays(-1)}) | Select-Object FullName |

ForEach-Object {
    
    # ENVIO O ARQUIVO DO WINDOWS PARA O LINUX
    Set-SFTPFile -SFTPSession $Session -LocalFile $_.FullName -RemotePath $fullSFTPPath.ToUpper() -Overwrite

}



##########################################

Clear-Host

################################
########## PARAMETERS ##########
################################ 

# Get current Month
$systemDatabase         = 'S:\CL01-INST02-BACKUP\SYSTEM_DATABASES'
$currentYear            = (Get-Date).Year
$numerMonth             =  Get-Date -UFormat %m
$currentMonth           = (Get-Culture).DateTimeFormat.GetMonthName($numerMonth)
$fullPathSystemDatabase = "$systemDatabase\$currentYear\$currentMonth\FULL"

# Path SFTP
$sftpPath               = "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/SYSTEM_DATABASES"
$fullSFTPPath           = "$sftpPath/$currentYear/$currentMonth/"

Write-Output $fullSFTPPath

# CRIA AS CREDENCIAIS DE ACESSO PARA O SFTP
$UserName = "caedbackup"
$SecurePassword = "caedbackup@caed.2013" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword
#$LocalFile = "S:\CL01-INST02-BACKUP\SYSTEM_DATABASES\2018\OCTOBER\FULL\model\model_20181006230.BAK" 

# ABRE A SESSAO NO SFTP
$Session = New-SFTPSession -ComputerName $SFTPIP -Port $SFTPPort -Credential $Credentials


New-SFTPItem -SFTPSession $Session -Path $fullSFTPPath.ToUpper() -ItemType Directory 





# CREATE DIRECTORY IN REMOTE FILE
# New-SFTPItem -SFTPSession $Session -Path "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/TESTE/TESTE" -ItemType Directory 


############################################



Clear-Host

################################
########## PARAMETERS ##########
################################ 

# Get current Month
$systemDatabase         = 'S:\CL01-INST02-BACKUP\SYSTEM_DATABASES'
$currentYear            = (Get-Date).Year
$numerMonth             =  Get-Date -UFormat %m
$currentMonth           = (Get-Culture).DateTimeFormat.GetMonthName($numerMonth)
$fullPathSystemDatabase = "$systemDatabase\$currentYear\$currentMonth\FULL"

# Path SFTP
$sftpPath               = "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/SYSTEM_DATABASES/"
$fullSFTPPath           = "$sftpPath/$currentYear/$currentMonth/"


# CRIA AS CREDENCIAIS DE ACESSO PARA O SFTP
$UserName = "caedbackup"
$SecurePassword = "caedbackup@caed.2013" | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword
#$LocalFile = "S:\CL01-INST02-BACKUP\SYSTEM_DATABASES\2018\OCTOBER\FULL\model\model_20181006230.BAK" 

# ABRE A SESSAO NO SFTP
$Session = New-SFTPSession -ComputerName $SFTPIP -Port $SFTPPort -Credential $Credentials

# ENVIO O ARQUIVO DO WINDOWS PARA O LINUX
#Set-SFTPFile -SFTPSession $Session -LocalFile $Localfile -RemotePath "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/" -Overwrite

#$a = "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/SYSTEM_DATABASES/2018"

$pathExists = Get-SFTPChildItem -SFTPSession $Session  -Path $sftpPath -Recursive | Select-Object FullName | where-Object FullName -like "*$currentMonth*"

$countpath = ($pathExists | Measure-Object).Count

#write-host $pathExists
#write-host $countpath
#Write-Host $fullSFTPPath 

if ($countpath -eq 1)  {    
    Write-Output "O diretorio ja existe."   
}   
else  {      
    Write-Output "O diretorio nao existe no SFTP. O path sera criado."
    New-SFTPItem -SFTPSession $Session -Path $fullSFTPPath.ToUpper() -ItemType Directory 
}




# CREATE DIRECTORY IN REMOTE FILE
# New-SFTPItem -SFTPSession $Session -Path "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/TESTE/TESTE" -ItemType Directory 



