SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\config.GetCedarsApiToken.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'config')
BEGIN
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [config] AUTHORIZATION [dbo]';
END;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[config].[GetCedarsApiToken]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [config].[GetCedarsApiToken];
END;
GO

CREATE FUNCTION [config].[GetCedarsApiToken]
(
	@JobID AS NVARCHAR(35)
)
RETURNS NVARCHAR(64)
AS
BEGIN
	DECLARE @Token AS NVARCHAR(64);

	IF (@JobID IS NOT NULL) SET @Token = N'byTMXswbI5O0MckD4kLkRuyejqueHR5l';

	RETURN @Token;
END;
GO
