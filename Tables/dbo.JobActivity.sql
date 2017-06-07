RAISERROR ('*** Executing SQL: "...\Tables\dbo.JobActivity.sql"', 0, 1) WITH NOWAIT;
GO

--comment made here
IF NOT EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[JobActivity]') AND [type] IN (N'U')) 
BEGIN 
	CREATE TABLE [dbo].[JobActivity] 
	( 
		 [JobToken]     UNIQUEIDENTIFIER NOT NULL
		,[CreateDate]   DATETIME         NOT NULL 
		,[Path]         NVARCHAR(512)    NOT NULL
		,[StartDate]    DATETIME             NULL 
		,[EndDate]      DATETIME             NULL 
		,[ErrorNumber]	INT                  NULL 
		,[ErrorMessage] NVARCHAR(2048)       NULL 
	)
	ON [DATA];
END;
GO 

IF NOT EXISTS (SELECT * FROM [sys].[indexes] WHERE [object_id] = OBJECT_ID(N'[dbo].[JobActivity]') AND [name] = N'PK__JobActivity__JobToken') 
BEGIN 
	ALTER TABLE [dbo].[JobActivity] ADD CONSTRAINT [PK__JobActivity__JobToken] PRIMARY KEY ([JobToken] ASC) ON [DATA]; 
END; 
GO 

IF NOT EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE [id] = OBJECT_ID(N'[dbo].[DF__JobActivity__CreateDate]') AND [type] = 'D') 
BEGIN 
	ALTER TABLE [dbo].[JobActivity] ADD CONSTRAINT [DF__JobActivity__CreateDate] DEFAULT (CURRENT_TIMESTAMP) FOR [CreateDate]; 
END; 
GO 
