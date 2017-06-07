RAISERROR ('*** Executing SQL: "...\Tables\Staging.Program.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[Program]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[Program]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[Program]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [Staging].[Program]
	(
		 [PA]                       NVARCHAR(MAX)     NULL
		,[PrgID]                    NVARCHAR(MAX) NOT NULL
		,[ProgramName]              NVARCHAR(MAX)     NULL
		,[PrimarySector]            NVARCHAR(MAX)     NULL
		,[Sector]                   NVARCHAR(MAX)     NULL
		,[ProgramImplementer]       NVARCHAR(MAX)     NULL
		,[ProgramCategory]          NVARCHAR(MAX)     NULL
		,[StatewideProgram]         NVARCHAR(MAX)     NULL
		,[ImplementationContractor] NVARCHAR(MAX)     NULL
		,[ProgramManager]           NVARCHAR(MAX)     NULL
		,[StartYear]                NVARCHAR(MAX)     NULL
		,[EndYear]                  NVARCHAR(MAX)     NULL
		,[ClaimsOnly_Flag]          NVARCHAR(MAX)     NULL
		,[Resource_Flag]            NVARCHAR(MAX)     NULL
		,[NonResource_Flag]         NVARCHAR(MAX)     NULL
		,[Deemed_Flag]              NVARCHAR(MAX)     NULL
		,[Custom_Flag]              NVARCHAR(MAX)     NULL
		,[Upstream_Flag]            NVARCHAR(MAX)     NULL
		,[Midstream_Flag]           NVARCHAR(MAX)     NULL
		,[Downstream_Flag]          NVARCHAR(MAX)     NULL
		,[DirectInstall]            NVARCHAR(MAX)     NULL
		,[Audit_Flag]               NVARCHAR(MAX)     NULL
		,[Financing]                NVARCHAR(MAX)     NULL
		,[ParentProgram]            NVARCHAR(MAX)     NULL
		,[Exclude_From_Budget]      NVARCHAR(MAX)     NULL
	) 
	ON [DATA]; 
END; 
GO 
