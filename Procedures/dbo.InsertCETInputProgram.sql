SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCETInputProgram.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCETInputProgram]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCETInputProgram] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.InsertCETInputProgram.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCETInputProgram]
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


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Executing: [dbo].[InsertCETInputProgram]...';


	DECLARE @PA AS NVARCHAR(10);
	
	SET @PA = (SELECT TOP(1) [PA] FROM [Staging].[ProgramCost]);

	DELETE FROM [dbo].[CET_InputProgramCEDARS];

	INSERT INTO [dbo].[CET_InputProgramCEDARS]
	(
			 [JobID]
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
			,[OnBillFinancing]
			,[CostsRecoveredFromOtherSources]
	)
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
			,[OnBillFinancing]
			,[CostsRecoveredFromOtherSources]
	FROM	 [dbo].[CETMGMT_InputProgramView] WITh(NOLOCK)
	WHERE	 [PA] = @PA;


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Completed!';

END;
GO
