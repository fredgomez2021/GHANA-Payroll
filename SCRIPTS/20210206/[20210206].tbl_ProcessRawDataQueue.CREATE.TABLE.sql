/****** Object:  Table [dbo].[tbl_ProcessRawDataQueue]    Script Date: 02/06/2021 4:57:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_ProcessRawDataQueue](
	[ProcessRawDataId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeePIN] [int] NULL,
	[PeriodFrom] [datetime] NULL,
	[PeriodEnd] [datetime] NULL,
	[ProcessStatus] [nvarchar](50) NULL CONSTRAINT [DF_tbl_ProcessRawDataQueue_ProcessStatus]  DEFAULT ('READY'),
	[ProcessStartTime] [datetime] NULL,
	[ProcessEndTime] [datetime] NULL,
	[Remarks] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_tbl_ProcessRawDataQueue_CreatedDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tbl_ProcessRawDataQueue] PRIMARY KEY CLUSTERED 
(
	[ProcessRawDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


