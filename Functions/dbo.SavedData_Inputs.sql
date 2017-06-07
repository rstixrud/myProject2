SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\dbo.SavedData_Inputs.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[SavedData_Inputs]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [dbo].[SavedData_Inputs];
END;
GO

CREATE FUNCTION [dbo].[SavedData_Inputs] (@CEDARSJobID AS NVARCHAR(35), @CETJobID AS INT) 
RETURNS TABLE 
AS 
RETURN 
( 
	SELECT	 [JobID]                  = @CEDARSJobID
			,[CEInputID]              = ISNULL([CEInputID], '')
			,[PA]                     = ISNULL([PA], '')
			,[PrgID]                  = ISNULL([PrgID], '')
			,[ClaimYearQuarter]       = ISNULL([ClaimYearQuarter], '')
			,[MeasDescription]        = ISNULL([MeasDescription], '')
			,[MeasImpactType]         = ISNULL([MeasImpactType], '')
			,[MeasCode]               = ISNULL([MeasCode], '')
			,[MeasureID]              = ISNULL([MeasureID], '')
			,[E3TargetSector]         = ISNULL([E3TargetSector], '')
			,[E3MeaElecEndUseShape]   = ISNULL([E3MeaElecEndUseShape], '')
			,[E3ClimateZone]          = ISNULL([E3ClimateZone], '')
			,[E3GasSavProfile]        = ISNULL([E3GasSavProfile], '')
			,[E3GasSector]            = ISNULL([E3GasSector], '')
			,[NumUnits]               = ISNULL([NumUnits], 0)
			,[EUL_ID]                 = ISNULL([EUL_ID], '')
			,[EUL_Yrs]                = ISNULL([EUL_Yrs], 0)
			,[RUL_ID]                 = ISNULL([RUL_ID], '')
			,[RUL_Yrs]                = ISNULL([RUL_Yrs], 0)
			,[NTG_ID]                 = ISNULL([NTG_ID], '')
			,[NTGRkW]                 = ISNULL([NTGRkW], 0)
			,[NTGRkWh]                = ISNULL([NTGRkWh], 0)
			,[NTGRTherm]              = ISNULL([NTGRTherm], 0)
			,[NTGRCost]               = ISNULL([NTGRCost], 0)
			,[InstallationRatekW]     = ISNULL([InstallationRatekW], 0)
			,[InstallationRatekWh]    = ISNULL([InstallationRatekWh], 0)
			,[InstallationRateTherm]  = ISNULL([InstallationRateTherm], 0)
			,[InstallationRateCost]   = ISNULL([InstallationRateCost], 0)
			,[RealizationRatekW]      = ISNULL([RealizationRatekW], 0)
			,[RealizationRatekWh]     = ISNULL([RealizationRatekWh], 0)
			,[RealizationRateTherm]   = ISNULL([RealizationRateTherm], 0)
			,[RealizationRateCost]    = ISNULL([RealizationRateCost], 0)
			,[UnitkW1stBaseline]      = ISNULL([UnitkW1stBaseline], 0)
			,[UnitkW2ndBaseline]      = ISNULL([UnitkW2ndBaseline], 0)
			,[UnitkWh1stBaseline]     = ISNULL([UnitkWh1stBaseline], 0)
			,[UnitkWh2ndBaseline]     = ISNULL([UnitkWh2ndBaseline], 0)
			,[UnitTherm1stBaseline]   = ISNULL([UnitTherm1stBaseline], 0)
			,[UnitTherm2ndBaseline]   = ISNULL([UnitTherm2ndBaseline], 0)
			,[UnitMeaCost1stBaseline] = ISNULL([UnitMeaCost1stBaseline], 0)
			,[UnitMeaCost2ndBaseline] = ISNULL([UnitMeaCost2ndBaseline], 0)
			,[UnitDirectInstallLab]   = ISNULL([UnitDirectInstallLab], 0)
			,[UnitDirectInstallMat]   = ISNULL([UnitDirectInstallMat], 0)
			,[UnitEndUserRebate]      = ISNULL([UnitEndUserRebate], 0)
			,[UnitIncentiveToOthers]  = ISNULL([UnitIncentiveToOthers], 0)
			,[Sector]                 = ISNULL([Sector], '')
			,[UseCategory]            = ISNULL([UseCategory], '')
			,[UseSubCategory]         = ISNULL([UseSubCategory], '')
			,[Residential_Flag]       = ISNULL([Residential_Flag], 0)
			,[Upstream_Flag]          = ISNULL([Upstream_Flag], 0)
			,[GSIA_ID]                = ISNULL([GSIA_ID], '')
			,[BldgType]               = ISNULL([BldgType], '')
			,[DeliveryType]           = ISNULL([DeliveryType], '')
			,[MeasAppType]            = ISNULL([MeasAppType], '')
			,[NormUnit]               = ISNULL([NormUnit], '')
			,[PreDesc]                = ISNULL([PreDesc], '')
			,[PreTechGroup]           = ISNULL([PreTechGroup], '')
			,[PreTechType]            = ISNULL([PreTechType], '')
			,[SourceDesc]             = ISNULL([SourceDesc], '')
			,[StdDesc]                = ISNULL([StdDesc], '')
			,[StdTechGroup]           = ISNULL([StdTechGroup], '')
			,[StdTechType]            = ISNULL([StdTechType], '')
			,[TechGroup]              = ISNULL([TechGroup], '')
			,[TechType]               = ISNULL([TechType], '')
			,[Version]                = ISNULL([Version], '')
			,[VersionSource]          = ISNULL([VersionSource], '')
			,[Comments]               = ISNULL([Comments], '')

	FROM	 [dbo].[CEDARS_CET_SavedInputCEDARS] WITh(NOLOCK)

	WHERE	 [JobID] = @CETJobID
);
GO
