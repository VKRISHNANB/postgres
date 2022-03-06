use Sample
GO

/****** Object:  Table [dbo].[tblEmp]    Script Date: 03/24/2015 12:18:43 ******/

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
)
)
