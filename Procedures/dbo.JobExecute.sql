SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.JobExecute.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[JobExecute]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[JobExecute] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.JobExecute.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/ 
ALTER PROCEDURE [dbo].[JobExecute]
(
	@Debug AS BIT = 0, 
	@FilePath AS NVARCHAR(512), 
	@JobToken AS UNIQUEIDENTIFIER = NULL
)
WITH EXECUTE AS OWNER
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
	DECLARE @Message AS NVARCHAR(MAX);

	SET @Message = @FilePath;

	BEGIN TRY

		EXECUTE [dbo].[CEDARS_CET_RunCET] @Message;

		--EXECUTE [dbo].[SendAlert];

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

		RAISERROR ('*** ERROR *** Check [ErrorMessage] in the [JobActivity] table', 0, 1, @FilePath) WITH NOWAIT;
		 
		RAISERROR (@ErrorMessage, @ErrorSeverity, 1);

	END CATCH;
END;
GO

ADD SIGNATURE TO [dbo].[JobExecute] BY CERTIFICATE [ServiceBrokerCertificate] WITH PASSWORD = N'E!3m@AR$$r?#Se^vjaeu#/k)]"WL-bYD!4fnS(y!8,=xUbm+W;';
GO
