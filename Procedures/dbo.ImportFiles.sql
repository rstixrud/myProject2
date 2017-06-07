SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.ImportFiles.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[ImportFiles]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[ImportFiles] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script:		dbo.ImportFiles.sql

Synopsis:	

Notes:		

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
06/21/2016		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[ImportFiles]
(
	@Debug AS BIT = 0,
	@JobID AS NVARCHAR(35),
	@FolderName AS NVARCHAR(64)
)
AS
BEGIN
	---------------------------------------------------------------------------------------------------
	--// SET STATEMENTS                                                                            //--
	---------------------------------------------------------------------------------------------------
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


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Executing: [dbo].[ImportFiles]...';
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Parameter: @JobID = ', @NVARCHAR=@JobID;
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Parameter: @FolderName = ', @NVARCHAR=@FolderName;


	-- START: CLAIMS ONLY IMPORT

	IF (@JobID LIKE '%claims%')
	BEGIN
		EXECUTE [dbo].[IngestDataFile] @Debug = @Debug, @JobID = @JobID, @FileName = N'Claim';

		EXECUTE [dbo].[IngestDataFile] @Debug = @Debug, @JobID = @JobID, @FileName = N'ContactClaim';

		EXECUTE [dbo].[IngestDataFile] @Debug = @Debug, @JobID = @JobID, @FileName = N'CustomMeasure';

		EXECUTE [dbo].[IngestDataFile] @Debug = @Debug, @JobID = @JobID, @FileName = N'DeemedMeasure';

		EXECUTE [dbo].[IngestDataFile] @Debug = @Debug, @JobID = @JobID, @FileName = N'ProgramCost';

		EXECUTE [dbo].[IngestDataFile] @Debug = @Debug, @JobID = @JobID, @FileName = N'Site';
	END;

	-- END: CLAIMS ONLY IMPORT

	EXECUTE [dbo].[InsertCETInputMeasure] @Debug;

	EXECUTE [dbo].[InsertCETInputProgram] @Debug;


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Completed!';


END;
GO
