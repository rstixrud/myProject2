RAISERROR ('*** Executing SQL: "...\Tables\Staging.ContactClaim.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[ContactClaim]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[ContactClaim]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[ContactClaim]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [Staging].[ContactClaim]
	(
		 [ClaimID]   NVARCHAR(MAX) NOT NULL
		,[ContactID] NVARCHAR(MAX) NOT NULL
	) 
	ON [DATA]; 
END; 
GO 
