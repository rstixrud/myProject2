SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.PrintOutput.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[PrintOutput]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[PrintOutput] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO

/*================================================================================================================
Script:		dbo.PrintOutput.sql

Synopsis:	

Notes:

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
03/24/2017		Bob Stixrud			Script Created

==================================================================================================================*/
ALTER PROCEDURE [dbo].[PrintOutput]
(
	@Text NVARCHAR(255) = NULL,
	@Indent INT = NULL,
	@INT INT = NULL,
	@BIT BIT = NULL,
	@DATETIME DATETIME = NULL,
	@NVARCHAR NVARCHAR(4000) = NULL,
	@XML XML = NULL,
	@UNIQUEIDENTIFIER UNIQUEIDENTIFIER = NULL
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
	DECLARE	@MessagePrefix AS NVARCHAR(  45);
	DECLARE	@MessageIndent AS NVARCHAR(  10);
	DECLARE	@MessageDepth  AS INT           ;
	DECLARE	@MessageText   AS NVARCHAR(4000);
	DECLARE @ParameterText AS NVARCHAR(4000);

	SET @MessageDepth = @Indent;
	SET @MessagePrefix = SPACE(6);
	SET @MessageIndent = N'  |  ';

	IF (@INT IS NOT NULL) SET @ParameterText = CAST(@INT AS NVARCHAR(10));
	IF (@BIT IS NOT NULL) SET @ParameterText = CAST(@BIT AS NVARCHAR(1));
	IF (@DATETIME IS NOT NULL) SET @ParameterText = CONVERT(NVARCHAR(23), @DATETIME, 126);
	IF (@NVARCHAR IS NOT NULL) SET @ParameterText = @NVARCHAR;
	IF (@XML IS NOT NULL) SET @ParameterText = CAST(@XML AS NVARCHAR(4000));
	IF (@UNIQUEIDENTIFIER IS NOT NULL) SET @ParameterText = CAST(@UNIQUEIDENTIFIER AS NVARCHAR(128));

	SET @MessageText = ISNULL(@MessagePrefix + REPLICATE(@MessageIndent, @MessageDepth), N'') + @Text + ISNULL(@ParameterText, N'');

	RAISERROR (@MessageText, 0, 1) WITH NOWAIT;
END;
GO
