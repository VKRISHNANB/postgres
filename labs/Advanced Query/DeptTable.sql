
GO

/****** Object:  Table [dbo].[tblDEPT]    Script Date: 03/27/2015 19:05:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblDEPT](
	[DeptNo] [int] NOT NULL,
	[DeptName] [varchar](50) NOT NULL,
	[Location] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblDEPT] PRIMARY KEY CLUSTERED 
(
	[DeptNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[tblEm]  WITH CHECK ADD  CONSTRAINT [FK_tblEm_tblEm] FOREIGN KEY([EmpNo])
REFERENCES [dbo].[tblEm] ([EmpNo])
GO

ALTER TABLE [dbo].[tblEm] CHECK CONSTRAINT [FK_tblEm_tblEm]
GO


