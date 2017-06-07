SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\config.GetCedarsUriString.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'config')
BEGIN
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [config] AUTHORIZATION [dbo]';
END;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[config].[GetCedarsUriString]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [config].[GetCedarsUriString];
END;
GO

CREATE FUNCTION [config].[GetCedarsUriString]
(
	@JobID AS NVARCHAR(35)
)
RETURNS NVARCHAR(128)
AS
BEGIN
	DECLARE @UriString AS NVARCHAR(128);

	IF (@JobID LIKE N'[0-9]%[_]production%')
		SET @UriString = N'https://cedars.sound-data.com/cet/api/v1/';

	IF (@JobID LIKE N'[0-9]%[_]staging%')
		SET @UriString = N'https://cedars-staging.sound-data.com/cet/api/v1/';

	IF (@JobID LIKE N'[0-9]%[_]testing%')
		SET @UriString = N'https://cedars-testing.sound-data.com/cet/api/v1/';

	IF (@JobID LIKE N'[0-9]%[_]local%')
		SET @UriString = NULL;

	RETURN @UriString; 
END;
GO
