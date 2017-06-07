RAISERROR ('*** Executing SQL: "...\Tables\Staging.Claim.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[Claim]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[Claim]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[Claim]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [Staging].[Claim]
	(
		 [ClaimID]                   NVARCHAR(MAX)     NULL
		,[SiteID]                    NVARCHAR(MAX)     NULL
		,[PrgID]                     NVARCHAR(MAX) NOT NULL
		,[ImplementationPA]          NVARCHAR(MAX)     NULL
		,[ImplementationID]          NVARCHAR(MAX)     NULL
		,[BldgType]                  NVARCHAR(MAX)     NULL
		,[BldgLoc]                   NVARCHAR(MAX)     NULL
		,[BldgVint]                  NVARCHAR(MAX)     NULL
		,[BldgHVAC]                  NVARCHAR(MAX)     NULL
		,[NormUnit]                  NVARCHAR(MAX)     NULL
		,[Sector]                    NVARCHAR(MAX)     NULL
		,[MeasAppType]               NVARCHAR(MAX)     NULL
		,[MeasImpactType]            NVARCHAR(MAX)     NULL --New Field
		,[DeliveryType]              NVARCHAR(MAX)     NULL
		,[PrgElement]                NVARCHAR(MAX)     NULL
		,[ProjectID]                 NVARCHAR(MAX)     NULL
		,[ProjectDescription]        NVARCHAR(MAX)     NULL
		,[NAICSBldgType]             NVARCHAR(MAX)     NULL
		,[E3TargetSector]            NVARCHAR(MAX)     NULL
		,[E3MeaElecEndUseShape]      NVARCHAR(MAX)     NULL
		,[E3GasSector]               NVARCHAR(MAX)     NULL
		,[E3GasSavProfile]           NVARCHAR(MAX)     NULL
		,[E3ClimateZone]             NVARCHAR(MAX)     NULL
		,[NumUnits]                  FLOAT             NULL
		,[InstalledNumUnits]         FLOAT             NULL
		,[InstalledNormUnit]         NVARCHAR(MAX)     NULL
		,[CombustionType]            NVARCHAR(MAX)     NULL
		,[NTGRkW]                    FLOAT             NULL
		,[NTGRkWh]                   FLOAT             NULL
		,[NTGRTherm]                 FLOAT             NULL
		,[NTGRCost]                  FLOAT             NULL
		,[NTG_ID]                    NVARCHAR(MAX)     NULL
		,[TotalFirstYearGrosskW]     FLOAT             NULL
		,[TotalFirstYearGrosskWh]    FLOAT             NULL
		,[TotalFirstYearGrossTherm]  FLOAT             NULL
		,[TotalFirstYearNetkW]       FLOAT             NULL
		,[TotalFirstYearNetkWh]      FLOAT             NULL
		,[TotalFirstYearNetTherm]    FLOAT             NULL
		,[TotalLifecycleGrosskW]     FLOAT             NULL
		,[TotalLifecycleGrosskWh]    FLOAT             NULL
		,[TotalLifecycleGrossTherm]  FLOAT             NULL
		,[TotalLifecycleNetkW]       FLOAT             NULL
		,[TotalLifecycleNetkWh]      FLOAT             NULL
		,[TotalLifecycleNetTherm]    FLOAT             NULL
		,[TotalGrossMeasureCost]     FLOAT             NULL
		,[TotalGrossMeasureCost_ER]  FLOAT             NULL
		,[TotalGrossIncentive]       FLOAT             NULL
		,[UnitEndUserRebate]         FLOAT             NULL
		,[UnitIncentiveToOthers]     FLOAT             NULL
		,[UnitDirectInstallLab]      FLOAT             NULL
		,[UnitDirectInstallMat]      FLOAT             NULL
		,[UnitMeaCost1stBaseline]    FLOAT             NULL
		,[UnitMeaCost2ndBaseline]    FLOAT             NULL
		,[WhySavingsZeroed]          NVARCHAR(MAX)     NULL
		,[WhyCostsZeroed]            NVARCHAR(MAX)     NULL
		,[PartialPaymentPercent]     FLOAT             NULL
		,[PartialPaymentFinal_Flag]  BIT               NULL
		,[Upstream_Flag]             BIT               NULL
		,[Residential_Flag]          BIT               NULL
		,[EUC_Flag]                  BIT               NULL
		,[LGP_Flag]                  BIT               NULL
		,[REN_Flag]                  BIT               NULL
		,[OBF_Flag]                  BIT               NULL
		,[Prop39_Flag]               BIT               NULL
		,[WaterOnly_Flag]            BIT               NULL --New Field
		,[PublicK_12_Flag]           BIT               NULL
		,[SchoolIdentifier]          NVARCHAR(MAX)     NULL
		,[FundingCycle]              NVARCHAR(MAX)     NULL
		,[FinancingPrgID]            NVARCHAR(MAX)     NULL --New Field
		,[ClaimYearQuarter]          NVARCHAR(MAX)     NULL
		,[ApplicationCode]           NVARCHAR(MAX)     NULL
		,[ApplicationDate]           DATE              NULL
		,[InstallationDate]          DATE              NULL
		,[PaidDate]                  DATE              NULL
		,[CustomerAgreementDate]     DATE              NULL
		,[ProjectCompletionDate]     DATE              NULL
		,[AuthorizedSignatureDate]   DATE              NULL
	--	,[ClaimDate]                 DATE              NULL
		,[MarketEffectsBenefits]     NVARCHAR(MAX)     NULL --New Field
		,[MarketEffectsCosts]        NVARCHAR(MAX)     NULL --New Field
		,[RateScheduleElec]          NVARCHAR(MAX)     NULL --New Field
		,[RateScheduleGas]           NVARCHAR(MAX)     NULL --New Field
		,[Comments]                  NVARCHAR(MAX)     NULL --New Field
		,[ExAnteFirstYearGrosskW]    FLOAT             NULL
		,[ExAnteFirstYearGrosskWh]   FLOAT             NULL
		,[ExAnteFirstYearGrossTherm] FLOAT             NULL
		,[ExAnteFirstYearNetkW]      FLOAT             NULL
		,[ExAnteFirstYearNetkWh]     FLOAT             NULL
		,[ExAnteFirstYearNetTherm]   FLOAT             NULL
		,[ExAnteLifecycleGrosskW]    FLOAT             NULL
		,[ExAnteLifecycleGrosskWh]   FLOAT             NULL
		,[ExAnteLifecycleGrossTherm] FLOAT             NULL
		,[ExAnteLifecycleNetkW]      FLOAT             NULL
		,[ExAnteLifecycleNetkWh]     FLOAT             NULL
		,[ExAnteLifecycleNetTherm]   FLOAT             NULL
		,[ExAnteFirstYearGrossBTU]   FLOAT             NULL
		,[ExAnteGrossMeasureCost]    FLOAT             NULL
		,[ExAnteGrossMeasureCost_ER] FLOAT             NULL
		,[ExAnteGrossIncentive]      FLOAT             NULL
	) 
	ON [DATA]; 
END; 
GO 
