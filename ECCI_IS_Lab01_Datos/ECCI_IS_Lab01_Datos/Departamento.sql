CREATE TABLE [dbo].[Departamento]
(
	[DepartamentoId] INT IDENTITY (1, 1) NOT NULL,
	[Nombre]		 NVARCHAR (50) NULL,
	[Presupuesto]	 FLOAT NULL,
	PRIMARY KEY CLUSTERED ([DepartamentoId] ASC)
)
