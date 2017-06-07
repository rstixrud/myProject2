SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCedarsWaterMeasure.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCedarsWaterMeasure]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCedarsWaterMeasure] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.InsertCedarsWaterMeasure.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCedarsWaterMeasure]
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


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Executing: [dbo].[InsertCedarsWaterMeasure]...';


	INSERT INTO [dbo].[CEDARS_WaterMeasure]
	(
			 [ClaimID]
			,[WaterMeasCode]
			,[SavingsProfile]
			,[HydrologicRegion]
			,[Sector]
			,[WaterUse]
			,[Gallons]
			,[AvgAnnualIOUkWh]
			,[AvgAnnualNonIOUkWh]
			,[AvgAnnualTherm]
			,[SourceDesc]
	)
	SELECT	 [ClaimID]            = CAST([ClaimID] AS NVARCHAR(255))
			,[WaterMeasCode]      = CAST([WaterMeasCode] AS NVARCHAR(255))
			,[SavingsProfile]     = CAST([SavingsProfile] AS NVARCHAR(255))
			,[HydrologicRegion]   = CAST([HydrologicRegion] AS NVARCHAR(255))
			,[Sector]             = CAST([Sector] AS NVARCHAR(255))
			,[WaterUse]           = CAST([WaterUse] AS NVARCHAR(255))
			,[Gallons]            = CAST([Gallons] AS FLOAT)
			,[AvgAnnualIOUkWh]    = CAST([AvgAnnualIOUkWh] AS FLOAT)
			,[AvgAnnualNonIOUkWh] = CAST([AvgAnnualNonIOUkWh] AS FLOAT)
			,[AvgAnnualTherm]     = CAST([AvgAnnualTherm] AS FLOAT)
			,[SourceDesc]         = CAST([SourceDesc] AS NVARCHAR(100))
	FROM	 [Staging].[WaterMeasure];


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Completed!';


END;
GO
