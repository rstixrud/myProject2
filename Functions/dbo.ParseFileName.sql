SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\dbo.ParseFileName.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[ParseFileName]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [dbo].[ParseFileName];
END;
GO

CREATE FUNCTION [dbo].[ParseFileName](@Path AS NVARCHAR(512), @RemoveExtension AS BIT)
RETURNS NVARCHAR(128)
AS
BEGIN
	DECLARE @FileName AS NVARCHAR(MAX);

	SET @FileName = RIGHT(@Path, CHARINDEX(N'\', REVERSE(@Path)) - 1);

	IF (@RemoveExtension = 1)
	BEGIN
		SET @FileName = LEFT(@FileName, LEN(@FileName) - CHARINDEX(N'.', REVERSE(@FileName)));
	END;

    RETURN @FileName;
END;
GO
