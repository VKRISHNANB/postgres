USE Sample
GO

/****** Object:  Table [dbo].[tblDept]    Script Date: 03/24/2015 12:17:35 ******/

CREATE TABLE [dbo].[tblDept](
	[DeptId] [int] NOT NULL,
	[DeptName] [varchar](50) NOT NULL,
	[Location] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblDept] PRIMARY KEY CLUSTERED 
(
	[DeptId] ASC
)
) 
GO


ALTER TABLE [dbo].[tblEmp]  WITH CHECK ADD  CONSTRAINT [FK_tblEmp_tblDept] FOREIGN KEY([DeptNo])
REFERENCES [dbo].[tblDept] ([DeptId])
GO

ALTER TABLE [dbo].[tblEmp] CHECK CONSTRAINT [FK_tblEmp_tblDept]
GO

