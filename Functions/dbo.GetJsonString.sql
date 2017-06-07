SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\dbo.GetJsonString.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[GetJsonString]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [dbo].[GetJsonString];
END;
GO

CREATE FUNCTION [dbo].[GetJsonString]
(
	@JobID AS NVARCHAR(35),
	@Status AS NVARCHAR(35),
	@Data AS NVARCHAR(35)
)
RETURNS NVARCHAR(4000)
AS
BEGIN
	DECLARE @Json AS NVARCHAR(4000);
	DECLARE @Token AS NVARCHAR(64);

	SET @Token = [config].[GetCedarsApiToken](@JobID);

	IF (@Status IN (N'completed', N'received', N'error'))
	BEGIN	
		SET @Json = N'{"token": "' + @Token  + N'", "job_id": "' + @JobID  + N'", "status": "' + @Status + N'"' + ISNULL(N', "data": "' + REPLACE(@Data, N'"', N'\"') + N'"}', N'}');
	END;

	RETURN @Json;
END;
GO
