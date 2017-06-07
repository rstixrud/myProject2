RAISERROR ('*** Executing SQL: "...\ServiceBroker\ServiceBrokerSecurity.sql"', 0, 1) WITH NOWAIT;
GO

DECLARE @ServiceBrokerCertificate AS NVARCHAR(25);
DECLARE @ServiceBrokerDirectory AS NVARCHAR(512);
DECLARE @ServiceBrokerPassword AS NVARCHAR(128);
DECLARE @ServiceBrokerToFile AS NVARCHAR(512);
DECLARE	@ServiceBrokerLogin AS NVARCHAR(128);
DECLARE @ServiceBrokerUser AS NVARCHAR(128);

SET @ServiceBrokerCertificate = N'ServiceBrokerCertificate';
SET @ServiceBrokerDirectory = N'C:\WorkDev\github\SoundDataMgmt\CET\SQL-CETMGMT\Security\';
SET @ServiceBrokerPassword = N'E!3m@AR$$r?#Se^vjaeu#/k)]"WL-bYD!4fnS(y!8,=xUbm+W;';
SET @ServiceBrokerLogin = N'ServiceBrokerLogin';
SET @ServiceBrokerUser = N'ServiceBrokerUser';

DECLARE @ReturnCode AS INT;

IF NOT EXISTS(SELECT * FROM [master].[sys].[certificates] WHERE [name] = @ServiceBrokerCertificate)
BEGIN
	EXECUTE(N'USE [master];
			CREATE CERTIFICATE [' + @ServiceBrokerCertificate + N']
				ENCRYPTION BY PASSWORD = N''' + @ServiceBrokerPassword + N'''
				WITH SUBJECT = N''Service Broker Permissions'',
				START_DATE = N''20160101'', EXPIRY_DATE = N''21160101'';');
END;

IF NOT EXISTS(SELECT * FROM [sys].[server_principals] WHERE [name] = @ServiceBrokerLogin)
BEGIN
	EXECUTE(N'USE [master]; CREATE LOGIN [' + @ServiceBrokerLogin + N'] FROM CERTIFICATE [' + @ServiceBrokerCertificate + N'];');
END;

IF EXISTS(SELECT * FROM [sys].[server_principals] WHERE [name] = @ServiceBrokerLogin)
BEGIN
	EXECUTE(N'USE [master]; GRANT AUTHENTICATE SERVER TO [' + @ServiceBrokerLogin + N'];');
END;

--IF NOT EXISTS(SELECT * FROM [msdb].[sys].[database_principals] WHERE [name] = @ServiceBrokerUser)
--BEGIN
--	EXECUTE(N'USE [msdb]; CREATE USER [' + @ServiceBrokerUser + N'] FOR LOGIN [' + @ServiceBrokerLogin + N'];');
--END;

--IF EXISTS(SELECT * FROM [msdb].[sys].[database_principals] WHERE [name] = @ServiceBrokerUser)
--BEGIN
--	EXECUTE(N'USE [msdb]; ALTER ROLE [DatabaseMailUserRole] ADD MEMBER [' + @ServiceBrokerUser + N'];');
--END;

IF EXISTS(SELECT * FROM [master].[sys].[certificates] WHERE [name] = @ServiceBrokerCertificate)
BEGIN
	SET @ServiceBrokerToFile = @ServiceBrokerDirectory + @ServiceBrokerCertificate + N'.cer';

	EXECUTE [master].[dbo].[xp_fileexist] @ServiceBrokerToFile, @ReturnCode OUTPUT;

	IF (@ReturnCode <> 1)
	BEGIN
		EXECUTE(N'USE [master];
				BACKUP CERTIFICATE [' + @ServiceBrokerCertificate + N'] TO FILE = N''' + @ServiceBrokerDirectory + @ServiceBrokerCertificate + N'.cer''
					WITH PRIVATE KEY
					(
						FILE = N''' + @ServiceBrokerDirectory + @ServiceBrokerCertificate + N'.pvk'',
						ENCRYPTION BY PASSWORD = N''' + @ServiceBrokerPassword + N''',
						DECRYPTION BY PASSWORD = N''' + @ServiceBrokerPassword + N'''
					);');
	END;
END;

IF NOT EXISTS(SELECT * FROM [sys].[certificates] WHERE [name] = @ServiceBrokerCertificate)
BEGIN
	EXECUTE(N'CREATE CERTIFICATE [' + @ServiceBrokerCertificate + N']
				FROM FILE = N''' + @ServiceBrokerDirectory + @ServiceBrokerCertificate + N'.cer''
				WITH PRIVATE KEY
				(
					FILE = N''' + @ServiceBrokerDirectory + @ServiceBrokerCertificate + N'.pvk'',
					DECRYPTION BY PASSWORD = N''' + @ServiceBrokerPassword + N''',
					ENCRYPTION BY PASSWORD = N''' + @ServiceBrokerPassword + N'''
				);');
END;

IF NOT EXISTS(SELECT * FROM [sys].[database_principals] WHERE [name] = @ServiceBrokerUser)
BEGIN
	EXECUTE(N'CREATE USER [' + @ServiceBrokerUser + N'] FOR CERTIFICATE [' + @ServiceBrokerCertificate + N'];');
END;
GO
