RAISERROR ('*** Executing SQL: "...\Tables\Staging.CustomMeasure.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[CustomMeasure]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[CustomMeasure]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[CustomMeasure]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [Staging].[CustomMeasure]
	(
		 [ClaimID]               NVARCHAR(MAX) NOT NULL
		,[MeasCode]              NVARCHAR(MAX)     NULL
		,[MeasAppType]           NVARCHAR(MAX)     NULL
		,[MeasDescription]       NVARCHAR(MAX)     NULL
		,[UseCategory]           NVARCHAR(MAX)     NULL --New Field
		,[UseSubCategory]        NVARCHAR(MAX)     NULL
		,[TechGroup]             NVARCHAR(MAX)     NULL --New Field
		,[TechType]              NVARCHAR(MAX)     NULL
		,[UnitkW1stBaseline]     FLOAT             NULL
		,[UnitkWh1stBaseline]    FLOAT             NULL
		,[UnitTherm1stBaseline]  FLOAT             NULL
		,[UnitkW2ndBaseline]     FLOAT             NULL
		,[UnitkWh2ndBaseline]    FLOAT             NULL
		,[UnitTherm2ndBaseline]  FLOAT             NULL
		,[EUL_Yrs]               FLOAT             NULL
		,[RUL_Yrs]               FLOAT             NULL
		,[RealizationRatekW]     FLOAT             NULL
		,[RealizationRatekWh]    FLOAT             NULL
		,[RealizationRateTherm]  FLOAT             NULL
	--	,[RealizationRateCost]   FLOAT             NULL
		,[InstallationRatekW]    FLOAT             NULL
		,[InstallationRatekWh]   FLOAT             NULL
		,[InstallationRateTherm] FLOAT             NULL
	--	,[InstallationRateCost]  FLOAT             NULL
		,[Revised_Flag]          BIT               NULL
		,[PreDesc]               NVARCHAR(MAX)     NULL --New Field
		,[StdDesc]               NVARCHAR(MAX)     NULL --New Field
		,[MeasInflation]         FLOAT             NULL --New Field
		,[Comments]              NVARCHAR(MAX)     NULL
	) 
	ON [DATA]; 
END; 
GO 
