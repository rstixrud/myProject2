RAISERROR ('*** Executing SQL: "...\Tables\Staging.WaterMeasure.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[WaterMeasure]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[WaterMeasure]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[WaterMeasure]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [Staging].[WaterMeasure]
	( 
		 [ClaimID]            NVARCHAR(MAX) NOT NULL
		,[WaterMeasCode]      NVARCHAR(MAX)     NULL
		,[SavingsProfile]     NVARCHAR(MAX)     NULL
		,[HydrologicRegion]   NVARCHAR(MAX)     NULL
		,[Sector]             NVARCHAR(MAX)     NULL
		,[WaterUse]           NVARCHAR(MAX)     NULL
		,[Gallons]            FLOAT             NULL
		,[AvgAnnualIOUkWh]    FLOAT             NULL
		,[AvgAnnualNonIOUkWh] FLOAT             NULL
		,[AvgAnnualTherm]     FLOAT             NULL
		,[SourceDesc]         NVARCHAR(MAX)     NULL
	) 
	ON [DATA]; 
END; 
GO 
