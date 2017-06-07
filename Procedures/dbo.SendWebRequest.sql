SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.SendWebRequest.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[SendWebRequest]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[SendWebRequest] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script:		dbo.SendWebRequest.sql

Synopsis:	The purpose of this procedure is to automate the creation of synonyms so that the names of the
			the synonyms and method used to map the objects to the proper Cedars databases are standardized.

Notes:		This makes use of the [config].[GetCedarsDatabase]() function which matches the calling CETMGMT
			database to the correct Cedars database depending on if the name contains CEDARS or CEDARS_CET.

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
03/24/2017		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[SendWebRequest]
(
	@Debug AS BIT = 0,
	@JobID AS NVARCHAR(35),
	@Status AS NVARCHAR(35),
	@Data AS NVARCHAR(2000) = NULL
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

	---------------------------------------------------------------------------------------------------
	--// DECLARATIONS                                                                              //--
	---------------------------------------------------------------------------------------------------
	DECLARE @URI AS NVARCHAR(128);
	DECLARE @Json AS NVARCHAR(4000);
	DECLARE @Response AS NVARCHAR(4000);
	DECLARE @ReturnCode AS INT;

	---------------------------------------------------------------------------------------------------
	--// CODE STARTS HERE                                                                          //--
	---------------------------------------------------------------------------------------------------
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Executing: [dbo].[SendWebRequest]...';
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Parameter: @JobID = ', @NVARCHAR=@JobID;
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Parameter: @Status = ', @NVARCHAR=@Status;
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Parameter: @Data = ', @NVARCHAR=@Data;

	SET @URI = [config].[GetCedarsUriString](@JobID);
	
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Parameter: @URI = ', @NVARCHAR=@URI;

	SET @Json = [dbo].[GetJsonString](@JobID, @Status, @Data);
		
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Parameter: @Json = ', @NVARCHAR=@Json;

	IF (@URI IS NOT NULL)
	BEGIN TRY

		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Executing: [SQL#].[WebRequest]...';

		EXECUTE @ReturnCode = [SQL#].[WebRequest] @URI, @Json, @Response OUTPUT;

		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Parameter: @Response = ', @NVARCHAR=@Response;
		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=2, @Text=N'Completed!';

	END TRY
	BEGIN CATCH

		DECLARE @ErrorNumber    AS INT;
		DECLARE @ErrorSeverity  AS INT;
		DECLARE @ErrorState     AS INT;
		DECLARE @ErrorLine      AS INT;
		DECLARE @ErrorProcedure AS NVARCHAR(200);
		DECLARE @ErrorMessage   AS NVARCHAR(4000);

		SET @ErrorNumber    = ERROR_NUMBER();
		SET @ErrorSeverity  = ERROR_SEVERITY();
		SET @ErrorState     = ERROR_STATE();
		SET @ErrorLine      = ERROR_LINE();
		SET @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');
		SET @ErrorMessage   = [dbo].[GetErrorString](@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorLine, @ErrorProcedure, ERROR_MESSAGE());

		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;

		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Parameter: @Response = ', @NVARCHAR=@Response;
		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Parameter: @ErrorMessage = ', @NVARCHAR=@ErrorMessage;

		RAISERROR (@ErrorMessage, @ErrorSeverity, 1);

	END CATCH;

	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Completed!';

END;
GO
