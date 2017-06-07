RAISERROR ('*** Executing SQL: "...\Views\dbo.JobActivityView.sql"', 0, 1) WITH NOWAIT;
GO

IF EXISTS (SELECT * FROM [sys].[views] WHERE [object_id] = OBJECT_ID(N'[dbo].[JobActivityView]'))
BEGIN
	DROP VIEW [dbo].[JobActivityView];
END;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE VIEW [dbo].[JobActivityView] 
AS
	SELECT	 [JobActivity].*, [Status] = CASE [CETJobQueue].[status] WHEN 1 THEN N'Queued' ELSE 'Processing' END, [QueuingOrder] = [CETJobQueue].[queuing_order]
	FROM	 [dbo].[JobActivity] AS [JobActivity]
				LEFT OUTER JOIN [sys].[conversation_endpoints] as [Endpoint]
						ON [JobActivity].[JobToken] = [Endpoint].[conversation_id]
				LEFT OUTER JOIN [dbo].[CETJobQueue] AS [CETJobQueue] WITH(NOLOCK)
						ON [Endpoint].[conversation_handle] = [CETJobQueue].[conversation_handle]
	WHERE	 [Endpoint].[is_initiator] = 0
			 AND [Endpoint].[state] <> 'CD'

	UNION ALL

	SELECT	 *, [Status] = 'Completed', [QueuingOrder] = NULL
	FROM	 [dbo].[JobActivity] WITh(NOLOCK)
	WHERE	 [EndDate] IS NOT NULL
GO
