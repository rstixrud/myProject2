SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\dbo.ParseDirectory.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[ParseDirectory]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [dbo].[ParseDirectory];
END;
GO

CREATE FUNCTION [dbo].[ParseDirectory](@Path NVARCHAR(512))
RETURNS NVARCHAR(512)
AS
BEGIN
    RETURN LEFT(@Path, LEN(@Path) - (CHARINDEX(N'\', REVERSE(@Path)) - 1));
END;
GO
