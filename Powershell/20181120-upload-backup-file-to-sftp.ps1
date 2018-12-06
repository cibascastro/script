Clear-Host

################################
########## PARAMETERS ##########
################################ 

# SFTP
$SFTPIP                 = '192.168.20.14'
$SFTPPort               = '6798'

# Get current Month
$systemDatabase         = 'S:\CL01-INST02-BACKUP\SYSTEM_DATABASES'
$currentYear            = (Get-Date).Year
$numerMonth             =  Get-Date -UFormat %m
$currentMonth           = (Get-Culture).DateTimeFormat.GetMonthName($numerMonth)
$fullPathSystemDatabase = "$systemDatabase\$currentYear\$currentMonth\FULL"

# Path SFTP
$SFTPPath               = "/BKP-CAEDDC02DB02/CL01-INST02-BACKUP/SYSTEM_DATABASES/"
$fullSFTPPath           = "$sftpPath/$currentYear/$currentMonth/"

# database Intraction
$SQLServer = "DBSERVER02\DBSERVER02" #use Server\Instance for named SQL instances!

# CRIA AS CREDENCIAIS DE ACESSO PARA O SFTP
$UserName               = "caedbackup"
$SecurePassword         = "caedbackup@caed.2013" | ConvertTo-SecureString -AsPlainText -Force
$Credentials            = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword

Clear
Write-Host "========================================================================================================================================================"
Write-Host "== Used parameters =="
Write-Host "========================================================================================================================================================"
Write-Host "Server Name             :" $SQLServer
Write-Host "SFTP                    :" $SFTPIP
Write-Host "SFTP Path               :" $SFTPPath
Write-Host "Backup Path             :" $fullPath.ToUpper()
Write-Host "========================================================================================================================================================"


# ABRE A SESSAO NO SFTP
$Session = New-SFTPSession -ComputerName $SFTPIP -Port $SFTPPort -Credential $Credentials

# VERIFICA SE O DIRETORIO EXISTE NO LINUX
$pathExists = Get-SFTPChildItem -SFTPSession $Session  -Path $sftpPath -Recursive | Select-Object FullName | where-Object FullName -like "*$currentMonth*"
$countpath = ($pathExists | Measure-Object).Count

if ($countpath -eq 1)  {    
    Write-Output "O diretorio ja existe."   
}   
else  {      
    Write-Output "O diretorio nao existe no SFTP. O path sera criado."
    # CREATE REMOTE DIRECTORY ON LINUX
    New-SFTPItem -SFTPSession $Session -Path $fullSFTPPath.ToUpper() -ItemType Directory 
}

# PEGA OS ARQUIVOS DE BACKUP QUE FORAM FEITOS ONTEM
@(Get-ChildItem $fullPathSystemDatabase\*.* -Recurse | Where {$_.Extension -eq '.bak' -and $_.LastWriteTime -ge (Get-Date).AddDays(-1)}) | Select-Object FullName |

ForEach-Object {
    
    # ENVIO O ARQUIVO DO WINDOWS PARA O LINUX - $fullSFTPPath e case sensitive
    Set-SFTPFile -SFTPSession $Session -LocalFile $_.FullName -RemotePath $fullSFTPPath.ToUpper() -Overwrite

}
