SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.JobActivation.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[JobActivation]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[JobActivation] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.JobActivation.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/ 
ALTER PROCEDURE [dbo].[JobActivation]
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
    DECLARE @ConversationHandle AS UNIQUEIDENTIFIER;
	DECLARE @JobToken           AS UNIQUEIDENTIFIER;
	DECLARE @FilePath           AS NVARCHAR(512);
	DECLARE @MessageTypeName    AS NVARCHAR(128);
	DECLARE @MessageBody        AS VARBINARY(MAX);
	DECLARE @ErrorMessage       AS NVARCHAR(4000);
	DECLARE @ErrorNumber        AS INT;
	DECLARE @ErrorState         AS SMALLINT;
	DECLARE @StartDate          AS DATETIME;
	DECLARE @EndDate            AS DATETIME;
	
    BEGIN TRANSACTION;
    BEGIN TRY;
        RECEIVE  TOP(1)
				 @ConversationHandle = [conversation_handle]
				,@MessageTypeName = [message_type_name]
				,@MessageBody = [message_body]
		FROM	[CETJobQueue];

        IF (@ConversationHandle IS NOT NULL)
        BEGIN
            IF (@MessageTypeName = N'//CETMGMT/SQL/ServiceBroker/CETJobRequest')
            BEGIN
                SET @FilePath = CAST(@MessageBody AS XML).[value]('(//EventInfo/FilePath)[1]', 'NVARCHAR(512)');

				SET @JobToken = (SELECT [conversation_id] FROM [sys].[conversation_endpoints] WHERE [conversation_handle] = @ConversationHandle);

                SAVE TRANSACTION [SavePoint];

				SET @StartDate = CURRENT_TIMESTAMP;

                BEGIN TRY

                    EXECUTE [dbo].[JobExecute] @FilePath=@FilePath, @JobToken=@JobToken;

                END TRY
                BEGIN CATCH
					SET @ErrorNumber = ERROR_NUMBER();
					SET @ErrorMessage = ERROR_MESSAGE();
					SET @ErrorState = XACT_STATE();

					IF (@ErrorState = -1)
					BEGIN
						ROLLBACK TRANSACTION;

						RAISERROR (N'Unrecoverable error in procedure [dbo].[JobExecute]: %i: %s', 16, 10, @ErrorNumber, @ErrorMessage);
					END
					ELSE IF (@ErrorState = 1)
					BEGIN
						ROLLBACK TRANSACTION [SavePoint];
					END;
                END CATCH;

                IF (@JobToken IS NULL)
				BEGIN
					RAISERROR (N'Internal consistency error: conversation not found', 16, 20);
				END;

				SET @EndDate = CURRENT_TIMESTAMP;

                UPDATE	[dbo].[JobActivity]
				SET		[StartDate] = @StartDate, [EndDate] = @EndDate, [ErrorNumber] = @ErrorNumber, [ErrorMessage] = @ErrorMessage
				WHERE	[JobToken] = @JobToken;

                IF (@@ROWCOUNT = 0)
				BEGIN
					RAISERROR (N'Internal consistency error: token not found', 16, 30);
				END;

                END CONVERSATION @ConversationHandle;
            END
            ELSE IF (@MessageTypeName = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
            BEGIN
                END CONVERSATION @ConversationHandle;
			END
			ELSE IF (@MessageTypeName = N'http://schemas.microsoft.com/SQL/ServiceBroker/Error')
			BEGIN
                WITH	XMLNAMESPACES (DEFAULT N'http://schemas.microsoft.com/SQL/ServiceBroker/Error')
                SELECT	@ErrorNumber = CAST(@MessageBody AS XML).[value] ('(/Error/Code)[1]', 'INT'),
						@ErrorMessage = CAST(@MessageBody AS XML).[value] ('(/Error/Description)[1]', 'NVARCHAR(4000)');

                SET @JobToken = (SELECT [conversation_id] FROM [sys].[conversation_endpoints] WHERE [conversation_handle] = @ConversationHandle);

                UPDATE	[dbo].[JobActivity]
				SET		[ErrorNumber] = @ErrorNumber, [ErrorMessage] = @ErrorMessage
				WHERE	[JobToken] = @JobToken;

                END CONVERSATION @ConversationHandle;
			END
			ELSE
			BEGIN
				RAISERROR (N'Received unexpected message type: %s', 16, 50, @MessageTypeName);
			END;
		END;
        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        SET @ErrorNumber = ERROR_NUMBER();
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorState = XACT_STATE();

        IF (@ErrorState <> 0) ROLLBACK TRANSACTION;

        RAISERROR(N'Error: %i, %s', 1, 60,  @ErrorNumber, @ErrorMessage) WITH LOG;

    END CATCH;
END;
GO
