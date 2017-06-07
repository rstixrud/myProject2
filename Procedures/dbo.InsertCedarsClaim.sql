SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCedarsClaim.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCedarsClaim]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCedarsClaim] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script:		dbo.InsertCedarsClaim.sql

Synopsis:	

Notes:		

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
04/04/2016		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCedarsClaim]
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


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Executing: [dbo].[InsertCedarsClaim]...';


	INSERT INTO [dbo].[CEDARS_Claim]
	(
			 [ClaimID]
			,[SiteID]
			,[PrgID]
			,[ImplementationPA]
			,[ImplementationID]
			,[BldgType]
			,[BldgLoc]
			,[BldgVint]
			,[BldgHVAC]
			,[NormUnit]
			,[Sector]
			,[MeasAppType]
			,[DeliveryType]
			,[PrgElement]
			,[ProjectID]
			,[ProjectDescription]
			,[NAICSBldgType]
			,[E3TargetSector]
			,[E3MeaElecEndUseShape]
			,[E3GasSector]
			,[E3GasSavProfile]
			,[E3ClimateZone]
			,[NumUnits]
			,[InstalledNumUnits]
			,[InstalledNormUnit]
			,[CombustionType]
			,[NTGRkW]
			,[NTGRkWh]
			,[NTGRTherm]
			,[NTGRCost]
			,[NTG_ID]
			,[TotalFirstYearGrosskW]
			,[TotalFirstYearGrosskWh]
			,[TotalFirstYearGrossTherm]
			,[TotalFirstYearNetkW]
			,[TotalFirstYearNetkWh]
			,[TotalFirstYearNetTherm]
			,[TotalLifecycleGrosskW]
			,[TotalLifecycleGrosskWh]
			,[TotalLifecycleGrossTherm]
			,[TotalLifecycleNetkW]
			,[TotalLifecycleNetkWh]
			,[TotalLifecycleNetTherm]
			,[TotalGrossMeasureCost]
			,[TotalGrossMeasureCost_ER]
			,[TotalGrossIncentive]
			,[UnitEndUserRebate]
			,[UnitIncentiveToOthers]
			,[UnitDirectInstallLab]
			,[UnitDirectInstallMat]
			,[UnitMeaCost1stBaseline]
			,[UnitMeaCost2ndBaseline]
			,[WhySavingsZeroed]
			,[WhyCostsZeroed]
			,[PartialPaymentPercent]
			,[PartialPaymentFinal_Flag]
			,[Upstream_Flag]
			,[Residential_Flag]
			,[EUC_Flag]
			,[LGP_Flag]
			,[REN_Flag]
			,[OBF_Flag]
			,[Prop39_Flag]
			,[PublicK_12_Flag]
			,[SchoolIdentifier]
			,[FundingCycle]
			,[ClaimYearQuarter]
			,[ApplicationCode]
			,[ApplicationDate]
			,[InstallationDate]
			,[PaidDate]
			,[CustomerAgreementDate]
			,[ProjectCompletionDate]
			,[AuthorizedSignatureDate]
		--	,[ClaimDate]
			,[ExAnteFirstYearGrosskW]
			,[ExAnteFirstYearGrosskWh]
			,[ExAnteFirstYearGrossTherm]
			,[ExAnteFirstYearNetkW]
			,[ExAnteFirstYearNetkWh]
			,[ExAnteFirstYearNetTherm]
			,[ExAnteLifecycleGrosskW]
			,[ExAnteLifecycleGrosskWh]
			,[ExAnteLifecycleGrossTherm]
			,[ExAnteLifecycleNetkW]
			,[ExAnteLifecycleNetkWh]
			,[ExAnteLifecycleNetTherm]
			,[ExAnteFirstYearGrossBTU]
			,[ExAnteGrossMeasureCost]
			,[ExAnteGrossMeasureCost_ER]
			,[ExAnteGrossIncentive]
			,[MeasImpactType] --New Field
			,[WaterOnly_Flag] --New Field
			,[FinancingPrgID] --New Field
			,[MarketEffectsBenefits] --New Field
			,[MarketEffectsCosts] --New Field
			,[RateScheduleElec] --New Field
			,[RateScheduleGas] --New Field
			,[Comments] --New Field
	)
	SELECT	 [ClaimID]
			,[SiteID]
			,[PrgID]
			,[ImplementationPA]
			,[ImplementationID]
			,[BldgType]
			,[BldgLoc]
			,[BldgVint]
			,[BldgHVAC]
			,[NormUnit]
			,[Sector]
			,[MeasAppType]
			,[DeliveryType]
			,[PrgElement]
			,[ProjectID]
			,[ProjectDescription]
			,[NAICSBldgType]
			,[E3TargetSector]
			,[E3MeaElecEndUseShape]
			,[E3GasSector]
			,[E3GasSavProfile]
			,[E3ClimateZone]
			,[NumUnits]
			,[InstalledNumUnits]
			,[InstalledNormUnit]
			,[CombustionType]
			,[NTGRkW]
			,[NTGRkWh]
			,[NTGRTherm]
			,[NTGRCost]
			,[NTG_ID]
			,[TotalFirstYearGrosskW]
			,[TotalFirstYearGrosskWh]
			,[TotalFirstYearGrossTherm]
			,[TotalFirstYearNetkW]
			,[TotalFirstYearNetkWh]
			,[TotalFirstYearNetTherm]
			,[TotalLifecycleGrosskW]
			,[TotalLifecycleGrosskWh]
			,[TotalLifecycleGrossTherm]
			,[TotalLifecycleNetkW]
			,[TotalLifecycleNetkWh]
			,[TotalLifecycleNetTherm]
			,[TotalGrossMeasureCost]
			,[TotalGrossMeasureCost_ER]
			,[TotalGrossIncentive]
			,[UnitEndUserRebate]
			,[UnitIncentiveToOthers]
			,[UnitDirectInstallLab]
			,[UnitDirectInstallMat]
			,[UnitMeaCost1stBaseline]
			,[UnitMeaCost2ndBaseline]
			,[WhySavingsZeroed]
			,[WhyCostsZeroed]
			,[PartialPaymentPercent]
			,[PartialPaymentFinal_Flag]
			,[Upstream_Flag]
			,[Residential_Flag]
			,[EUC_Flag]
			,[LGP_Flag]
			,[REN_Flag]
			,[OBF_Flag]
			,[Prop39_Flag]
			,[PublicK_12_Flag]
			,[SchoolIdentifier]
			,[FundingCycle]
			,[ClaimYearQuarter]
			,[ApplicationCode]
			,[ApplicationDate] = CONVERT(NVARCHAR, REPLACE([ApplicationDate], '-', '/'), 101)
			,[InstallationDate] = CONVERT(NVARCHAR, REPLACE([InstallationDate], '-', '/'), 101)
			,[PaidDate] = CONVERT(NVARCHAR, REPLACE([PaidDate], '-', '/'), 101)
			,[CustomerAgreementDate] = CONVERT(NVARCHAR, REPLACE([CustomerAgreementDate], '-', '/'), 101)
			,[ProjectCompletionDate] = CONVERT(NVARCHAR, REPLACE([ProjectCompletionDate], '-', '/'), 101)
			,[AuthorizedSignatureDate] = CONVERT(NVARCHAR, REPLACE([AuthorizedSignatureDate], '-', '/'), 101)
		--	,[ClaimDate] = CONVERT(NVARCHAR, REPLACE([ClaimDate], '-', '/'), 101)
			,[ExAnteFirstYearGrosskW]
			,[ExAnteFirstYearGrosskWh]
			,[ExAnteFirstYearGrossTherm]
			,[ExAnteFirstYearNetkW]
			,[ExAnteFirstYearNetkWh]
			,[ExAnteFirstYearNetTherm]
			,[ExAnteLifecycleGrosskW]
			,[ExAnteLifecycleGrosskWh]
			,[ExAnteLifecycleGrossTherm]
			,[ExAnteLifecycleNetkW]
			,[ExAnteLifecycleNetkWh]
			,[ExAnteLifecycleNetTherm]
			,[ExAnteFirstYearGrossBTU]
			,[ExAnteGrossMeasureCost]
			,[ExAnteGrossMeasureCost_ER]
			,[ExAnteGrossIncentive]
			,[MeasImpactType] --New Field
			,[WaterOnly_Flag] --New Field
			,[FinancingPrgID] --New Field
			,[MarketEffectsBenefits] --New Field
			,[MarketEffectsCosts] --New Field
			,[RateScheduleElec] --New Field
			,[RateScheduleGas] --New Field
			,[Comments] --New Field
	FROM	 [Staging].[Claim];


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Completed!';


END;
GO
