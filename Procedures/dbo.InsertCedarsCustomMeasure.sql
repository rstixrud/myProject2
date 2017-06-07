SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCedarsCustomMeasure.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCedarsCustomMeasure]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCedarsCustomMeasure] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.InsertCedarsCustomMeasure.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCedarsCustomMeasure]
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


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Executing: [dbo].[InsertCedarsCustomMeasure]...';


	INSERT INTO [dbo].[CEDARS_CustomMeasure]
	(
			 [ClaimID]
			,[MeasCode]
			,[MeasAppType]
			,[MeasDescription]
			,[UseSubCategory]
			,[TechType]
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
			,[UseCategory] --New Field
			,[TechGroup] --New Field
			,[PreDesc] --New Field
			,[StdDesc] --New Field
			,[MeasInflation] --New Field
	)
	SELECT	 [ClaimID]               = CAST([ClaimID] AS NVARCHAR(255))
			,[MeasCode]              = CAST([MeasCode] AS NVARCHAR(255))
			,[MeasAppType]           = CAST([MeasAppType] AS NVARCHAR(255))
			,[MeasDescription]       = CAST([MeasDescription] AS NVARCHAR(255))
			,[UseSubCategory]        = CAST([UseSubCategory] AS NVARCHAR(255))
			,[TechType]              = CAST([TechType] AS NVARCHAR(255))
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
			,[UseCategory] --New Field
			,[TechGroup] --New Field
			,[PreDesc] --New Field
			,[StdDesc] --New Field
			,[MeasInflation] --New Field
	FROM	 [Staging].[CustomMeasure];


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Completed!';


END;
GO
