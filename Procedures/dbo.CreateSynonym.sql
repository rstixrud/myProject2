SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.CreateSynonym.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[CreateSynonym]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[CreateSynonym] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script:		dbo.CreateSynonym.sql

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
ALTER PROCEDURE [dbo].[CreateSynonym]
(
	@Debug AS BIT = 0,
	@FullyQualifiedName AS NVARCHAR(MAX)
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
	DECLARE @Delimiter AS NCHAR(1);
	DECLARE @SqlString AS NVARCHAR(4000);
	DECLARE @Synonym   AS NVARCHAR(MAX);
	DECLARE @Database  AS NVARCHAR( 128);
	DECLARE @Schema    AS NVARCHAR( 128);
	DECLARE @Object    AS NVARCHAR( 128);
	DECLARE @Start     AS INT;
	DECLARE @End       AS INT;

	---------------------------------------------------------------------------------------------------
	--// T-SQL CODE                                                                                //--
	---------------------------------------------------------------------------------------------------
	

	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Text=N'SQL Execution Starting:';
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=0, @Text=N'Executing: [config].[CreateSynonym]...';
	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Parameter: @FullyQualifiedName = ', @NVARCHAR=@FullyQualifiedName;


	-- Remove any bracket type characters
	SET @FullyQualifiedName = REPLACE(REPLACE(@FullyQualifiedName, N'[', N''), N']', N'');

	-- Set the delimiter for parsing
	SET @Delimiter = N'.';

	-- Verify the object for the synonym exists
	IF (ISNULL(OBJECT_ID(@FullyQualifiedName), 0) IS NOT NULL)
	BEGIN
		-- Locate and parse the database name starting at the begining
		SET @Start = ISNULL(@End, 0) + 1;
		SET @End = COALESCE(NULLIF(CHARINDEX(@Delimiter, @FullyQualifiedName, @Start), 0), LEN(@FullyQualifiedName) + 1);
		SET @Database = SUBSTRING(@FullyQualifiedName, @Start, @End - @Start);


		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Parameter: @Database = ', @NVARCHAR=@Database;
		

		-- Locate and parse the schema name based on the location of the database name
		SET @Start = ISNULL(@End, 0) + 1;
		SET @End = COALESCE(NULLIF(CHARINDEX(@Delimiter, @FullyQualifiedName, @Start), 0), LEN(@FullyQualifiedName) + 1);
		SET @Schema = SUBSTRING(@FullyQualifiedName, @Start, @End - @Start);
		

		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Parameter: @Schema = ', @NVARCHAR=@Schema;
		

		-- Locate and parse the object name based on the location of the schema name
		SET @Start = ISNULL(@End, 0) + 1;
		SET @End = COALESCE(NULLIF(CHARINDEX(@Delimiter, @FullyQualifiedName, @Start), 0), LEN(@FullyQualifiedName) + 1);
		SET @Object = SUBSTRING(@FullyQualifiedName, @Start, @End - @Start);
		

		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Parameter: @Object = ', @NVARCHAR=@Object;


		-- Set the correct Cedars database type based on the parsed database name.
		IF (CHARINDEX(N'CEDARS_CET', @Database) > 0) SET @Database = N'CEDARS_CET';
		ELSE IF (CHARINDEX(N'CEDARS', @Database) > 0) SET @Database = N'CEDARS';

		-- Concatenate name for the synonym
		SET @Synonym = @Database + N'_' + @Object;


		/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Parameter: @Synonym = ', @NVARCHAR=@Synonym;


		-- Drop the existing synonym name
		IF EXISTS (SELECT * FROM [sys].[synonyms] WHERE [name] = @Synonym AND [schema_id] = SCHEMA_ID(@Schema))
		BEGIN
			SET @SqlString = N'DROP SYNONYM [dbo].[' + @Synonym + N'];';
			

			/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Parameter: @SqlString = ', @NVARCHAR=@SqlString;


			EXECUTE [sys].[sp_executesql] @SqlString;
		END;

		-- Create the new synonym. This makes use of the config.GetCedarsDatabase function which matches the calling
		-- CETMGMT database to the correct Cedars database depending on if the name is CEDARS or CEDARS_CET.
		IF NOT EXISTS (SELECT * FROM [sys].[synonyms] WHERE [name] = @Synonym AND [schema_id] = SCHEMA_ID(@Schema))
		BEGIN
			SET @SqlString = N'CREATE SYNONYM [' + @Schema + N'].[' + @Synonym + N'] FOR [' + [config].[GetCedarsDatabase](@Database) + N'].[' + @Schema + N'].[' + @Object + N'];';


			/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=1, @Text=N'Parameter: @SqlString = ', @NVARCHAR=@SqlString;


			EXECUTE [sys].[sp_executesql] @SqlString;
		END;
	END;
END;
GO
