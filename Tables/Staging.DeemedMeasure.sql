RAISERROR ('*** Executing SQL: "...\Tables\Staging.DeemedMeasure.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON; 
SET QUOTED_IDENTIFIER ON; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO 

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[DeemedMeasure]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[DeemedMeasure]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[DeemedMeasure]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [Staging].[DeemedMeasure]
	(
		 [ClaimID]               NVARCHAR(MAX)  NOT NULL
		,[MeasCode]              NVARCHAR(MAX)      NULL
		,[MeasAppType]           NVARCHAR(MAX)      NULL
		,[MeasDescription]       NVARCHAR(1024)     NULL
		,[UnitkW1stBaseline]     FLOAT              NULL
		,[UnitkWh1stBaseline]    FLOAT              NULL
		,[UnitTherm1stBaseline]  FLOAT              NULL
		,[UnitkW2ndBaseline]     FLOAT              NULL
		,[UnitkWh2ndBaseline]    FLOAT              NULL
		,[UnitTherm2ndBaseline]  FLOAT              NULL
		,[EUL_Yrs]               FLOAT              NULL
		,[RUL_Yrs]               FLOAT              NULL
		,[RealizationRatekW]     FLOAT              NULL
		,[RealizationRatekWh]    FLOAT              NULL
		,[RealizationRateTherm]  FLOAT              NULL
	--	,[RealizationRateCost]   FLOAT              NULL
		,[InstallationRatekW]    FLOAT              NULL
		,[InstallationRatekWh]   FLOAT              NULL
		,[InstallationRateTherm] FLOAT              NULL
	--	,[InstallationRateCost]  FLOAT              NULL
		,[Revised_Flag]          BIT                NULL
		,[Comments]              NVARCHAR(MAX)      NULL
		,[SourceDesc]            NVARCHAR(MAX)      NULL
		,[Version]               NVARCHAR(MAX)      NULL
	--	,[VersionSource]         NVARCHAR(MAX)      NULL
		,[DeliveryType]          NVARCHAR(MAX)      NULL
		,[StartDate]             NVARCHAR(MAX)      NULL
		,[MeasQualifier]         NVARCHAR(MAX)      NULL
		,[MeasureID]             NVARCHAR(MAX)      NULL
		,[EnergyImpactID]        NVARCHAR(MAX)      NULL
		,[GSIA_ID]               NVARCHAR(MAX)      NULL
		,[NTG_ID]                NVARCHAR(MAX)      NULL
		,[EUL_ID]                NVARCHAR(MAX)      NULL
		,[RUL_ID]                NVARCHAR(MAX)      NULL
		,[MeasCostID]            NVARCHAR(MAX)      NULL
		,[StdCostID]             NVARCHAR(MAX)      NULL
	--	,[MeasImpactType]        NVARCHAR(MAX)      NULL
		,[UseCategory]           NVARCHAR(MAX)      NULL
		,[UseSubCategory]        NVARCHAR(MAX)      NULL
		,[TechGroup]             NVARCHAR(MAX)      NULL
		,[TechType]              NVARCHAR(MAX)      NULL
		,[IETableName]           NVARCHAR(MAX)      NULL
		,[MeasTechID]            NVARCHAR(MAX)      NULL
		,[LaborRate]             NVARCHAR(MAX)      NULL
		,[LocCostAdj]            NVARCHAR(MAX)      NULL
		,[PreDesc]               NVARCHAR(MAX)      NULL
		,[StdDesc]               NVARCHAR(MAX)      NULL
	--	,[PreTechGroup]          NVARCHAR(MAX)      NULL
	--	,[PreTechType]           NVARCHAR(MAX)      NULL
	--	,[StdTechGroup]          NVARCHAR(MAX)      NULL
	--	,[StdTechType]           NVARCHAR(MAX)      NULL
		,[MeasImpactCalcType]    NVARCHAR(MAX)      NULL
		,[MeasInflation]         FLOAT              NULL
	) 
	ON [DATA]; 
END; 
GO 
