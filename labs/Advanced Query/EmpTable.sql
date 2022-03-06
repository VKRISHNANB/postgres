
GO

/****** Object:  Table [dbo].[tblEm]    Script Date: 03/27/2015 19:06:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblEm](
	[EmpNo] [int] NOT NULL,
	[Ename] [varchar](50) NOT NULL,
	[Job] [varchar](50) NOT NULL,
	[Manager] [int] NULL,
	[DateOfJoining] [date] NOT NULL,
	[Salary] [int] NOT NULL,
	[Comm] [int] NULL,
	[DeptNo] [int] NOT NULL,
 CONSTRAINT [PK_tblEm] PRIMARY KEY CLUSTERED 
(
	[EmpNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




