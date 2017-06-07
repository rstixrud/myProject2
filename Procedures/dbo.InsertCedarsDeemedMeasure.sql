SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCedarsDeemedMeasure.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCedarsDeemedMeasure]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCedarsDeemedMeasure] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script: dbo.InsertCedarsDeemedMeasure.sql

Synopsis:

Notes:

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
04/04/2016		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCedarsDeemedMeasure]
(
	@Debug AS BIT = 0
)
AS
BEGIN
	------------------------------------------------------------------------------------------------------------------
	--// SET STATEMENTS	                                                                                          //--
	------------------------------------------------------------------------------------------------------------------
	SET NOCOUNT ON;
	SET QUOTED_IDENTIFIER ON;
	SET ARITHABORT OFF;
	SET NUMERIC_ROUNDABORT OFF;
	SET ANSI_WARNINGS ON;
	SET ANSI_PADDING ON;
	SET ANSI_NULLS ON;
	SET CONCAT_NULL_YIELDS_NULL ON;
	SET CURSOR_CLOSE_ON_COMMIT OFF;
	SET IMPLICIT_TRANSACTIONS OFF;
	SET DATEFORMAT MDY;
	SET DATEFIRST 7;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Executing: [dbo].[InsertCedarsDeemedMeasure]...';


	INSERT INTO [dbo].[CEDARS_DeemedMeasure]
	(
			 [ClaimID]
			,[MeasCode]
			,[MeasAppType]
			,[MeasDescription]
			,[UnitkW1stBaseline]
			,[UnitkWh1stBaseline]
			,[UnitTherm1stBaseline]
			,[UnitkW2ndBaseline]
			,[UnitkWh2ndBaseline]
			,[UnitTherm2ndBaseline]
			,[EUL_Yrs]
			,[RUL_Yrs]
			,[RealizationRatekW]
			,[RealizationRatekWh]
			,[RealizationRateTherm]
		--	,[RealizationRateCost]
			,[InstallationRatekW]
			,[InstallationRatekWh]
			,[InstallationRateTherm]
		--	,[InstallationRateCost]
			,[Revised_Flag]
			,[Comments]
			,[SourceDesc]
			,[Version]
		--	,[VersionSource]
			,[DeliveryType]
			,[StartDate]
			,[MeasQualifier]
			,[MeasureID]
			,[EnergyImpactID]
			,[GSIA_ID]
			,[NTG_ID]
			,[EUL_ID]
			,[RUL_ID]
			,[MeasCostID]
			,[StdCostID]
		--	,[MeasImpactType]
			,[UseCategory]
			,[UseSubCategory]
			,[TechGroup]
			,[TechType]
			,[IETableName]
			,[MeasTechID]
			,[LaborRate]
			,[LocCostAdj]
			,[PreDesc]
			,[StdDesc]
		--	,[PreTechGroup]
		--	,[PreTechType]
		--	,[StdTechGroup]
		--	,[StdTechType]
			,[MeasImpactCalcType]
	)
	SELECT	 [ClaimID]               = CAST([ClaimID] AS NVARCHAR(255))
			,[MeasCode]              = CAST([MeasCode] AS NVARCHAR(255))
			,[MeasAppType]           = CAST([MeasAppType] AS NVARCHAR(255))
			,[MeasDescription]       = CAST([MeasDescription] AS NVARCHAR(1024))
			,[UnitkW1stBaseline]     = CAST([UnitkW1stBaseline] AS FLOAT)
			,[UnitkWh1stBaseline]    = CAST([UnitkWh1stBaseline] AS FLOAT)
			,[UnitTherm1stBaseline]  = CAST([UnitTherm1stBaseline] AS FLOAT)
			,[UnitkW2ndBaseline]     = CAST([UnitkW2ndBaseline] AS FLOAT)
			,[UnitkWh2ndBaseline]    = CAST([UnitkWh2ndBaseline] AS FLOAT)
			,[UnitTherm2ndBaseline]  = CAST([UnitTherm2ndBaseline] AS FLOAT)
			,[EUL_Yrs]               = CAST([EUL_Yrs] AS FLOAT)
			,[RUL_Yrs]               = CAST([RUL_Yrs] AS FLOAT)
			,[RealizationRatekW]     = CAST([RealizationRatekW] AS FLOAT)
			,[RealizationRatekWh]    = CAST([RealizationRatekWh] AS FLOAT)
			,[RealizationRateTherm]  = CAST([RealizationRateTherm] AS FLOAT)
		--	,[RealizationRateCost]   = CAST([RealizationRateCost] AS FLOAT)
			,[InstallationRatekW]    = CAST([InstallationRatekW] AS FLOAT)
			,[InstallationRatekWh]   = CAST([InstallationRatekWh] AS FLOAT)
			,[InstallationRateTherm] = CAST([InstallationRateTherm] AS FLOAT)
		--	,[InstallationRateCost]  = CAST([InstallationRateCost] AS FLOAT)
			,[Revised_Flag]          = CAST([Revised_Flag] AS BIT)
			,[Comments]              = CAST([Comments] AS NVARCHAR(255))
			,[SourceDesc]            = CAST([SourceDesc] AS NVARCHAR(255))
			,[Version]               = CAST([Version] AS NVARCHAR(255))
		--	,[VersionSource]         = CAST([VersionSource] AS NVARCHAR(255))
			,[DeliveryType]          = CAST([DeliveryType] AS NVARCHAR(255))
			,[StartDate]             = CAST([StartDate] AS NVARCHAR(255))
			,[MeasQualifier]         = CAST([MeasQualifier] AS NVARCHAR(255))
			,[MeasureID]             = CAST([MeasureID] AS NVARCHAR(255))
			,[EnergyImpactID]        = CAST([EnergyImpactID] AS NVARCHAR(255))
			,[GSIA_ID]               = CAST([GSIA_ID] AS NVARCHAR(255))
			,[NTG_ID]                = CAST([NTG_ID] AS NVARCHAR(255))
			,[EUL_ID]                = CAST([EUL_ID] AS NVARCHAR(255))
			,[RUL_ID]                = CAST([RUL_ID] AS NVARCHAR(255))
			,[MeasCostID]            = CAST([MeasCostID] AS NVARCHAR(255))
			,[StdCostID]             = CAST([StdCostID] AS NVARCHAR(255))
		--	,[MeasImpactType]        = CAST([MeasImpactType] AS NVARCHAR(255))
			,[UseCategory]           = CAST([UseCategory] AS NVARCHAR(255))
			,[UseSubCategory]        = CAST([UseSubCategory] AS NVARCHAR(255))
			,[TechGroup]             = CAST([TechGroup] AS NVARCHAR(255))
			,[TechType]              = CAST([TechType] AS NVARCHAR(255))
			,[IETableName]           = CAST([IETableName] AS NVARCHAR(255))
			,[MeasTechID]            = CAST([MeasTechID] AS NVARCHAR(255))
			,[LaborRate]             = CAST([LaborRate] AS NVARCHAR(255))
			,[LocCostAdj]            = CAST([LocCostAdj] AS NVARCHAR(255))
			,[PreDesc]               = CAST([PreDesc] AS NVARCHAR(1024))
			,[StdDesc]               = CAST([StdDesc] AS NVARCHAR(1024))
		--	,[PreTechGroup]          = CAST([PreTechGroup] AS NVARCHAR(255))
		--	,[PreTechType]           = CAST([PreTechType] AS NVARCHAR(255))
		--	,[StdTechGroup]          = CAST([StdTechGroup] AS NVARCHAR(255))
		--	,[StdTechType]           = CAST([StdTechType] AS NVARCHAR(255))
			,[MeasImpactCalcType]    = CAST([MeasImpactCalcType] AS NVARCHAR(255))
	FROM	 [Staging].[DeemedMeasure];


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Completed!';

END;
GO
