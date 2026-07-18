/****** Object:  Table [dbo].[dtaUsers_ProjectAccess]    Script Date: 06/30/2019 11:43:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dtaUsers_ProjectAccess](
	[ProjectAccessId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Primary_Task_ID] [nvarchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_dtaUsers_ProjectAccess] PRIMARY KEY CLUSTERED 
(
	[ProjectAccessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[dtaUsers_ProjectAccess] ADD  CONSTRAINT [DF_dtaUsers_ProjectAccess_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO


