RAISERROR ('*** Executing SQL: "...\Views\dbo.Claim_CET_MeasureView.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[views] WHERE [object_id] = OBJECT_ID(N'[dbo].[Claim_CET_MeasureView]'))
BEGIN
	DROP VIEW [dbo].[Claim_CET_MeasureView];
END;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE VIEW [dbo].[Claim_CET_MeasureView] 
AS
	SELECT	 [JobID]                  = -1 
			,[CEInputID]              = [Claim].[ClaimID]
			,[PA]                     = CASE WHEN [Claim].[ClaimID] LIKE 'SDGE%' THEN 'SDGE' ELSE LEFT([Claim].[ClaimID], 3) END
			,[PrgID]                  = [Claim].[PrgID]
			,[ClaimYearQuarter]       = [Claim].[ClaimYearQuarter]
			,[MeasDescription]        = COALESCE([DeemedMeasure].[MeasDescription], [CustomMeasure].[MeasDescription])
			,[MeasImpactType]         = [Claim].[MeasImpactType]
			,[MeasCode]               = COALESCE([DeemedMeasure].[MeasCode], [CustomMeasure].[MeasCode])
			,[MeasureID]              = [DeemedMeasure].[MeasureID]
			,[E3TargetSector]         = [Claim].[E3TargetSector]
			,[E3MeaElecEndUseShape]   = [Claim].[E3MeaElecEndUseShape]
			,[E3ClimateZone]          = [Claim].[E3ClimateZone]
			,[E3GasSavProfile]        = [Claim].[E3GasSavProfile]
			,[E3GasSector]            = [Claim].[E3GasSector]
			,[NumUnits]               = [Claim].[NumUnits]
			,[EUL_ID]                 = [DeemedMeasure].[EUL_ID]
			,[EUL_Yrs]                = COALESCE([DeemedMeasure].[EUL_Yrs], [CustomMeasure].[EUL_Yrs])
			,[RUL_ID]                 = [DeemedMeasure].[RUL_ID]
			,[RUL_Yrs]                = COALESCE([DeemedMeasure].[RUL_Yrs], [CustomMeasure].[RUL_Yrs])
			,[NTG_ID]                 = COALESCE([Claim].[NTG_ID], [DeemedMeasure].[NTG_ID])
			,[NTGRkW]                 = [Claim].[NTGRkW]
			,[NTGRkWh]                = [Claim].[NTGRkWh]
			,[NTGRTherm]              = [Claim].[NTGRTherm]
			,[NTGRCost]               = [Claim].[NTGRCost]
			,[InstallationRatekW]     = COALESCE([DeemedMeasure].[InstallationRatekW], [CustomMeasure].[InstallationRatekW])
			,[InstallationRatekWh]    = COALESCE([DeemedMeasure].[InstallationRatekWh], [CustomMeasure].[InstallationRatekWh])
			,[InstallationRateTherm]  = COALESCE([DeemedMeasure].[InstallationRateTherm], [CustomMeasure].[InstallationRateTherm])
			,[InstallationRateCost]   = 1
			,[RealizationRatekW]      = COALESCE([DeemedMeasure].[RealizationRatekW], [CustomMeasure].[RealizationRatekW])
			,[RealizationRatekWh]     = COALESCE([DeemedMeasure].[RealizationRatekWh], [CustomMeasure].[RealizationRatekWh])
			,[RealizationRateTherm]   = COALESCE([DeemedMeasure].[RealizationRateTherm], [CustomMeasure].[RealizationRateTherm])
			,[RealizationRateCost]    = 1
			,[UnitkW1stBaseline]      = COALESCE([DeemedMeasure].[UnitkW1stBaseline], [CustomMeasure].[UnitkW1stBaseline])
			,[UnitkW2ndBaseline]      = COALESCE([DeemedMeasure].[UnitkW2ndBaseline], [CustomMeasure].[UnitkW2ndBaseline])
			,[UnitkWh1stBaseline]     = COALESCE([DeemedMeasure].[UnitkWh1stBaseline], [CustomMeasure].[UnitkWh1stBaseline])
			,[UnitkWh2ndBaseline]     = COALESCE([DeemedMeasure].[UnitkWh2ndBaseline], [CustomMeasure].[UnitkWh2ndBaseline])
			,[UnitTherm1stBaseline]   = COALESCE([DeemedMeasure].[UnitTherm1stBaseline], [CustomMeasure].[UnitTherm1stBaseline])
			,[UnitTherm2ndBaseline]   = COALESCE([DeemedMeasure].[UnitTherm2ndBaseline], [CustomMeasure].[UnitTherm2ndBaseline])
			,[UnitMeaCost1stBaseline] = [Claim].[UnitMeaCost1stBaseline]
			,[UnitMeaCost2ndBaseline] = [Claim].[UnitMeaCost2ndBaseline]
			,[UnitDirectInstallLab]   = [Claim].[UnitDirectInstallLab]
			,[UnitDirectInstallMat]   = [Claim].[UnitDirectInstallMat]
			,[UnitEndUserRebate]      = [Claim].[UnitEndUserRebate]
			,[UnitIncentiveToOthers]  = [Claim].[UnitIncentiveToOthers]
			,[Sector]                 = [Claim].[Sector]
			,[UseCategory]            = [DeemedMeasure].[UseCategory]
			,[UseSubCategory]         = COALESCE([DeemedMeasure].[UseSubCategory],[CustomMeasure].[UseSubCategory])
			,[Residential_Flag]       = [Claim].[Residential_Flag]
			,[Upstream_Flag]          = [Claim].[Upstream_Flag]
			,[GSIA_ID]                = [DeemedMeasure].[GSIA_ID]
			,[BldgType]               = [Claim].[BldgType]
			,[DeliveryType]           = COALESCE([Claim].[DeliveryType], [DeemedMeasure].[DeliveryType])
			,[MeasAppType]            = COALESCE([Claim].[MeasAppType], [DeemedMeasure].[MeasAppType], [CustomMeasure].[MeasAppType])
			,[NormUnit]               = [Claim].[NormUnit]
			,[PreDesc]                = [DeemedMeasure].[PreDesc]
			,[PreTechGroup]           = NULL
			,[PreTechType]            = NULL
			,[SourceDesc]             = [DeemedMeasure].[SourceDesc]
			,[StdDesc]                = [DeemedMeasure].[StdDesc]
			,[StdTechGroup]           = NULL
			,[StdTechType]            = NULL
			,[TechGroup]              = [DeemedMeasure].[TechGroup]
			,[TechType]               = COALESCE([DeemedMeasure].[TechType], [CustomMeasure].[TechType])
			,[Version]                = [DeemedMeasure].[Version]
			,[VersionSource]          = NULL
			,[Comments]               = COALESCE([DeemedMeasure].[Comments], [CustomMeasure].[Comments])

	FROM	 [dbo].[CEDARS_Claim] AS [Claim] WITh(NOLOCK)

			 LEFT OUTER JOIN [dbo].[CEDARS_DeemedMeasure] AS [DeemedMeasure] WITh(NOLOCK)
					 ON [DeemedMeasure].[ClaimID] = [Claim].[ClaimID]

			 LEFT OUTER JOIN [dbo].[CEDARS_CustomMeasure] AS [CustomMeasure] WITh(NOLOCK)
					 ON [CustomMeasure].[ClaimID] = [Claim].[ClaimID];
GO
