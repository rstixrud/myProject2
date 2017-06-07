SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\dbo.SavedData_ProgramCost.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[SavedData_ProgramCost]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [dbo].[SavedData_ProgramCost];
END;
GO

CREATE FUNCTION [dbo].[SavedData_ProgramCost] (@CEDARSJobID AS NVARCHAR(35), @CETJobID AS INT) 
RETURNS TABLE 
AS 
RETURN 
( 
	SELECT	 [JobID]                          = @CEDARSJobID 
			,[PA]                             = ISNULL([PA], '')
			,[PrgID]                          = ISNULL([PrgID], '')
			,[PrgYear]                        = ISNULL([PrgYear], '')
			,[ClaimYearQuarter]               = ISNULL([ClaimYearQuarter], '')
			,[AdminCostsOverheadAndGA]        = ISNULL([AdminCostsOverheadAndGA], 0) 
			,[AdminCostsOther]                = ISNULL([AdminCostsOther], 0) 
			,[MarketingOutreach]              = ISNULL([MarketingOutreach], 0) 
			,[DIActivity]                     = ISNULL([DIActivity], 0) 
			,[DIInstallation]                 = ISNULL([DIInstallation], 0) 
			,[DIHardwareAndMaterials]         = ISNULL([DIHardwareAndMaterials], 0) 
			,[DIRebateAndInspection]          = ISNULL([DIRebateAndInspection], 0) 
			,[EMV]                            = ISNULL([EMV], 0) 
			,[UserInputIncentive]             = ISNULL([UserInputIncentive], 0) 
			,[CostsRecoveredFromOtherSources] = ISNULL([CostsRecoveredFromOtherSources], 0) 
			,[OnBillFinancing]                = ISNULL([OnBillFinancing], 0)

	FROM	 [dbo].[CEDARS_CET_SavedProgramCostCEDARS] WITh(NOLOCK)

	WHERE	 [JobID] = @CETJobID
);
GO
