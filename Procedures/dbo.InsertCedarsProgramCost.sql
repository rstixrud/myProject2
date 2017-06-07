SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCedarsProgramCost.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCedarsProgramCost]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCedarsProgramCost] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script: dbo.InsertCedarsProgramCost.sql

Synopsis:

Notes:

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
04/04/2016		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCedarsProgramCost]
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


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Executing: [dbo].[InsertCedarsProgramCost]...';


	INSERT INTO [dbo].[CEDARS_ProgramCost]
	(
			 [PrgID]
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
			,[PA]
	)
	SELECT	 [PrgID]                          = CAST([PrgID] AS NVARCHAR(255))
			,[PrgYear]                        = CAST([PrgYear] AS NVARCHAR(4))
			,[ClaimYearQuarter]               = CAST([ClaimYearQuarter] AS NVARCHAR(255))
			,[AdminCostsOverheadAndGA]        = CAST([AdminCostsOverheadAndGA] AS FLOAT)
			,[AdminCostsOther]                = CAST([AdminCostsOther] AS FLOAT)
			,[MarketingOutreach]              = CAST([MarketingOutreach] AS FLOAT)
			,[DIActivity]                     = CAST([DIActivity] AS FLOAT)
			,[DIInstallation]                 = CAST([DIInstallation] AS FLOAT)
			,[DIHardwareAndMaterials]         = CAST([DIHardwareAndMaterials] AS FLOAT)
			,[DIRebateAndInspection]          = CAST([DIRebateAndInspection] AS FLOAT)
			,[EMV]                            = CAST([EMV] AS FLOAT)
			,[UserInputIncentive]             = CAST([UserInputIncentive] AS FLOAT)
			,[CostsRecoveredFromOtherSources] = CAST([CostsRecoveredFromOtherSources] AS FLOAT)
			,[OnBillFinancing]                = CAST([OnBillFinancing] AS FLOAT)
			,[PA]                             = CAST([PA] AS NVARCHAR(255))
	FROM	 [Staging].[ProgramCost];


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Completed!';


END;
GO
