USE [SIA_CPD]
GO

-- CREATE TABLE TB_BASE_PROCESSAMENTO_HISTORICO
CREATE TABLE [DBO].[TB_BASE_PROCESSAMENTO_HISTORICO](
	[ID_BASE_PROCESSAMENTO] [NUMERIC](19, 0) IDENTITY(1,1) NOT NULL,
	[ID_BASE_PLANEJADA] [NUMERIC](19, 0) NULL,
	[DT_PROCESSAMENTO] [DATETIME] NULL,
	[CD_LOTE] [VARCHAR](100) NULL,
	[ID_MASCARA] [VARCHAR](100) NULL,
	[DC_CAMINHO_IMAGEM] [VARCHAR](400) NULL,
	[TP_PROCESSAMENTO] [VARCHAR](20) NULL,
	[ID_IMAGEM_DIGITALIZADA] [NUMERIC](19, 0) NULL,
 CONSTRAINT [PK_TB_BASE_PROCESSAMENTO_HISTORICO] PRIMARY KEY CLUSTERED 
(
	[ID_BASE_PROCESSAMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [FG_INDEX_SIA_CPD]
) ON [FG_INDEX_SIA_CPD]

GO

-- INSERT TB_BASE_PROCESSAMENTO_HISTORICO
 --(6600398 ROW(S) AFFECTED)
SET IDENTITY_INSERT TB_BASE_PROCESSAMENTO_HISTORICO ON
INSERT INTO [DBO].[TB_BASE_PROCESSAMENTO_HISTORICO] (
[ID_BASE_PROCESSAMENTO],
[ID_BASE_PLANEJADA],
[DT_PROCESSAMENTO],
[CD_LOTE], 
[ID_MASCARA],
[DC_CAMINHO_IMAGEM], 
[TP_PROCESSAMENTO], 
[ID_IMAGEM_DIGITALIZADA] 
)
SELECT *
FROM SIA_CPD.DBO.TB_BASE_PROCESSAMENTO
WHERE ID_BASE_PLANEJADA IN (
SELECT ID_BASE_PLANEJADA
FROM TB_BASE_PLANEJADA NOLOCK
WHERE CD_PROJETO IN (1061, 1062, 100, 363, 336, 1153, 1072, 1145, 1073, 1050, 1063, 1124, 1125, 1116, 1131, 1122,1117, 1130, 1146, 1132, 1140, 527, 1133, 1141, 1142, 1144, 1148, 1082, 1139, 1128, 1127))
SET IDENTITY_INSERT TB_BASE_PROCESSAMENTO_HISTORICO OFF



USE [SIA_CPD]
GO

-- CREATE TABLE TB_BASE_PLANEJADA_HISTORICO
CREATE TABLE [dbo].[TB_BASE_PLANEJADA_HISTORICO](
	[ID_BASE_PLANEJADA] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[NU_SEQUENCIAL] [varchar](100) NULL,
	[ID_MASCARA] [varchar](100) NULL,
	[CD_PROJETO] [varchar](100) NULL,
	[NM_PROJETO] [varchar](200) NULL,
	[VL_SENSIBILIDADE] [int] NOT NULL DEFAULT ((125)),
	[NU_PACOTE] [varchar](100) NULL,
	[NU_MALOTE] [varchar](100) NULL,
	[CD_REGISTRO_CAED] [varchar](100) NULL,
 CONSTRAINT [PK_TB_BASE_PLANEJADA_HISTORICO] PRIMARY KEY CLUSTERED 
(
	[ID_BASE_PLANEJADA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [FG_DATA_SIA_CPD]
) ON [FG_DATA_SIA_CPD]

GO

-- INSERT TB_BASE_PLANEJADA_HISTORICO
SET IDENTITY_INSERT TB_BASE_PLANEJADA_HISTORICO ON
INSERT INTO TB_BASE_PLANEJADA_HISTORICO (
[ID_BASE_PLANEJADA],
[NU_SEQUENCIAL],
[ID_MASCARA],
[CD_PROJETO],
[NM_PROJETO],
[VL_SENSIBILIDADE],
[NU_PACOTE],
[NU_MALOTE],
[CD_REGISTRO_CAED] 
)
SELECT *
FROM TB_BASE_PLANEJADA NOLOCK
WHERE CD_PROJETO IN (1061, 1062, 100, 363, 336, 1153, 1072, 1145, 1073, 1050, 1063, 1124, 1125, 1116, 1131, 1122,1117, 1130, 1146, 1132, 1140, 527, 1133, 1141, 1142, 1144, 1148, 1082, 1139, 1128, 1127)
SET IDENTITY_INSERT TB_BASE_PLANEJADA_HISTORICO OFF



-- RENAME TABLE TB_BASE_PROCESSAMENTO
EXEC SP_RENAME 'TB_BASE_PROCESSAMENTO', 'TB_BASE_PROCESSAMENTO_1';  
EXEC SP_RENAME 'TB_BASE_PROCESSAMENTO_HISTORICO', 'TB_BASE_PROCESSAMENTO';  
EXEC SP_RENAME 'TB_BASE_PROCESSAMENTO_1', 'TB_BASE_PROCESSAMENTO_HISTORICO';  

-- VERIFICAR O NOME DOS OBJETOS
SELECT * FROM SYS.TABLES WHERE NAME LIKE '%BASE_PLANEJADA%'

-- VALIDACAO
SELECT COUNT(*) FROM TB_BASE_PROCESSAMENTO WITH(NOLOCK) -- 6600398
SELECT COUNT(*) FROM TB_BASE_PROCESSAMENTO_HISTORICO WITH(NOLOCK) --68010319

-- RENAME TABLE TB_BASE_PLANEJADA
EXEC SP_RENAME 'TB_BASE_PLANEJADA', 'TB_BASE_PLANEJADA_1';  
EXEC SP_RENAME 'TB_BASE_PLANEJADA_HISTORICO', 'TB_BASE_PLANEJADA';  
EXEC SP_RENAME 'TB_BASE_PLANEJADA_1', 'TB_BASE_PLANEJADA_HISTORICO';  

-- VALIDACAO
SELECT COUNT(*) FROM TB_BASE_PLANEJADA WITH(NOLOCK) -- 15137527
SELECT COUNT(*) FROM TB_BASE_PLANEJADA_HISTORICO WITH(NOLOCK) -- 102277239


-- RENAME PRIMARY KEY TB_BASE_PROCESSAMENTO
EXEC SP_RENAME N'TB_BASE_PROCESSAMENTO_HISTORICO.PK_TB_BASE_PROCESSAMENTO', N'PK_TB_BASE_PROCESSAMENTO_HISTORICO_'
EXEC SP_RENAME N'TB_BASE_PROCESSAMENTO.PK_TB_BASE_PROCESSAMENTO_HISTORICO', N'PK_TB_BASE_PROCESSAMENTO'
EXEC SP_RENAME N'TB_BASE_PROCESSAMENTO_HISTORICO.PK_TB_BASE_PROCESSAMENTO_HISTORICO_', N'PK_TB_BASE_PROCESSAMENTO_HISTORICO'


-- RENAME PRIMARY KEY PK_TB_BASE_PLANEJADA
EXEC SP_RENAME N'TB_BASE_PLANEJADA_HISTORICO.PK_TB_BASE_PLANEJADA', N'PK_TB_BASE_PLANEJADA_HISTORICO_'
EXEC SP_RENAME N'TB_BASE_PLANEJADA.PK_TB_BASE_PLANEJADA_HISTORICO', N'PK_TB_BASE_PLANEJADA'
EXEC SP_RENAME N'TB_BASE_PLANEJADA_HISTORICO.PK_TB_BASE_PLANEJADA_HISTORICO_', N'PK_TB_BASE_PLANEJADA_HISTORICO'


-------------------
-- RENAME INDEX
-------------------
-- RENAME NONCLUSTERED INDEX TB_BASE_PROCESSAMENTO
EXEC SP_RENAME N'DBO.TB_BASE_PROCESSAMENTO_HISTORICO.IXNC_TB_BASE_PROCESSAMENTO_01', N'IXNC_TB_BASE_PROCESSAMENTO_HISTORICO_01', N'INDEX'

-- RENAME NONCLUSTERED INDEX TB_BASE_PLANEJADA
EXEC SP_RENAME N'DBO.TB_BASE_PLANEJADA_HISTORICO.IX_TB_BASE_PLANEJADA01', N'IXNC_TB_BASE_PLANEJADA_HISTORICO_01', N'INDEX'
EXEC SP_RENAME N'DBO.TB_BASE_PLANEJADA_HISTORICO.IX_TB_BASE_PLANEJADA02', N'IXNC_TB_BASE_PLANEJADA_HISTORICO_02', N'INDEX'

-----------------------------------------
-- CREATE INDEX TB_BASE_PROCESSAMENTO
-----------------------------------------

CREATE NONCLUSTERED INDEX [IXNC_TB_BASE_PROCESSAMENTO_01] ON [dbo].[TB_BASE_PROCESSAMENTO]
(
	[ID_BASE_PLANEJADA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
 ON [FG_INDEX_SIA_CPD]
GO


-----------------------------------------
-- CREATE INDEX TB_BASE_PLANEJA
-----------------------------------------

CREATE NONCLUSTERED INDEX [IXNC_TB_BASE_PLANEJADA_01] ON [dbo].[TB_BASE_PLANEJADA]
(
	[NU_SEQUENCIAL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
 FILLFACTOR = 90) ON [FG_INDEX_SIA_CPD]
GO


CREATE NONCLUSTERED INDEX [IXNC_TB_BASE_PLANEJADA_02] ON [dbo].[TB_BASE_PLANEJADA]
(
	[ID_MASCARA] ASC,
	[NU_SEQUENCIAL] ASC
)
INCLUDE ( [ID_BASE_PLANEJADA]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [FG_INDEX_SIA_CPD]
GO



---------------------------------------------
-- DROP FK TB_BASE_PROCESSAMENTO_HISTORICO
---------------------------------------------
ALTER TABLE TB_BASE_PROCESSAMENTO_HISTORICO DROP CONSTRAINT FK_TB_BASE_PLANEJADA_TB_BASE_PROCESSAMENTO
ALTER TABLE TB_BASE_PROCESSAMENTO_HISTORICO DROP CONSTRAINT FK_TB_IMAGEM_DIGITALIZADA_TB_BASE_PROCESSAMENTO


-- RENAME FOREIGN KEY TB_BASE_PROCESSAMENTO_HISTORICO
--EXEC SP_RENAME N'TB_BASE_PROCESSAMENTO_HISTORICO.FK_TB_BASE_PLANEJADA_TB_BASE_PROCESSAMENTO_1', N'FK_TB_BASE_PLANEJADA_TB_BASE_PROCESSAMENTO_HISTORICO_1'
--EXEC SP_RENAME N'TB_BASE_PROCESSAMENTO_HISTORICO.FK_TB_IMAGEM_DIGITALIZADA_TB_BASE_PROCESSAMENTO_1', N'FK_TB_IMAGEM_DIGITALIZADA_TB_BASE_PROCESSAMENTO_HISTORICO_1'

--------------------------------------------
-- CREATE FOREIGN KEY TB_BASE_PROCESSAMENTO
--------------------------------------------

-- FK_TB_BASE_PLANEJADA_TB_BASE_PROCESSAMENTO_1
ALTER TABLE [dbo].[TB_BASE_PROCESSAMENTO]  WITH NOCHECK ADD  CONSTRAINT [FK_TB_BASE_PLANEJADA_TB_BASE_PROCESSAMENTO] FOREIGN KEY([ID_BASE_PLANEJADA])
REFERENCES [dbo].[TB_BASE_PLANEJADA] ([ID_BASE_PLANEJADA])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TB_BASE_PROCESSAMENTO] NOCHECK CONSTRAINT [FK_TB_BASE_PLANEJADA_TB_BASE_PROCESSAMENTO]
GO

-- FK_TB_IMAGEM_DIGITALIZADA_TB_BASE_PROCESSAMENTO_1
ALTER TABLE [dbo].[TB_BASE_PROCESSAMENTO]  WITH NOCHECK ADD  CONSTRAINT [FK_TB_IMAGEM_DIGITALIZADA_TB_BASE_PROCESSAMENTO] FOREIGN KEY([ID_IMAGEM_DIGITALIZADA])
REFERENCES [dbo].[TB_IMAGEM_DIGITALIZADA] ([ID_IMAGEM_DIGITALIZADA])
GO

ALTER TABLE [dbo].[TB_BASE_PROCESSAMENTO] NOCHECK CONSTRAINT [FK_TB_IMAGEM_DIGITALIZADA_TB_BASE_PROCESSAMENTO]
GO

------------------------------------------------------
-- VERIFICAR SE A TABELA FAZ PARTE DO CHANGE TRACKING
------------------------------------------------------
SELECT S.NAME, T.NAME, TR.*
FROM SYS.CHANGE_TRACKING_TABLES TR
INNER JOIN SYS.TABLES T ON T.OBJECT_ID = TR.OBJECT_ID
INNER JOIN SYS.SCHEMAS S ON S.SCHEMA_ID = T.SCHEMA_ID
ORDER BY 2

-- SE SIM ... DA UM DISABLE
ALTER TABLE TB_BASE_PROCESSAMENTO_HISTORICO DISABLE CHANGE_TRACKING;

-- E HABILITA A TABELA NOVA
ALTER TABLE DBO.TB_BASE_PROCESSAMENTO
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = OFF); -- <== VERIFICAR NA TABELA ORIGINAL QUAL O VALOR SETADO PARA O TRACK_COLUMNS_UPDATED


-------------------------------------
-- MOVE TABLE TO ANOTHER FILEGROUP
-------------------------------------

-- DROP PK TB_BASE_PROCESSAMENTO_HISTORICO
ALTER TABLE [DBO].[TB_BASE_PROCESSAMENTO_HISTORICO] DROP CONSTRAINT [PK_TB_BASE_PROCESSAMENTO_HISTORICO]
GO

-- CREATE PRIMARY KEY TB_BASE_PROCESSAMENTO_HISTORICO

ALTER TABLE [DBO].[TB_BASE_PROCESSAMENTO_HISTORICO] ADD CONSTRAINT [PK_TB_BASE_PROCESSAMENTO_HISTORICO] 
PRIMARY KEY CLUSTERED ([ID_BASE_PROCESSAMENTO]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, 
ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON FG_DATA_SIA_CPD_HISTORICO
GO


-- DROP PK TB_BASE_PLANEJADA_HISTORICO
ALTER TABLE [DBO].[TB_BASE_PLANEJADA_HISTORICO] DROP CONSTRAINT [PK_TB_BASE_PLANEJADA_HISTORICO]
GO

-- CREATE PRIMARY KEY  TB_BASE_PLANEJADA_HISTORICO
ALTER TABLE [DBO].[TB_BASE_PLANEJADA_HISTORICO] ADD CONSTRAINT [PK_TB_BASE_PLANEJADA_HISTORICO] 
PRIMARY KEY CLUSTERED ([ID_BASE_PLANEJADA]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, 
ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON FG_DATA_SIA_CPD_HISTORICO
GO


-- VERIFICA SE A TABELA FOI PARA O FILEGROUP CORRETO

SELECT 
	O.[NAME], O.[TYPE], I.[NAME], I.[INDEX_ID], F.[NAME]
FROM SYS.INDEXES I
INNER JOIN SYS.FILEGROUPS F ON I.DATA_SPACE_ID = F.DATA_SPACE_ID
INNER JOIN SYS.ALL_OBJECTS O ON I.[OBJECT_ID] = O.[OBJECT_ID]
WHERE 
	I.DATA_SPACE_ID = F.DATA_SPACE_ID
AND O.TYPE = 'U' -- USER CREATED TABLES
--AND I.NAME LIKE 'IX%'
AND F.NAME = 'FG_DATA_SIA_CPD_HISTORICO'
ORDER BY 1 DESC