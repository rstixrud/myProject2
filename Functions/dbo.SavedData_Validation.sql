SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\dbo.SavedData_Validation.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[SavedData_Validation]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [dbo].[SavedData_Validation];
END;
GO

CREATE FUNCTION [dbo].[SavedData_Validation] (@CEDARSJobID AS NVARCHAR(35), @CETJobID AS INT) 
RETURNS TABLE 
AS 
RETURN 
( 
	SELECT	 [ID] 
			,[JobID] = @CEDARSJobID 
			,[Table] 
			,[ErrorType] 
			,[CET_ID] 
			,[MessageType] 
			,[Detail]

	FROM	 [dbo].[CEDARS_CET_SavedValidation] WITh(NOLOCK)

	WHERE	 [JobID] = @CETJobID
);
GO 
