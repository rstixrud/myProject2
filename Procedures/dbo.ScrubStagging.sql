SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.ScrubStagging.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[ScrubStagging]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[ScrubStagging] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script:		dbo.ScrubStagging.sql

Synopsis:	

Notes:		

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
04/04/2016		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[ScrubStagging]
(
	@Debug AS BIT = 0,
	@TableName AS NVARCHAR(64)
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

	---------------------------------------------------------------------------------------------------
	--// DECLARATIONS                                                                              //--
	---------------------------------------------------------------------------------------------------
	DECLARE @SqlString AS NVARCHAR(MAX);

	---------------------------------------------------------------------------------------------------
	--// CODE STARTS HERE                                                                          //--
	---------------------------------------------------------------------------------------------------
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Executing: [dbo].[ScrubStagedData]...';

	IF (OBJECT_ID(@TableName) IS NOT NULL)
	BEGIN
		IF ((SELECT CURSOR_STATUS('global', 'SqlCursor')) >= -1)
		BEGIN
			IF ((SELECT CURSOR_STATUS('global', 'SqlCursor')) > -1)
			BEGIN
				CLOSE [SqlCursor];
			END;
			DEALLOCATE [SqlCursor];
		END;

		DECLARE [SqlCursor] CURSOR FAST_FORWARD FOR
		SELECT	[SqlString] = N'UPDATE ' + @TableName + N' SET [' + [column].[name] + N'] = REPLACE([' + [column].[name] + N'], CHAR(13), N'''');'
		FROM	[sys].[columns] AS [column]
				INNER JOIN [sys].[tables] AS [table]
						ON [table].[object_id] = [column].[object_id]
		WHERE	[table].[object_id] = OBJECT_ID(@TableName);

		OPEN [SqlCursor];
		FETCH NEXT FROM [SqlCursor] INTO @SqlString;

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			EXECUTE [sys].[sp_executesql] @SqlString;

			FETCH NEXT FROM [SqlCursor] INTO @SqlString;
		END;
		CLOSE [SqlCursor];
		DEALLOCATE [SqlCursor];
	END;

	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Completed!';

END;
GO
