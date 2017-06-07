SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.JobInvoke.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[JobInvoke]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[JobInvoke] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.JobInvoke.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/ 
ALTER PROCEDURE [dbo].[JobInvoke]
(
	@Debug AS BIT = 0, 
	@Path AS NVARCHAR(512)
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
	DECLARE @conversation_handle AS UNIQUEIDENTIFIER
	DECLARE @TranCount           AS INT;
	DECLARE @JobToken            AS UNIQUEIDENTIFIER;
	DECLARE @ServiceBrokerGuid   AS NVARCHAR(128);
	DECLARE @MessageBody         AS XML; 

	SELECT	@ServiceBrokerGuid = [service_broker_guid] 
	FROM	[sys].[databases] 
	WHERE	[database_id] = DB_ID();

	SET @TranCount = @@TRANCOUNT;

	IF (@TranCount = 0)
		BEGIN TRANSACTION
	ELSE
		SAVE TRANSACTION [SavePoint]; 

	BEGIN TRY

		BEGIN DIALOG CONVERSATION @conversation_handle
			FROM SERVICE [//CETMGMT/SQL/ServiceBroker/CETJobService]
			TO SERVICE  N'//CETMGMT/SQL/ServiceBroker/CETJobService', @ServiceBrokerGuid
			ON CONTRACT  [//CETMGMT/SQL/ServiceBroker/CETJobContract]
			WITH ENCRYPTION = OFF;

		SELECT	@JobToken = [conversation_id]
		FROM	[sys].[conversation_endpoints]
		WHERE	[conversation_handle] = @conversation_handle;

		SET @MessageBody = (SELECT @Path AS [Path] FOR XML PATH('EventInfo'), TYPE);

		SEND ON CONVERSATION @conversation_handle MESSAGE TYPE [//CETMGMT/SQL/ServiceBroker/CETJobRequest] (@MessageBody);
		
		INSERT INTO [dbo].[JobActivity] ([JobToken], [Path]) VALUES (@JobToken, @Path);

		IF (@TranCount = 0) 
			COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH

		DECLARE @ErrorNumber AS INT;
		DECLARE @ErrorMessage AS NVARCHAR(2048);
		DECLARE @XactState AS SMALLINT;

		SET @ErrorNumber = ERROR_NUMBER();
		SET @ErrorMessage = ERROR_MESSAGE();
		SET @XactState = XACT_STATE();

		IF (@XactState = -1)
			ROLLBACK TRANSACTION;

		IF (@XactState = 1 AND @TranCount = 0)
			ROLLBACK TRANSACTION;

		IF (@XactState = 1 AND @TranCount > 0)
			ROLLBACK TRANSACTION [SavePoint];

		RAISERROR(N'Error: %i, %s', 16, 1, @ErrorNumber, @ErrorMessage);

		RETURN 0;

	END CATCH;

	RETURN 1;
END; 
GO
