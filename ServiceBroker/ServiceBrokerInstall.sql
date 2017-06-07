RAISERROR ('*** Executing SQL: "...\ServiceBroker\ServiceBrokerInstall.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[services] WHERE [name] = N'//CETMGMT/SQL/ServiceBroker/CETJobService')
BEGIN
	DROP SERVICE [//CETMGMT/SQL/ServiceBroker/CETJobService];
END;
GO

IF EXISTS (SELECT * FROM [sys].[service_queues] WHERE [name] = N'CETJobQueue')
BEGIN
	DROP QUEUE [dbo].[CETJobQueue];
END;
GO

IF EXISTS (SELECT * FROM [sys].[service_contracts] WHERE [name] = N'//CETMGMT/SQL/ServiceBroker/CETJobContract')
BEGIN
	DROP CONTRACT [//CETMGMT/SQL/ServiceBroker/CETJobContract];
END;
GO

IF EXISTS (SELECT * FROM [sys].[service_message_types] WHERE [name] = N'//CETMGMT/SQL/ServiceBroker/CETJobRequest')
BEGIN
	DROP MESSAGE TYPE [//CETMGMT/SQL/ServiceBroker/CETJobRequest];
END;
GO

IF NOT EXISTS (SELECT * FROM [sys].[service_message_types] WHERE [name] = '//CETMGMT/SQL/ServiceBroker/CETJobRequest')
BEGIN
	CREATE MESSAGE TYPE [//CETMGMT/SQL/ServiceBroker/CETJobRequest] AUTHORIZATION [dbo] VALIDATION = WELL_FORMED_XML;
END;
GO

IF NOT EXISTS (SELECT * FROM [sys].[service_contracts] WHERE [name] = '//CETMGMT/SQL/ServiceBroker/CETJobContract')
BEGIN
	CREATE CONTRACT [//CETMGMT/SQL/ServiceBroker/CETJobContract] AUTHORIZATION [dbo] ([//CETMGMT/SQL/ServiceBroker/CETJobRequest] SENT BY INITIATOR);
END;
GO

IF NOT EXISTS (SELECT * FROM [sys].[service_queues] WHERE [name] = 'CETJobQueue' AND [type] = N'SQ')
BEGIN
	CREATE QUEUE [CETJobQueue];
END;
GO

IF NOT EXISTS (SELECT * FROM [sys].[services] WHERE [name] = '//CETMGMT/SQL/ServiceBroker/CETJobService')
BEGIN
	CREATE SERVICE [//CETMGMT/SQL/ServiceBroker/CETJobService] ON QUEUE [CETJobQueue] ([//CETMGMT/SQL/ServiceBroker/CETJobContract]);
END;
GO

IF EXISTS (SELECT * FROM [sys].[service_queues] WHERE [name] = 'CETJobQueue' AND [type] = N'SQ')
BEGIN
	IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[JobActivation]') AND [type] IN (N'P', N'PC'))
	BEGIN
		EXECUTE ('CREATE PROCEDURE [dbo].[JobActivation] AS RAISERROR(''UNDEFINED!'', 16, 1);');
	END;

	ALTER QUEUE [CETJobQueue] WITH ACTIVATION (PROCEDURE_NAME = [dbo].[JobActivation], MAX_QUEUE_READERS = 1, EXECUTE AS OWNER, STATUS = ON);
END;
GO
