SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCETInputMeasure.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCETInputMeasure]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCETInputMeasure] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.InsertCETInputMeasure.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCETInputMeasure]
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

	
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Executing: [dbo].[InsertCETInputMeasure]...';


	DECLARE @PA AS NVARCHAR(10);
	
	SET @PA = (SELECT TOP(1) [PA] FROM [Staging].[ProgramCost]);

	DELETE FROM [dbo].[CET_InputMeasureCEDARS];

	INSERT INTO [dbo].[CET_InputMeasureCEDARS] 
	( 
			 [JobID] 
			,[CEInputID] 
			,[PA] 
			,[PrgID] 
			,[ClaimYearQuarter] 
			,[MeasDescription] 
			,[MeasImpactType] 
			,[MeasCode] 
			,[MeasureID] 
			,[E3TargetSector] 
			,[E3MeaElecEndUseShape] 
			,[E3ClimateZone] 
			,[E3GasSavProfile] 
			,[E3GasSector] 
			,[NumUnits] 
			,[EUL_ID] 
			,[EUL_Yrs] 
			,[RUL_ID] 
			,[RUL_Yrs] 
			,[NTG_ID] 
			,[NTGRkW] 
			,[NTGRkWh] 
			,[NTGRTherm] 
			,[NTGRCost] 
			,[InstallationRatekW] 
			,[InstallationRatekWh] 
			,[InstallationRateTherm] 
			,[InstallationRateCost] 
			,[RealizationRatekW] 
			,[RealizationRatekWh] 
			,[RealizationRateTherm] 
			,[RealizationRateCost] 
			,[UnitkW1stBaseline] 
			,[UnitkW2ndBaseline] 
			,[UnitkWh1stBaseline] 
			,[UnitkWh2ndBaseline] 
			,[UnitTherm1stBaseline] 
			,[UnitTherm2ndBaseline] 
			,[UnitMeaCost1stBaseline] 
			,[UnitMeaCost2ndBaseline] 
			,[UnitDirectInstallLab] 
			,[UnitDirectInstallMat] 
			,[UnitEndUserRebate] 
			,[UnitIncentiveToOthers] 
			,[Sector] 
			,[UseCategory] 
			,[UseSubCategory] 
			,[Residential_Flag] 
			,[Upstream_Flag] 
			,[GSIA_ID] 
			,[BldgType] 
			,[DeliveryType] 
			,[MeasAppType] 
			,[NormUnit] 
			,[PreDesc] 
			,[PreTechGroup] 
			,[PreTechType] 
			,[SourceDesc] 
			,[StdDesc] 
			,[StdTechGroup] 
			,[StdTechType] 
			,[TechGroup] 
			,[TechType] 
			,[Version] 
			,[VersionSource] 
			,[Comments] 
	) 
	SELECT	 [JobID]
			,[CEInputID]
			,[PA]
			,[PrgID]
			,[ClaimYearQuarter]
			,[MeasDescription]
			,[MeasImpactType]
			,[MeasCode]
			,[MeasureID]
			,[E3TargetSector]
			,[E3MeaElecEndUseShape]
			,[E3ClimateZone]
			,[E3GasSavProfile]
			,[E3GasSector]
			,[NumUnits]
			,[EUL_ID]
			,[EUL_Yrs]
			,[RUL_ID]
			,[RUL_Yrs]
			,[NTG_ID]
			,[NTGRkW]
			,[NTGRkWh]
			,[NTGRTherm]
			,[NTGRCost]
			,[InstallationRatekW]
			,[InstallationRatekWh]
			,[InstallationRateTherm]
			,[InstallationRateCost]
			,[RealizationRatekW]
			,[RealizationRatekWh]
			,[RealizationRateTherm]
			,[RealizationRateCost]
			,[UnitkW1stBaseline]
			,[UnitkW2ndBaseline]
			,[UnitkWh1stBaseline]
			,[UnitkWh2ndBaseline]
			,[UnitTherm1stBaseline]
			,[UnitTherm2ndBaseline]
			,[UnitMeaCost1stBaseline]
			,[UnitMeaCost2ndBaseline]
			,[UnitDirectInstallLab]
			,[UnitDirectInstallMat]
			,[UnitEndUserRebate]
			,[UnitIncentiveToOthers]
			,[Sector]
			,[UseCategory]
			,[UseSubCategory]
			,[Residential_Flag]
			,[Upstream_Flag]
			,[GSIA_ID]
			,[BldgType]
			,[DeliveryType]
			,[MeasAppType]
			,[NormUnit]
			,[PreDesc]
			,[PreTechGroup]
			,[PreTechType]
			,[SourceDesc]
			,[StdDesc]
			,[StdTechGroup]
			,[StdTechType]
			,[TechGroup]
			,[TechType]
			,[Version]
			,[VersionSource]
			,[Comments]
	FROM	 [dbo].[CETMGMT_InputMeasureView] WITh(NOLOCK)
	WHERE	 [PA] = @PA;


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Completed!';

END;
GO
