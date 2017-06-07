SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\config.GetCedarsDatabase.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'config')
BEGIN
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [config] AUTHORIZATION [dbo]';
END;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[config].[GetCedarsDatabase]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [config].[GetCedarsDatabase];
END;
GO

CREATE FUNCTION [config].[GetCedarsDatabase]
(
	@TargetDatabase AS NVARCHAR(128)
)
RETURNS NVARCHAR(128)
AS
BEGIN
	DECLARE @CedarsDatabase AS NVARCHAR(128);

	SET @CedarsDatabase = REPLACE(DB_NAME(), N'CETMGMT', @TargetDatabase);

	IF (@TargetDatabase = N'CEDARS')
	BEGIN
		SET @CedarsDatabase = REPLACE(@CedarsDatabase, N'_Claim' , N'');
		SET @CedarsDatabase = REPLACE(@CedarsDatabase, N'_Module', N'');
	END;

	RETURN @CedarsDatabase;
END;
GO
