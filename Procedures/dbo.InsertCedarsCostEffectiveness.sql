SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCedarsCostEffectiveness.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCedarsCostEffectiveness]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCedarsCostEffectiveness] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.InsertCedarsCostEffectiveness.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCedarsCostEffectiveness]
(
	@Debug AS BIT = 0,
	@JobID AS NVARCHAR(35)
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

	DECLARE @CETJobID AS INT;
	DECLARE @CEDARSJobID AS NVARCHAR(35);

	
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Executing: [dbo].[InsertCedarsCostEffectiveness]...';


	SET @CETJobID = (SELECT MAX([JobID]) FROM [dbo].[CET_SavedInput]);
	SET @CEDARSJobID = SUBSTRING(@JobID, 1, CHARINDEX(N'_', @JobID) - 1);

	INSERT INTO [dbo].[CEDARS_CostEffectiveness]
	(
			 [JobID]
			,[PA]
			,[PrgID]
			,[CET_ID]
			,[GrossKWh]
			,[GrossKW]
			,[GrossThm]
			,[NetKWh]
			,[NetKW]
			,[NetThm]
			,[LifecycleGrossKWh]
			,[LifecycleGrossThm]
			,[LifecycleNetKWh]
			,[LifecycleNetThm]
			,[GoalAttainmentKWh]
			,[GoalAttainmentKW]
			,[GoalAttainmentThm]
			,[FirstYearGrossKWh]
			,[FirstYearGrossKW]
			,[FirstYearGrossThm]
			,[FirstYearNetKWh]
			,[FirstYearNetKW]
			,[FirstYearNetThm]
			,[WeightedSavings]
			,[ElecBen]
			,[GasBen]
			,[ElecBenGross]
			,[GasBenGross]
			,[TRCCost]
			,[PACCost]
			,[TRCCostGross]
			,[TRCCostNoAdmin]
			,[PACCostNoAdmin]
			,[TRCRatio]
			,[PACRatio]
			,[TRCRatioNoAdmin]
			,[PACRatioNoAdmin]
			,[BillReducElec]
			,[BillReducGas]
			,[RIMCost]
			,[WeightedBenefits]
			,[WeightedElecAlloc]
			,[WeightedProgramCost]
			,[NetElecCO2]
			,[NetGasCO2]
			,[GrossElecCO2]
			,[GrossGasCO2]
			,[NetElecCO2Lifecycle]
			,[NetGasCO2Lifecycle]
			,[GrossElecCO2Lifecycle]
			,[GrossGasCO2Lifecycle]
			,[NetElecNOx]
			,[NetGasNOx]
			,[GrossElecNOx]
			,[GrossGasNOx]
			,[NetElecNOxLifecycle]
			,[NetGasNOxLifecycle]
			,[GrossElecNOxLifecycle]
			,[GrossGasNOxLifecycle]
			,[NetPM10]
			,[GrossPM10]
			,[NetPM10Lifecycle]
			,[GrossPM10Lifecycle]
			,[IncentiveToOthers]
			,[DILaborCost]
			,[DIMaterialCost]
			,[EndUserRebate]
			,[RebatesandIncents]
			,[GrossMeasureCost]
			,[ExcessIncentives]
			,[MarkEffectPlusExcessInc]
			,[GrossParticipantCost]
			,[GrossParticipantCostAdjusted]
			,[NetParticipantCost]
			,[NetParticipantCostAdjusted]
			,[RebatesandIncentsPV]
			,[GrossMeasCostPV]
			,[ExcessIncentivesPV]
			,[MarkEffectPlusExcessIncPV]
			,[GrossParticipantCostPV]
			,[GrossParticipantCostAdjustedPV]
			,[NetParticipantCostPV]
			,[NetParticipantCostAdjustedPV]
			,[WtdAdminCostsOverheadAndGA]
			,[WtdAdminCostsOther]
			,[WtdMarketingOutreach]
			,[WtdDIActivity]
			,[WtdDIInstallation]
			,[WtdDIHardwareAndMaterials]
			,[WtdDIRebateAndInspection]
			,[WtdEMV]
			,[WtdUserInputIncentive]
			,[WtdCostsRecoveredFromOtherSources]
			,[ProgramCosts]
			,[TotalExpenditures]
			,[DiscountedSavingsGrosskWh]
			,[DiscountedSavingsNetkWh]
			,[DiscountedSavingsGrossThm]
			,[DiscountedSavingsNetThm]
			,[TRCLifecycleNetBen]
			,[PACLifecycleNetBen]
			,[LevBenElec]
			,[LevBenGas]
			,[LevTRCCost]
			,[LevTRCCostNoAdmin]
			,[LevPACCost]
			,[LevPACCostNoAdmin]
			,[LevRIMCost]
			,[LevNetBenTRCElec]
			,[LevNetBenTRCElecNoAdmin]
			,[LevNetBenPACElec]
			,[LevNetBenPACElecNoAdmin]
			,[LevNetBenTRCGas]
			,[LevNetBenTRCGasNoAdmin]
			,[LevNetBenPACGas]
			,[LevNetBenPACGasNoAdmin]
			,[LevNetBenRIMElec]
			,[LevNetBenRIMGas]
	) 
	SELECT	 [JobID]
			,[PA]
			,[PrgID]
			,[CET_ID]
			,[GrossKWh]
			,[GrossKW]
			,[GrossThm]
			,[NetKWh]
			,[NetKW]
			,[NetThm]
			,[LifecycleGrossKWh]
			,[LifecycleGrossThm]
			,[LifecycleNetKWh]
			,[LifecycleNetThm]
			,[GoalAttainmentKWh]
			,[GoalAttainmentKW]
			,[GoalAttainmentThm]
			,[FirstYearGrossKWh]
			,[FirstYearGrossKW]
			,[FirstYearGrossThm]
			,[FirstYearNetKWh]
			,[FirstYearNetKW]
			,[FirstYearNetThm]
			,[WeightedSavings]
			,[ElecBen]
			,[GasBen]
			,[ElecBenGross]
			,[GasBenGross]
			,[TRCCost]
			,[PACCost]
			,[TRCCostGross]
			,[TRCCostNoAdmin]
			,[PACCostNoAdmin]
			,[TRCRatio]
			,[PACRatio]
			,[TRCRatioNoAdmin]
			,[PACRatioNoAdmin]
			,[BillReducElec]
			,[BillReducGas]
			,[RIMCost]
			,[WeightedBenefits]
			,[WeightedElecAlloc]
			,[WeightedProgramCost]
			,[NetElecCO2]
			,[NetGasCO2]
			,[GrossElecCO2]
			,[GrossGasCO2]
			,[NetElecCO2Lifecycle]
			,[NetGasCO2Lifecycle]
			,[GrossElecCO2Lifecycle]
			,[GrossGasCO2Lifecycle]
			,[NetElecNOx]
			,[NetGasNOx]
			,[GrossElecNOx]
			,[GrossGasNOx]
			,[NetElecNOxLifecycle]
			,[NetGasNOxLifecycle]
			,[GrossElecNOxLifecycle]
			,[GrossGasNOxLifecycle]
			,[NetPM10]
			,[GrossPM10]
			,[NetPM10Lifecycle]
			,[GrossPM10Lifecycle]
			,[IncentiveToOthers]
			,[DILaborCost]
			,[DIMaterialCost]
			,[EndUserRebate]
			,[RebatesandIncents]
			,[GrossMeasureCost]
			,[ExcessIncentives]
			,[MarkEffectPlusExcessInc]
			,[GrossParticipantCost]
			,[GrossParticipantCostAdjusted]
			,[NetParticipantCost]
			,[NetParticipantCostAdjusted]
			,[RebatesandIncentsPV]
			,[GrossMeasCostPV]
			,[ExcessIncentivesPV]
			,[MarkEffectPlusExcessIncPV]
			,[GrossParticipantCostPV]
			,[GrossParticipantCostAdjustedPV]
			,[NetParticipantCostPV]
			,[NetParticipantCostAdjustedPV]
			,[WtdAdminCostsOverheadAndGA]
			,[WtdAdminCostsOther]
			,[WtdMarketingOutreach]
			,[WtdDIActivity]
			,[WtdDIInstallation]
			,[WtdDIHardwareAndMaterials]
			,[WtdDIRebateAndInspection]
			,[WtdEMV]
			,[WtdUserInputIncentive]
			,[WtdCostsRecoveredFromOtherSources]
			,[ProgramCosts]
			,[TotalExpenditures]
			,[DiscountedSavingsGrosskWh]
			,[DiscountedSavingsNetkWh]
			,[DiscountedSavingsGrossThm]
			,[DiscountedSavingsNetThm]
			,[TRCLifecycleNetBen]
			,[PACLifecycleNetBen]
			,[LevBenElec]
			,[LevBenGas]
			,[LevTRCCost]
			,[LevTRCCostNoAdmin]
			,[LevPACCost]
			,[LevPACCostNoAdmin]
			,[LevRIMCost]
			,[LevNetBenTRCElec]
			,[LevNetBenTRCElecNoAdmin]
			,[LevNetBenPACElec]
			,[LevNetBenPACElecNoAdmin]
			,[LevNetBenTRCGas]
			,[LevNetBenTRCGasNoAdmin]
			,[LevNetBenPACGas]
			,[LevNetBenPACGasNoAdmin]
			,[LevNetBenRIMElec]
			,[LevNetBenRIMGas]
	FROM	 [dbo].[SavedData_Outputs](@CEDARSJobID, @CETJobID);


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Completed!';


END;
GO
