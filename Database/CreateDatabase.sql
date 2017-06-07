/*==========================================================================================================================
Script: CreateDatabase.sql

Synopsis:

Notes:

============================================================================================================================
Revision History:

Date			Author							Description
----------------------------------------------------------------------------------------------------------------------------
06/06/2017		SQL Professionals (Bob)			Script Created

============================================================================================================================*/

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
	GO

	---------------------------------------------------------------------------------------------------
	--// DECLARATIONS                                                                              //--
	---------------------------------------------------------------------------------------------------
	DECLARE	@DatabaseName    AS NVARCHAR( 128);
	DECLARE	@DBOwnerName     AS NVARCHAR( 128);
	DECLARE	@DefaultDataPath AS NVARCHAR( 512);
	DECLARE	@DefaultLogPath  AS NVARCHAR( 512);
	DECLARE	@SQL             AS NVARCHAR(4000);
	DECLARE @Parmeters       AS nvarchar( 500);
	DECLARE @IsDefault       AS BIT           ;
	DECLARE @MessagePrefix   AS NVARCHAR(  15);

	---------------------------------------------------------------------------------------------------
	--// CONFIGURATION                                                                              //--
	---------------------------------------------------------------------------------------------------
	SET @DatabaseName  = N'<database_name>';
	SET @DBOwnerName   = N'dbowner';

	---------------------------------------------------------------------------------------------------
	--// DECLARATIONS                                                                              //--
	---------------------------------------------------------------------------------------------------
	IF NOT EXISTS(SELECT * FROM [sys].[databases] WHERE [name] = @DatabaseName)
	BEGIN
		IF EXISTS(SELECT * FROM [sys].[databases] WHERE [name] = 'TempDBForDefaultPath')
		BEGIN
			ALTER DATABASE [TempDBForDefaultPath] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
			DROP DATABASE  [TempDBForDefaultPath];
		END;

		CREATE DATABASE [TempDBForDefaultPath];

		SET @DefaultDataPath =
		(
			SELECT	 LEFT([File].[physical_name], LEN([File].[physical_name]) - CHARINDEX('\', REVERSE([File].[physical_name])) + 1)
			FROM	 [sys].[master_files] AS [File]
					 INNER JOIN [sys].[databases] AS [Database]
							 ON [File].[database_id] = [Database].[database_id]
			WHERE	 [Database].[name] = 'TempDBForDefaultPath'
					 AND [File].[type] = 0
		);

		SET @DefaultLogPath =
		(
			SELECT	 LEFT([File].[physical_name], LEN([File].[physical_name]) - CHARINDEX('\', REVERSE([File].[physical_name])) + 1)
			FROM	 [sys].[master_files] AS [File]
					 INNER JOIN [sys].[databases] [Database]
							 ON [File].[database_id] = [Database].[database_id]
			WHERE	 [Database].[name] = 'TempDBForDefaultPath'
					 AND [File].[type] = 1
		);

		SET @SQL = N'CREATE DATABASE [' + @DatabaseName + N']' + CHAR(13) +
		CHAR(10) + N'ON PRIMARY' + CHAR(13) +
		CHAR(10) + N'(' + CHAR(13) +
		CHAR(10) + N'	 NAME = N''' + @DatabaseName + N'''' + CHAR(13) +
		CHAR(10) + N'	,FILENAME = N''' + @DefaultDataPath  + @DatabaseName + N'.mdf''' + CHAR(13) +
		CHAR(10) + N'	,SIZE = 8MB' + CHAR(13) +
		CHAR(10) + N'	,FILEGROWTH = 8MB' + CHAR(13) +
		CHAR(10) + N'	,MAXSIZE = UNLIMITED' + CHAR(13) +
		CHAR(10) + N'),' + CHAR(13) +
		CHAR(10) + N'FILEGROUP [DATA]' + CHAR(13) +
		CHAR(10) + N'(' + CHAR(13) +
		CHAR(10) + N'	 NAME = N''' + @DatabaseName + N'_data''' + CHAR(13) +
		CHAR(10) + N'	,FILENAME = N''' + @DefaultDataPath  + @DatabaseName + N'_data.ndf''' + CHAR(13) +
		CHAR(10) + N'	,SIZE = 64MB' + CHAR(13) +
		CHAR(10) + N'	,FILEGROWTH = 64MB' + CHAR(13) +
		CHAR(10) + N'	,MAXSIZE = UNLIMITED' + CHAR(13) +
		CHAR(10) + N'),' + CHAR(13) +
		CHAR(10) + N'FILEGROUP [INDEX]' + CHAR(13) +
		CHAR(10) + N'(' + CHAR(13) +
		CHAR(10) + N'	 NAME = N''' + @DatabaseName + N'_index''' + CHAR(13) +
		CHAR(10) + N'	,FILENAME = N''' + @DefaultDataPath  + @DatabaseName + N'_index.ndf''' + CHAR(13) +
		CHAR(10) + N'	,SIZE = 64MB' + CHAR(13) +
		CHAR(10) + N'	,FILEGROWTH = 64MB' + CHAR(13) +
		CHAR(10) + N'	,MAXSIZE = UNLIMITED' + CHAR(13) +
		CHAR(10) + N')' + CHAR(13) +
		CHAR(10) + N'LOG ON' + CHAR(13) +
		CHAR(10) + N'(' + CHAR(13) +
		CHAR(10) + N'	 NAME = N''' + @DatabaseName + N'_log''' + CHAR(13) +
		CHAR(10) + N'	,FILENAME = N''' + @DefaultLogPath  + @DatabaseName + N'_log.ldf''' + CHAR(13) +
		CHAR(10) + N'	,SIZE = 64MB' + CHAR(13) +
		CHAR(10) + N'	,FILEGROWTH = 64MB' + CHAR(13) +
		CHAR(10) + N'	,MAXSIZE = UNLIMITED' + CHAR(13) +
		CHAR(10) + N'); ';

		RAISERROR ('Creating new database called %s.', 0, 1, @DatabaseName) WITH NOWAIT;

		EXECUTE(@SQL);

		IF EXISTS(SELECT * FROM [sys].[databases] WHERE [name] = 'TempDBForDefaultPath')
		BEGIN
			ALTER DATABASE [TempDBForDefaultPath] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
			DROP DATABASE  [TempDBForDefaultPath];
		END;
	END;

	IF EXISTS(SELECT * FROM [sys].[databases] WHERE [name] = @DatabaseName)
	BEGIN
		RAISERROR ('Confirming session handling properties.', 0, 1) WITH NOWAIT;

		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET ANSI_NULL_DEFAULT OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET ANSI_NULLS OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET ANSI_PADDING OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET ANSI_WARNINGS OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET ARITHABORT OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET AUTO_CLOSE OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET AUTO_CREATE_STATISTICS ON WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET AUTO_SHRINK OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET AUTO_UPDATE_STATISTICS ON WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET AUTO_UPDATE_STATISTICS_ASYNC OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET CONCAT_NULL_YIELDS_NULL OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET CURSOR_CLOSE_ON_COMMIT OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET CURSOR_DEFAULT GLOBAL WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET DATE_CORRELATION_OPTIMIZATION OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET ENABLE_BROKER WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET MULTI_USER WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET NUMERIC_ROUNDABORT OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET PARAMETERIZATION SIMPLE WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET QUOTED_IDENTIFIER OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET PAGE_VERIFY CHECKSUM WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET READ_WRITE WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET RECOVERY SIMPLE WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);
	
		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET RECURSIVE_TRIGGERS OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);

		SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] SET TRUSTWORTHY OFF WITH ROLLBACK IMMEDIATE;';

		EXECUTE(@SQL);

		SET @SQL = N'SELECT @IsDefault = [is_default] FROM [' + @DatabaseName + N'].[sys].[filegroups] WHERE [name] = N''DATA''';
	
		SET @Parmeters = N'@IsDefault BIT OUTPUT';

		EXECUTE [sys].[sp_executesql] @SQL, @Parmeters, @IsDefault = @IsDefault OUTPUT;

		IF (@IsDefault <> 1)
		BEGIN
			SET @SQL = N'ALTER DATABASE [' + @DatabaseName + N'] MODIFY FILEGROUP [DATA] DEFAULT;';

			EXECUTE(@SQL);
		END;

		IF NOT EXISTS (SELECT * FROM [sys].[server_principals] WHERE [name] = @DBOwnerName)
		BEGIN
			SET @SQL = N'CREATE LOGIN [' + @DBOwnerName + N'] WITH PASSWORD = 0x02006955D3005AFB29ED10FF3B02CCDB1D581F92C54DC75B362A5942F6A80A07DEDF2DF65381438F1A46A10A4D533CDAB560D2CB6CC48F151D8E54093A3F287176694FAB6115 HASHED, SID = 0x8560B429A48AD445A84DBE48BD127A6C, DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF;';
	
			EXECUTE(@SQL);

			SET @SQL = N'ALTER LOGIN [' + @DBOwnerName + N'] DISABLE;';

			EXECUTE(@SQL);

			SET @SQL = N'DENY CONNECT SQL TO [' + @DBOwnerName + N'];';

			EXECUTE(@SQL);
		END;

		IF ((SELECT SUSER_SNAME([owner_sid]) FROM [sys].[databases] WHERE [name] = @DatabaseName) <> @DBOwnerName)
		BEGIN
			SET @SQL = N'EXECUTE [' + @DatabaseName + N'].[dbo].[sp_changedbowner] @loginame = ''' + @DBOwnerName + N''';';

			EXECUTE(@SQL);
		END;
	END;
GO

USE [<database_name>];
GO
EXECUTE [sys].[sp_configure] 'show advanced options', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO

EXECUTE [sys].[sp_configure] 'clr enabled', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO
