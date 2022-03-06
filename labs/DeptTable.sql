USE [EmployeeDetails]
GO

/****** Object:  Table [dbo].[tblDept]    Script Date: 03/24/2015 12:17:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblDept](
	[DeptId] [int] NOT NULL,
	[DeptName] [varchar](50) NOT NULL,
	[Location] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblDept] PRIMARY KEY CLUSTERED 
(
	[DeptId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[tblEmp]  WITH CHECK ADD  CONSTRAINT [FK_tblEmp_tblDept] FOREIGN KEY([DeptNo])
REFERENCES [dbo].[tblDept] ([DeptId])
GO

ALTER TABLE [dbo].[tblEmp] CHECK CONSTRAINT [FK_tblEmp_tblDept]
GO


