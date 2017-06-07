SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.SendAlert.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[SendAlert]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[SendAlert] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.SendAlert.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/ 
ALTER PROCEDURE [dbo].[SendAlert]
(
	@Debug AS BIT = 0
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

	EXECUTE  [msdb].[dbo].[sp_send_dbmail]
			 @profile_name = N'SQLAlerts'
			,@recipients   = N'bob@sqlprofessionals.com'
			,@subject      = N'Hello3 from Service Broker'
			,@body         = N'This is a test e-mail sent from Service Broker';
END;
GO

ADD SIGNATURE TO [dbo].[SendAlert] BY CERTIFICATE [ServiceBrokerCertificate] WITH PASSWORD = N'E!3m@AR$$r?#Se^vjaeu#/k)]"WL-bYD!4fnS(y!8,=xUbm+W;';
GO
