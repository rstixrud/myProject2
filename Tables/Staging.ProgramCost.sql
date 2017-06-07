RAISERROR ('*** Executing SQL: "...\Tables\Staging.ProgramCost.sql"', 0, 1) WITH NOWAIT;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT * FROM [sys].[schemas] WHERE [name] = N'Staging') 
BEGIN 
	EXECUTE [sys].[sp_executesql] N'CREATE SCHEMA [Staging] AUTHORIZATION [dbo]'; 
END; 
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[ProgramCost]') AND [type] IN (N'U')) 
BEGIN 
	DROP TABLE [Staging].[ProgramCost]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[Staging].[ProgramCost]') AND [type] IN (N'U'))
BEGIN
	CREATE TABLE [Staging].[ProgramCost] 
	(
		 [PrgID]                          NVARCHAR(MAX) NOT NULL
		,[PrgYear]                        NVARCHAR(MAX) NOT NULL
		,[ClaimYearQuarter]               NVARCHAR(MAX) NOT NULL
		,[AdminCostsOverheadAndGA]        FLOAT         NOT NULL
		,[AdminCostsOther]                FLOAT         NOT NULL
		,[MarketingOutreach]              FLOAT         NOT NULL
		,[DIActivity]                     FLOAT         NOT NULL
		,[DIInstallation]                 FLOAT         NOT NULL
		,[DIHardwareAndMaterials]         FLOAT         NOT NULL
		,[DIRebateAndInspection]          FLOAT         NOT NULL
		,[EMV]                            FLOAT         NOT NULL
		,[UserInputIncentive]             FLOAT         NOT NULL
		,[OnBillFinancing]                FLOAT         NOT NULL
		,[CostsRecoveredFromOtherSources] FLOAT         NOT NULL
		,[PA]                             NVARCHAR(MAX) NOT NULL
	) 
	ON [DATA]; 
END; 
GO 
