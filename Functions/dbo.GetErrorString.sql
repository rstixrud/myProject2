SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

RAISERROR ('*** Executing SQL: "...\Functions\dbo.GetErrorString.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(N'[dbo].[GetErrorString]') AND [type] IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN 
	DROP FUNCTION [dbo].[GetErrorString]; 
END; 
GO

CREATE FUNCTION [dbo].[GetErrorString] 
(
	@ErrorNumber AS INT, 
	@ErrorSeverity AS INT, 
	@ErrorState AS INT, 
	@ErrorLine AS INT, 
	@ErrorProcedure AS NVARCHAR(200),
	@ErrorMessage AS NVARCHAR(4000)
)
RETURNS NVARCHAR(4000) 
AS 
BEGIN 
	DECLARE @String AS NVARCHAR(4000);

	SET @String = N'';

	-- Remove carriage return characters
	SET @ErrorMessage = REPLACE(@ErrorMessage, CHAR(13), SPACE(1));
	-- Remove line feed characters
	SET @ErrorMessage = REPLACE(@ErrorMessage, CHAR(10), SPACE(1));
	-- Remove tab characters
	SET @ErrorMessage = REPLACE(@ErrorMessage, CHAR(09), SPACE(1));
	-- Remove extra space characters
	WHILE (CHARINDEX(SPACE(2), @ErrorMessage) <> 0)
	BEGIN
		SET @ErrorMessage = REPLACE(@ErrorMessage, SPACE(2),  SPACE(1));
	END;

	-- Build SQL formatted error message string
	SET @String = @String + N'Error ' + CAST(@ErrorNumber AS NVARCHAR) + N', ';
	SET @String = @String + N'Level ' + CAST(@ErrorSeverity AS NVARCHAR) + N', '; 
	SET @String = @String + N'State ' + CAST(@ErrorState AS NVARCHAR) + N', '; 
	SET @String = @String + N'Procedure ' + @ErrorProcedure + N', '; 
	SET @String = @String + N'Line ' + CAST(@ErrorLine AS NVARCHAR) + N', '; 
	SET @String = @String + N'Message: ' + @ErrorMessage;

	RETURN @String;
END; 
GO 
