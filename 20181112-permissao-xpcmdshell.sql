EXEC sp_xp_cmdshell_proxy_account 'avaprova', 'Caed.avaprova';  
GO

ALTER LOGIN avaprova  
WITH CREDENTIAL = avaprova;  
GO  



/*
Msg 15137, Level 16, State 1, Procedure sp_xp_cmdshell_proxy_account, Line 1
An error occurred during the execution of sp_xp_cmdshell_proxy_account. Possible reasons: the provided account was invalid or the '##xp_cmdshell_proxy_account##' credential could not be created. Error code: 0(null), Error Status: 0.

*/

-- 1. criar um usuario no dominio (nao precisa add nenhuma permissao)
-- 2. criar uma credencial no sql com o usuario do dominio criado

-- https://dbamohsin.wordpress.com/2017/02/22/xp_cmdshell_proxy_account-credential-could-not-be-created/
create credential ##xp_cmdshell_proxy_account## with identity = 'avaprova', secret = '123@qwe'

-- 3. cria um proxy com o usuario da credencial ##xp_cmdshell_proxy_account## da permissao para CmdExec
-- 4. adicionar o usuario criado no AD nas poliictas locais: Local Security Police\User Rights Assignment\Log on as batch job



-- verificar usuario que tem permissao para executar a proc
exec sp_helprotect 'xp_cmdshell' 


select * from   sys.credentials where  name in ('##xp_cmdshell_proxy_account##')  


-- https://support.microsoft.com/pt-br/help/890775/how-to-enable-non-sysadmin-accounts-to-execute-the-xp-cmdshell-extende
USE [master]  
CREATE USER avaprova FOR LOGIN avaprova  
GRANT Execute ON [dbo].[xp_cmdshell] TO avaprova 