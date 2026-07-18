/****** Object:  Table [dbo].[tbl_ProcessQueue]    Script Date: 01/31/2021 10:40:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_ProcessQueue](
	[ProcessQueueId] [bigint] IDENTITY(1,1) NOT NULL,
	[ProcessType] [nvarchar](50) NULL,
	[EmailSubject] [nvarchar](500) NULL,
	[EmailFrom] [nvarchar](100) NULL,
	[EmailTo] [nvarchar](max) NULL,
	[EmailCC] [nvarchar](max) NULL,
	[EmailBCC] [nvarchar](max) NULL,
	[EmailBody] [nvarchar](max) NULL,
	[ProcessStatus] [nvarchar](50) NULL,
	[ProcessRegisterTime] [datetime] NULL CONSTRAINT [DF_tbl_ProcessQueue_ProcessRegisterTime]  DEFAULT (getdate()),
	[ProcessStartAtThisTime] [datetime] NULL,
	[ProcessStartTime] [datetime] NULL,
	[ProcessEndTime] [datetime] NULL,
	[Deleted] [bit] NULL CONSTRAINT [DF_tbl_ProcessQueue_Deleted]  DEFAULT ((0)),
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_tbl_ProcessQueue_CreatedDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tbl_ProcessQueue] PRIMARY KEY CLUSTERED 
(
	[ProcessQueueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


