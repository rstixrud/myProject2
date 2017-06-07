RAISERROR ('*** Executing SQL: "...\Views\dbo.Claim_CET_ProgramCostView.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[views] WHERE [object_id] = OBJECT_ID(N'[dbo].[Claim_CET_ProgramCostView]'))
BEGIN
	DROP VIEW [dbo].[Claim_CET_ProgramCostView];
END;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE VIEW [dbo].[Claim_CET_ProgramCostView] 
AS
	SELECT	 [JobID] = -1
			,[PA]
			,[PrgID]
			,[PrgYear]
			,[ClaimYearQuarter]
			,[AdminCostsOverheadAndGA]
			,[AdminCostsOther]
			,[MarketingOutreach]
			,[DIActivity]
			,[DIInstallation]
			,[DIHardwareAndMaterials]
			,[DIRebateAndInspection]
			,[EMV]
			,[UserInputIncentive]
			,[CostsRecoveredFromOtherSources]
			,[OnBillFinancing]
	FROM	 [dbo].[CEDARS_ProgramCost] WITh(NOLOCK);
GO
