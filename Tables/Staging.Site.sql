RAISERROR ('*** Executing SQL: "...\Tables\Staging.Site.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[Site]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[Site]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[Site]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [Staging].[Site]
	(
		 [SiteID]           NVARCHAR(MAX) NOT NULL
		,[SiteCity]         NVARCHAR(MAX)     NULL
		,[SiteState]        NVARCHAR(MAX)     NULL
		,[SiteZipCode]      NVARCHAR(MAX)     NULL
		,[NAICSCode]        NVARCHAR(MAX)     NULL
		,[Residential_Flag] INT               NULL
	) 
	ON [DATA]; 
END; 
GO 
