RAISERROR ('*** Executing SQL: "...\Tables\Staging.Measure.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON; 
SET QUOTED_IDENTIFIER ON; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO 

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[Measure]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[Measure]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[Measure]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [Staging].[Measure] 
	( 
		 [CEInputID]              NVARCHAR(255)     NULL 
		,[PrgID]                  NVARCHAR(255) NOT NULL 
		,[ClaimYearQuarter]       NVARCHAR(  6)     NULL 
		,[Sector]                 NVARCHAR( 50)     NULL 
		,[DeliveryType]           NVARCHAR( 50)     NULL 
		,[BldgType]               NVARCHAR(255)     NULL 
		,[E3ClimateZone]          NVARCHAR(255)     NULL 
		,[E3GasSavProfile]        NVARCHAR(255)     NULL 
		,[E3GasSector]            NVARCHAR(255)     NULL 
		,[E3MeaElecEndUseShape]   NVARCHAR(255)     NULL 
		,[E3TargetSector]         NVARCHAR(255)     NULL 
		,[MeasAppType]            NVARCHAR(255)     NULL 
		,[MeasCode]               NVARCHAR(255)     NULL 
		,[MeasDescription]        NVARCHAR(255)     NULL 
		,[MeasImpactType]         NVARCHAR( 50)     NULL 
		,[MeasureID]              NVARCHAR(255)     NULL 
		,[TechGroup]              NVARCHAR( 50)     NULL 
		,[TechType]               NVARCHAR( 50)     NULL 
		,[UseCategory]            NVARCHAR( 50)     NULL 
		,[UseSubCategory]         NVARCHAR( 50)     NULL 
		,[PreDesc]                NVARCHAR(255)     NULL 
		,[PreTechGroup]           NVARCHAR( 50)     NULL 
		,[PreTechType]            NVARCHAR( 50)     NULL 
		,[StdDesc]                NVARCHAR(255)     NULL 
		,[StdTechGroup]           NVARCHAR( 50)     NULL 
		,[StdTechType]            NVARCHAR( 50)     NULL 
		,[SourceDesc]             NVARCHAR(255)     NULL 
		,[Version]                NVARCHAR( 50)     NULL 
		,[VersionSource]          NVARCHAR( 50)     NULL 
		,[NormUnit]               NVARCHAR(255)     NULL 
		,[NumUnits]               FLOAT             NULL 
		,[UnitkW1stBaseline]      FLOAT             NULL 
		,[UnitkWh1stBaseline]     FLOAT             NULL 
		,[UnitTherm1stBaseline]   FLOAT             NULL 
		,[UnitkW2ndBaseline]      FLOAT             NULL 
		,[UnitkWh2ndBaseline]     FLOAT             NULL 
		,[UnitTherm2ndBaseline]   FLOAT             NULL 
		,[UnitMeaCost1stBaseline] FLOAT             NULL 
		,[UnitMeaCost2ndBaseline] FLOAT             NULL 
		,[UnitDirectInstallLab]   FLOAT             NULL 
		,[UnitDirectInstallMat]   FLOAT             NULL 
		,[UnitEndUserRebate]      FLOAT             NULL 
		,[UnitIncentiveToOthers]  FLOAT             NULL 
		,[NTG_ID]                 NVARCHAR( 50)     NULL 
		,[NTGRkW]                 FLOAT             NULL 
		,[NTGRkWh]                FLOAT             NULL 
		,[NTGRTherm]              FLOAT             NULL 
		,[NTGRCost]               FLOAT             NULL 
		,[EUL_ID]                 NVARCHAR(100)     NULL 
		,[EUL_Yrs]                FLOAT             NULL 
		,[RUL_ID]                 NVARCHAR(100)     NULL 
		,[RUL_Yrs]                FLOAT             NULL 
		,[GSIA_ID]                NVARCHAR( 50)     NULL 
		,[RealizationRatekW]      FLOAT             NULL 
		,[RealizationRatekWh]     FLOAT             NULL 
		,[RealizationRateTherm]   FLOAT             NULL 
		,[RealizationRateCost]    FLOAT             NULL 
		,[InstallationRatekW]     FLOAT             NULL 
		,[InstallationRatekWh]    FLOAT             NULL 
		,[InstallationRateTherm]  FLOAT             NULL 
		,[InstallationRateCost]   FLOAT             NULL 
		,[Residential_Flag]       BIT               NULL 
		,[Upstream_Flag]          BIT               NULL 
		,[PA]                     NVARCHAR( 50)     NULL 
		,[Comments]               NVARCHAR(255)     NULL 
	) 
	ON [DATA]; 
END; 
GO 
