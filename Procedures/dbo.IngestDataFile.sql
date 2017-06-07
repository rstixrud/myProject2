SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.IngestDataFile.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[IngestDataFile]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[IngestDataFile] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script:		dbo.IngestDataFile.sql

Synopsis:	

Notes:		

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
06/21/2016		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[IngestDataFile]
(
	@Debug AS BIT = 0,
	@JobID AS NVARCHAR(35),
	@FileName AS NVARCHAR(64)
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Command AS NVARCHAR(4000); -- Currently not used
	DECLARE @SourceFile AS NVARCHAR(512);
	DECLARE @DestinationTable AS NVARCHAR(128);


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Executing: [dbo].[IngestDataFile]...';
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Parameter: @JobID = ', @NVARCHAR=@JobID;
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Parameter: @FileName = ', @NVARCHAR=@FileName;


	SELECT	 @SourceFile = [Path]
			,@DestinationTable = N'[Staging].[' + @FileName + N']'
	FROM	 [FileSystem].[Directory_List]([dbo].[AppDirectory](N'Data') + N'\' + @JobID, N'*.csv')
	WHERE	 [Name] = N'' + @FileName + N'.csv';


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Parameter: @SourceFile = ', @NVARCHAR=@SourceFile;
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Parameter: @DestinationTable = ', @NVARCHAR=@DestinationTable;


	IF (OBJECT_ID(@DestinationTable) IS NOT NULL)
	BEGIN


		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=4, @Text=N'Truncating @DestinationTable...';


		-- Purge local staging table using truncate command
		EXECUTE (N'TRUNCATE TABLE ' + @DestinationTable + N';');


		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=4, @Text=N'Executing BULK INSERT from @SourceFile to @DestinationTable...';


		-- Import data using to local staging table using BULK INSERT command
		EXECUTE ('BULK INSERT ' + @DestinationTable + ' FROM ''' + @SourceFile + ''' WITH (FIRSTROW = 2, FIELDTERMINATOR = ''|'', ROWTERMINATOR = ''0x0a'');');
		
		-- Clean data of any know issues
		EXECUTE [dbo].[ScrubStagging] @TableName = @DestinationTable;

		-- Copy data from the local staging table to the Cedars database
		IF (@FileName = N'Claim') EXECUTE [dbo].[InsertCedarsClaim] @Debug;

		IF (@FileName = N'ContactClaim') EXECUTE [dbo].[InsertCedarsContactClaim] @Debug;

		IF (@FileName = N'CustomMeasure') EXECUTE [dbo].[InsertCedarsCustomMeasure] @Debug;

		IF (@FileName = N'DeemedMeasure') EXECUTE [dbo].[InsertCedarsDeemedMeasure] @Debug;

		IF (@FileName = N'ProgramCost') EXECUTE [dbo].[InsertCedarsProgramCost] @Debug;

		IF (@FileName = N'Site') EXECUTE [dbo].[InsertCedarsSite] @Debug;
	END;


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Completed!';


END;
GO
