SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.AlterQueue.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[AlterQueue]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[AlterQueue] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script:		dbo.AlterQueue.sql

Synopsis:	

Notes:		

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
04/04/2016		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[AlterQueue]
(
	@Active BIT = 1,
	@ThreadCount TINYINT = 1
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
	
	------------------------------------------------------------------------------------------------------------------
	--// VARIABLE DECLARATIONS                                                                                    //--
	------------------------------------------------------------------------------------------------------------------
	DECLARE @SQL         AS NVARCHAR(4000);
	DECLARE @ReturnCode  AS INT;
	DECLARE @ErrMessage  AS NVARCHAR(4000);
	DECLARE @ErrNumber   AS INT;
	DECLARE @ErrSeverity AS INT;
	DECLARE @ErrState    AS INT;
	DECLARE @ErrLine     AS INT;
	DECLARE @ErrProc     AS NVARCHAR(200);

	--IF (@ThreadCount NOT BETWEEN 1 AND 10) 
	--BEGIN 
	--	RAISERROR ('ERROR: @ThreadCount is not between 1 and 10.', 16, 1) WITH NOWAIT;
	--	RETURN;  
	--END; 

	IF (@ThreadCount <> 1)
	BEGIN
		RAISERROR ('ERROR: @ThreadCount must be 1.', 16, 1) WITH NOWAIT;
		RETURN;
	END;

	BEGIN TRY

		SET @SQL = N'ALTER QUEUE [CETJobQueue]' + 
		CHAR(13) + N'WITH STATUS = ON, ' + 
		CHAR(13) + N'	RETENTION = OFF, ' + 
		CHAR(13) + N'	ACTIVATION ' + 
		CHAR(13) + N'	( ' + 
		CHAR(13) + N'		STATUS = ' + CASE @Active WHEN 1 THEN N'ON' ELSE N'OFF' END + N', ' + 
		CHAR(13) + N'		PROCEDURE_NAME = [dbo].[JobActivation], ' + 
		CHAR(13) + N'		MAX_QUEUE_READERS = ' + CAST(@ThreadCount AS NVARCHAR) + N', ' + 
		CHAR(13) + N'		EXECUTE AS OWNER ' + 
		CHAR(13) + N'	), ' + 
		CHAR(13) + N'	POISON_MESSAGE_HANDLING (STATUS = ON);';

		EXECUTE	 @ReturnCode = [dbo].[sp_executesql] @SQL;

		IF (@ReturnCode <> 0)
		BEGIN
		    RAISERROR ('ERROR: An error occurred executing an ALTER QUEUE statement on [CETJobQueue].', 16, 1) WITH NOWAIT;
		END;

	END TRY
	BEGIN CATCH

		SET @ErrNumber   = ERROR_NUMBER();
		SET @ErrSeverity = ERROR_SEVERITY();
		SET @ErrState    = ERROR_STATE();
		SET @ErrLine     = ERROR_LINE();
		SET @ErrProc     = ISNULL(ERROR_PROCEDURE(), '-');
		SET @ErrMessage  = [dbo].[GetErrorString](@ErrNumber, @ErrSeverity, @ErrState, @ErrLine, @ErrProc, ERROR_MESSAGE());

		RAISERROR (@ErrMessage, @ErrSeverity, 1);
		
	END CATCH;
END;
GO
