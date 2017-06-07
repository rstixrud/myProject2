RAISERROR ('*** Executing SQL: "...\Synonyms\dbo.CEDARS_CET_Program.sql"', 0, 1) WITH NOWAIT;
GO

/*================================================================================================================
Script:		dbo.CEDARS_CET_Program.sql

Synopsis:	Creates the synonym needed for the CETMGMT database to reference the necessary object in the correct
			corresponding database. This will allow all the different variations of the CETMGMT database to have
			identical code definitions but point to different databases.

Notes:		Uses the procedure: [dbo].[CreateSynonym] to create the synonym.

==================================================================================================================
Revision History:

Date			Author				Description
------------------------------------------------------------------------------------------------------------------
03/24/2017		Bob Stixrud			Script Created

==================================================================================================================*/
IF (OBJECT_ID(N'[dbo].[CreateSynonym]') IS NOT NULL)
BEGIN
	EXECUTE [dbo].[CreateSynonym] @FullyQualifiedName = N'[CEDARS_CET].[dbo].[Program]';
END
ELSE RAISERROR(N'Error - The procedure: [dbo].[CreateSynonym] does not exist.', 16, 1);
GO
