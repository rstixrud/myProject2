SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\config.GetCedarsDirectory.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'config') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [config] AUTHORIZATION [dbo]'; 
END; 
GO 

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[config].[GetCedarsDirectory]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT')) 
BEGIN 
	DROP FUNCTION [config].[GetCedarsDirectory]; 
END; 
GO

CREATE FUNCTION [config].[GetCedarsDirectory] 
( 
	@FolderName AS NVARCHAR(512) 
) 
RETURNS NVARCHAR(512) 
AS 
BEGIN 
	DECLARE @Directory AS NVARCHAR(512); 

	-- Valid sub-folder names available under the base directory 
	IF (@FolderName IN (N'\', N'Archive', N'Data', N'Error', N'Input', N'Output')) 
	BEGIN 
		SET @Directory = N'C:\App-CET\';

		IF (CHARINDEX(N'Staging', DB_NAME()) = 0) 
			SET @Directory = @Directory + N'Production\';

		IF (CHARINDEX(N'Staging', DB_NAME()) > 0) 
			SET @Directory = @Directory + N'Staging\';
	END; 

	RETURN REPLACE(@Directory + @FolderName + N'\', N'\\\', N'\'); 
END;
GO
