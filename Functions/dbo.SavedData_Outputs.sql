SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\dbo.SavedData_Outputs.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[SavedData_Outputs]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [dbo].[SavedData_Outputs];
END;
GO

CREATE FUNCTION [dbo].[SavedData_Outputs] (@CEDARSJobID AS NVARCHAR(35), @CETJobID AS INT) 
RETURNS TABLE 
AS 
RETURN 
( 
	SELECT	 [JobID]                             = @CEDARSJobID 
			,[PA]                                = ISNULL([SavedCE].[PA], 0) 
			,[PrgID]                             = [SavedCE].[PrgID] 
			,[CET_ID]                            = [SavedCE].[CET_ID] 
			,[GrossKWh]                          = ISNULL([SavedSavings].[GrossKWh], 0) 
			,[GrossKW]                           = ISNULL([SavedSavings].[GrossKW], 0) 
			,[GrossThm]                          = ISNULL([SavedSavings].[GrossThm], 0) 
			,[NetKWh]                            = ISNULL([SavedSavings].[NetKWh], 0) 
			,[NetKW]                             = ISNULL([SavedSavings].[NetKW], 0) 
			,[NetThm]                            = ISNULL([SavedSavings].[NetThm], 0) 
			,[LifecycleGrossKWh]                 = ISNULL([SavedSavings].[LifecycleGrossKWh], 0) 
			,[LifecycleGrossThm]                 = ISNULL([SavedSavings].[LifecycleGrossThm], 0) 
			,[LifecycleNetKWh]                   = ISNULL([SavedSavings].[LifecycleNetKWh], 0) 
			,[LifecycleNetThm]                   = ISNULL([SavedSavings].[LifecycleNetThm], 0) 
			,[GoalAttainmentKWh]                 = ISNULL([SavedSavings].[GoalAttainmentKWh], 0) 
			,[GoalAttainmentKW]                  = ISNULL([SavedSavings].[GoalAttainmentKW], 0) 
			,[GoalAttainmentThm]                 = ISNULL([SavedSavings].[GoalAttainmentThm], 0) 
			,[FirstYearGrossKWh]                 = ISNULL([SavedSavings].[FirstYearGrossKWh], 0) 
			,[FirstYearGrossKW]                  = ISNULL([SavedSavings].[FirstYearGrossKW], 0) 
			,[FirstYearGrossThm]                 = ISNULL([SavedSavings].[FirstYearGrossThm], 0) 
			,[FirstYearNetKWh]                   = ISNULL([SavedSavings].[FirstYearNetKWh], 0) 
			,[FirstYearNetKW]                    = ISNULL([SavedSavings].[FirstYearNetKW], 0) 
			,[FirstYearNetThm]                   = ISNULL([SavedSavings].[FirstYearNetThm], 0) 
			,[WeightedSavings]                   = ISNULL([SavedSavings].[WeightedSavings], 0) 
			,[ElecBen]                           = ISNULL([SavedCE].[ElecBen], 0) 
			,[GasBen]                            = ISNULL([SavedCE].[GasBen], 0) 
			,[ElecBenGross]                      = ISNULL([SavedCE].[ElecBenGross], 0) 
			,[GasBenGross]                       = ISNULL([SavedCE].[GasBenGross], 0) 
			,[TRCCost]                           = ISNULL([SavedCE].[TRCCost], 0) 
			,[PACCost]                           = ISNULL([SavedCE].[PACCost], 0) 
			,[TRCCostGross]                      = ISNULL([SavedCE].[TRCCostGross], 0) 
			,[TRCCostNoAdmin]                    = ISNULL([SavedCE].[TRCCostNoAdmin], 0) 
			,[PACCostNoAdmin]                    = ISNULL([SavedCE].[PACCostNoAdmin], 0) 
			,[TRCRatio]                          = ISNULL([SavedCE].[TRCRatio], 0) 
			,[PACRatio]                          = ISNULL([SavedCE].[PACRatio], 0) 
			,[TRCRatioNoAdmin]                   = ISNULL([SavedCE].[TRCRatioNoAdmin], 0) 
			,[PACRatioNoAdmin]                   = ISNULL([SavedCE].[PACRatioNoAdmin], 0) 
			,[BillReducElec]                     = ISNULL([SavedCE].[BillReducElec], 0) 
			,[BillReducGas]                      = ISNULL([SavedCE].[BillReducGas], 0) 
			,[RIMCost]                           = ISNULL([SavedCE].[RIMCost], 0) 
			,[WeightedBenefits]                  = ISNULL([SavedCE].[WeightedBenefits], 0) 
			,[WeightedElecAlloc]                 = ISNULL([SavedCE].[WeightedElecAlloc], 0) 
			,[WeightedProgramCost]               = ISNULL([SavedCE].[WeightedProgramCost], 0) 
			,[NetElecCO2]                        = ISNULL([SavedEmissions].[NetElecCO2], 0) 
			,[NetGasCO2]                         = ISNULL([SavedEmissions].[NetGasCO2], 0) 
			,[GrossElecCO2]                      = ISNULL([SavedEmissions].[GrossElecCO2], 0) 
			,[GrossGasCO2]                       = ISNULL([SavedEmissions].[GrossGasCO2], 0) 
			,[NetElecCO2Lifecycle]               = ISNULL([SavedEmissions].[NetElecCO2Lifecycle], 0) 
			,[NetGasCO2Lifecycle]                = ISNULL([SavedEmissions].[NetGasCO2Lifecycle], 0) 
			,[GrossElecCO2Lifecycle]             = ISNULL([SavedEmissions].[GrossElecCO2Lifecycle], 0) 
			,[GrossGasCO2Lifecycle]              = ISNULL([SavedEmissions].[GrossGasCO2Lifecycle], 0) 
			,[NetElecNOx]                        = ISNULL([SavedEmissions].[NetElecNOx], 0) 
			,[NetGasNOx]                         = ISNULL([SavedEmissions].[NetGasNOx], 0) 
			,[GrossElecNOx]                      = ISNULL([SavedEmissions].[GrossElecNOx], 0) 
			,[GrossGasNOx]                       = ISNULL([SavedEmissions].[GrossGasNOx], 0) 
			,[NetElecNOxLifecycle]               = ISNULL([SavedEmissions].[NetElecNOxLifecycle], 0) 
			,[NetGasNOxLifecycle]                = ISNULL([SavedEmissions].[NetGasNOxLifecycle], 0) 
			,[GrossElecNOxLifecycle]             = ISNULL([SavedEmissions].[GrossElecNOxLifecycle], 0) 
			,[GrossGasNOxLifecycle]              = ISNULL([SavedEmissions].[GrossGasNOxLifecycle], 0) 
			,[NetPM10]                           = ISNULL([SavedEmissions].[NetPM10], 0) 
			,[GrossPM10]                         = ISNULL([SavedEmissions].[GrossPM10], 0) 
			,[NetPM10Lifecycle]                  = ISNULL([SavedEmissions].[NetPM10Lifecycle], 0) 
			,[GrossPM10Lifecycle]                = ISNULL([SavedEmissions].[GrossPM10Lifecycle], 0) 
			,[IncentiveToOthers]                 = ISNULL([SavedCost].[IncentiveToOthers], 0) 
			,[DILaborCost]                       = ISNULL([SavedCost].[DILaborCost], 0) 
			,[DIMaterialCost]                    = ISNULL([SavedCost].[DIMaterialCost], 0) 
			,[EndUserRebate]                     = ISNULL([SavedCost].[EndUserRebate], 0) 
			,[RebatesandIncents]                 = ISNULL([SavedCost].[RebatesandIncents], 0) 
			,[GrossMeasureCost]                  = ISNULL([SavedCost].[GrossMeasureCost], 0) 
			,[ExcessIncentives]                  = ISNULL([SavedCost].[ExcessIncentives], 0) 
			,[MarkEffectPlusExcessInc]           = ISNULL([SavedCost].[MarkEffectPlusExcessInc], 0) 
			,[GrossParticipantCost]              = ISNULL([SavedCost].[GrossParticipantCost], 0) 
			,[GrossParticipantCostAdjusted]      = ISNULL([SavedCost].[GrossParticipantCostAdjusted], 0) 
			,[NetParticipantCost]                = ISNULL([SavedCost].[NetParticipantCost], 0) 
			,[NetParticipantCostAdjusted]        = ISNULL([SavedCost].[NetParticipantCostAdjusted], 0) 
			,[RebatesandIncentsPV]               = ISNULL([SavedCost].[RebatesandIncentsPV], 0) 
			,[GrossMeasCostPV]                   = ISNULL([SavedCost].[GrossMeasCostPV], 0) 
			,[ExcessIncentivesPV]                = ISNULL([SavedCost].[ExcessIncentivesPV], 0) 
			,[MarkEffectPlusExcessIncPV]         = ISNULL([SavedCost].[MarkEffectPlusExcessIncPV], 0) 
			,[GrossParticipantCostPV]            = ISNULL([SavedCost].[GrossParticipantCostPV], 0) 
			,[GrossParticipantCostAdjustedPV]    = ISNULL([SavedCost].[GrossParticipantCostAdjustedPV], 0) 
			,[NetParticipantCostPV]              = ISNULL([SavedCost].[NetParticipantCostPV], 0) 
			,[NetParticipantCostAdjustedPV]      = ISNULL([SavedCost].[NetParticipantCostAdjustedPV], 0) 
			,[WtdAdminCostsOverheadAndGA]        = ISNULL([SavedCost].[WtdAdminCostsOverheadAndGA], 0) 
			,[WtdAdminCostsOther]                = ISNULL([SavedCost].[WtdAdminCostsOther], 0) 
			,[WtdMarketingOutreach]              = ISNULL([SavedCost].[WtdMarketingOutreach], 0) 
			,[WtdDIActivity]                     = ISNULL([SavedCost].[WtdDIActivity], 0) 
			,[WtdDIInstallation]                 = ISNULL([SavedCost].[WtdDIInstallation], 0) 
			,[WtdDIHardwareAndMaterials]         = ISNULL([SavedCost].[WtdDIHardwareAndMaterials], 0) 
			,[WtdDIRebateAndInspection]          = ISNULL([SavedCost].[WtdDIRebateAndInspection], 0) 
			,[WtdEMV]                            = ISNULL([SavedCost].[WtdEMV], 0) 
			,[WtdUserInputIncentive]             = ISNULL([SavedCost].[WtdUserInputIncentive], 0) 
			,[WtdCostsRecoveredFromOtherSources] = ISNULL([SavedCost].[WtdCostsRecoveredFromOtherSources], 0) 
			,[ProgramCosts]                      = ISNULL([SavedCost].[ProgramCosts], 0) 
			,[TotalExpenditures]                 = ISNULL([SavedCost].[TotalExpenditures], 0) 
			,[DiscountedSavingsGrosskWh]         = ISNULL([SavedCost].[DiscountedSavingsGrosskWh], 0) 
			,[DiscountedSavingsNetkWh]           = ISNULL([SavedCost].[DiscountedSavingsNetkWh], 0) 
			,[DiscountedSavingsGrossThm]         = ISNULL([SavedCost].[DiscountedSavingsGrossThm], 0) 
			,[DiscountedSavingsNetThm]           = ISNULL([SavedCost].[DiscountedSavingsNetThm], 0) 
			,[TRCLifecycleNetBen]                = ISNULL([SavedCost].[TRCLifecycleNetBen], 0) 
			,[PACLifecycleNetBen]                = ISNULL([SavedCost].[PACLifecycleNetBen], 0) 
			,[LevBenElec]                        = ISNULL([SavedCost].[LevBenElec], 0) 
			,[LevBenGas]                         = ISNULL([SavedCost].[LevBenGas], 0) 
			,[LevTRCCost]                        = ISNULL([SavedCost].[LevTRCCost], 0) 
			,[LevTRCCostNoAdmin]                 = ISNULL([SavedCost].[LevTRCCostNoAdmin], 0) 
			,[LevPACCost]                        = ISNULL([SavedCost].[LevPACCost], 0) 
			,[LevPACCostNoAdmin]                 = ISNULL([SavedCost].[LevPACCostNoAdmin], 0) 
			,[LevRIMCost]                        = ISNULL([SavedCost].[LevRIMCost], 0) 
			,[LevNetBenTRCElec]                  = ISNULL([SavedCost].[LevNetBenTRCElec], 0) 
			,[LevNetBenTRCElecNoAdmin]           = ISNULL([SavedCost].[LevNetBenTRCElecNoAdmin], 0) 
			,[LevNetBenPACElec]                  = ISNULL([SavedCost].[LevNetBenPACElec], 0) 
			,[LevNetBenPACElecNoAdmin]           = ISNULL([SavedCost].[LevNetBenPACElecNoAdmin], 0) 
			,[LevNetBenTRCGas]                   = ISNULL([SavedCost].[LevNetBenTRCGas], 0) 
			,[LevNetBenTRCGasNoAdmin]            = ISNULL([SavedCost].[LevNetBenTRCGasNoAdmin], 0) 
			,[LevNetBenPACGas]                   = ISNULL([SavedCost].[LevNetBenPACGas], 0) 
			,[LevNetBenPACGasNoAdmin]            = ISNULL([SavedCost].[LevNetBenPACGasNoAdmin], 0) 
			,[LevNetBenRIMElec]                  = ISNULL([SavedCost].[LevNetBenRIMElec], 0) 
			,[LevNetBenRIMGas]                   = ISNULL([SavedCost].[LevNetBenRIMGas], 0) 

	FROM	 [dbo].[CEDARS_CET_SavedCE] AS [SavedCE] WITh(NOLOCK) 

			 INNER JOIN [dbo].[CEDARS_CET_SavedCost] AS [SavedCost] WITh(NOLOCK) 
					 ON [SavedCost].[CET_ID] = [SavedCE].[CET_ID] 
						AND [SavedCost].[JobID] = [SavedCE].[JobID] 

			 INNER JOIN [dbo].[CEDARS_CET_SavedEmissions] AS [SavedEmissions] WITh(NOLOCK) 
					 ON [SavedEmissions].[CET_ID] = [SavedCE].[CET_ID] 
						AND [SavedEmissions].[JobID] = [SavedCE].[JobID] 

			 INNER JOIN [dbo].[CEDARS_CET_SavedSavings] AS [SavedSavings] WITh(NOLOCK) 
					 ON [SavedSavings].[CET_ID] = [SavedCE].[CET_ID] 
						AND [SavedSavings].[JobID] = [SavedCE].[JobID] 

	WHERE	 [SavedCE].[JobID] = @CETJobID 
); 
GO
