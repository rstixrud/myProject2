SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Procedures\dbo.InsertCedarsSite.sql"', 0, 1) WITH NOWAIT;
GO

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[InsertCedarsSite]') AND [type] IN (N'P', N'PC'))
BEGIN
	EXECUTE ('CREATE PROCEDURE [dbo].[InsertCedarsSite] AS RAISERROR(''UNDEFINED!'', 16, 1);');
END;
GO 

/*================================================================================================================ 
Script: dbo.InsertCedarsSite.sql 

Synopsis: 

Notes: 

================================================================================================================== 
Revision History: 

Date			Author				Description 
------------------------------------------------------------------------------------------------------------------ 
04/04/2016		Bob Stixrud			Script Created 

==================================================================================================================*/
ALTER PROCEDURE [dbo].[InsertCedarsSite]
(
	@Debug AS BIT = 0
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


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Executing: [dbo].[InsertCedarsSite]...';


	INSERT INTO [dbo].[CEDARS_Site]
	(
			 [SiteID]
			,[SiteCity]
			,[SiteState]
			,[SiteZipCode]
			,[Residential_Flag]
			,[NAICSCode]
	)
	SELECT	 [SiteID]           = CAST([SiteID] AS NVARCHAR(255))
			,[SiteCity]         = CAST([SiteCity] AS NVARCHAR(255))
			,[SiteState]        = CAST([SiteState] AS NVARCHAR(255))
			,[SiteZipCode]      = CAST([SiteZipCode] AS NVARCHAR(255))
			,[Residential_Flag] = CAST([Residential_Flag] AS BIT)
			,[NAICSCode]        = CAST([NAICSCode] AS NVARCHAR(255))
	FROM	 [Staging].[Site];


	/*** output ***/ IF (@Debug=1) EXECUTE [dbo].[PrintOutput] @Indent=3, @Text=N'Completed!';

END;
GO
