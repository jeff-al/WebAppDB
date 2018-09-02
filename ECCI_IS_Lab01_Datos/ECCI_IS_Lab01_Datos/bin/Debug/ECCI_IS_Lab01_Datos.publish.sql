/*
Script de implementación para DB_B60380

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DB_B60380"
:setvar DefaultFilePrefix "DB_B60380"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creando [dbo].[Curso]...';


GO
CREATE TABLE [dbo].[Curso] (
    [CursoID]  INT           IDENTITY (1, 1) NOT NULL,
    [Titulo]   NVARCHAR (50) NULL,
    [Creditos] INT           NULL,
    PRIMARY KEY CLUSTERED ([CursoID] ASC)
);


GO
PRINT N'Creando [dbo].[Estudiante]...';


GO
CREATE TABLE [dbo].[Estudiante] (
    [EstudianteID]   INT           IDENTITY (1, 1) NOT NULL,
    [Apellido]       NVARCHAR (50) NULL,
    [Nombre]         NVARCHAR (50) NULL,
    [FechaMAtricula] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([EstudianteID] ASC)
);


GO
PRINT N'Creando [dbo].[Matricula]...';


GO
CREATE TABLE [dbo].[Matricula] (
    [MatriculaID]  INT            IDENTITY (1, 1) NOT NULL,
    [Nota]         DECIMAL (3, 2) NULL,
    [CursoID]      INT            NOT NULL,
    [EstudianteID] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([MatriculaID] ASC)
);


GO
PRINT N'Creando [dbo].[FK_dbo.MAtricula_dbo.Curso_CursoID]...';


GO
ALTER TABLE [dbo].[Matricula] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.MAtricula_dbo.Curso_CursoID] FOREIGN KEY ([CursoID]) REFERENCES [dbo].[Curso] ([CursoID]) ON DELETE CASCADE;


GO
PRINT N'Creando [dbo].[FK_dbo.Matricula_dbo.Estudiante_EstudianteID]...';


GO
ALTER TABLE [dbo].[Matricula] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.Matricula_dbo.Estudiante_EstudianteID] FOREIGN KEY ([EstudianteID]) REFERENCES [dbo].[Estudiante] ([EstudianteID]) ON DELETE CASCADE;


GO
/*
Plantilla de script posterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se anexarán al script de compilación.		
 Use la sintaxis de SQLCMD para incluir un archivo en el script posterior a la implementación.			
 Ejemplo:      :r .\miArchivo.sql								
 Use la sintaxis de SQLCMD para hacer referencia a una variable en el script posterior a la implementación.		
 Ejemplo:      :setvar TableName miTabla							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
MERGE INTO Curso AS Target
USING (VALUES
		(1, 'Ingenieria de Software', 5),
		(2, 'Bases de Datos', 5),
		(3, 'Proyecto', 3) 
) 
AS Source ([CursoID], Titulo, Creditos) 
ON Target.CursoID = Source.CursoID 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (Titulo, Creditos) 
VALUES (Titulo, Creditos); 

MERGE INTO Estudiante AS Target
USING (VALUES 
		(1, 'Salas', 'Andrea', '2015-09-01'),
		(2, 'Guzman', 'Luis', '2016-01-13'),
		(3, 'Ramirez', 'Erick', '2017-09-03') 
) AS Source (EstudianteID, Apellido, Nombre, FechaMatricula)
ON Target.EstudianteID = Source.EstudianteID 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (Apellido, Nombre, FechaMatricula) 
VALUES (Apellido, Nombre, FechaMatricula); 

MERGE INTO Matricula AS Target 
USING (VALUES 
(1, 2.00, 1, 1),
(2, 3.50, 1, 2),
(3, 4.00, 2, 3),
(4, 1.80, 2, 1), 
(5, 3.20, 3, 1), 
(6, 4.00, 3, 2) 
) 
AS Source (MatriculaID, Nota, CursoID, EstudianteID) 
ON Target.MatriculaID = Source.MatriculaID 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (Nota, CursoID, EstudianteID) 
VALUES (Nota, CursoID, EstudianteID);

GO

GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Matricula] WITH CHECK CHECK CONSTRAINT [FK_dbo.MAtricula_dbo.Curso_CursoID];

ALTER TABLE [dbo].[Matricula] WITH CHECK CHECK CONSTRAINT [FK_dbo.Matricula_dbo.Estudiante_EstudianteID];


GO
PRINT N'Actualización completada.';


GO
