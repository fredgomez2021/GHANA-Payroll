/****** Object:  Table [dbo].[dtaBonusesDetails]    Script Date: 08/06/2017 10:25:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dtaBonusesDetails](
	[BonusDetailId] [bigint] IDENTITY(1,1) NOT NULL,
	[Period1] [smalldatetime] NULL,
	[Employee_PIN] [int] NULL CONSTRAINT [DF_dtaBonusesDetails_Employee_PIN]  DEFAULT ((0)),
	[Bonus_UPH] [money] NULL CONSTRAINT [DF_dtaBonusesDetails_Bonus_UPH]  DEFAULT ((0)),
	[Bonus_Quality] [money] NULL CONSTRAINT [DF_dtaBonusesDetails_Bonus_Quality]  DEFAULT ((0)),
	[Bonus_Retention] [money] NULL CONSTRAINT [DF_dtaBonusesDetails_Bonus_Retention]  DEFAULT ((0)),
	[Bonus_Attendance] [money] NULL CONSTRAINT [DF_dtaBonusesDetails_Bonus_Attendance]  DEFAULT ((0)),
	[Remarks] [nvarchar](500) NULL CONSTRAINT [DF_dtaBonusesDetails_Remarks]  DEFAULT (''),
	[Deleted] [bit] NULL CONSTRAINT [DF_dtaBonusesDetails_Deleted]  DEFAULT ((0)),
 CONSTRAINT [PK_dtaBonusesDetails] PRIMARY KEY CLUSTERED 
(
	[BonusDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


