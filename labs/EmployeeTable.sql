use Sample
GO

/****** Object:  Table [dbo].[tblEmp]    Script Date: 03/24/2015 12:18:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblEmp](
	[EmpNo] [int] NOT NULL,
	[EmpName] [varchar](50) NOT NULL,
	[Job] [varchar](50) NOT NULL,
	[ManagerNo] [int] NOT NULL,
	[DateOfJoining] [date] NOT NULL,
	[Salary] [int] NOT NULL,
	[DeptNo] [int] NOT NULL,
 CONSTRAINT [PK_tblEmp] PRIMARY KEY CLUSTERED 
(
	[EmpNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



