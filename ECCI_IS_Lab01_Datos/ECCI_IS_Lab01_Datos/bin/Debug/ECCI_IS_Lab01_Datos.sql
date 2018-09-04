/*
Script de implementación para ECCI_IS_Lab01_Datos_3

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ECCI_IS_Lab01_Datos_3"
:setvar DefaultFilePrefix "ECCI_IS_Lab01_Datos_3"
:setvar DefaultDataPath "C:\Users\Usuario\AppData\Local\Microsoft\VisualStudio\SSDT\ECCI_IS_Lab01_Datos"
:setvar DefaultLogPath "C:\Users\Usuario\AppData\Local\Microsoft\VisualStudio\SSDT\ECCI_IS_Lab01_Datos"

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
PRINT N'Creando [dbo].[Departamento_Insert]...';


GO
CREATE PROCEDURE [dbo].[Departamento_Insert]
	@Nombre NVARCHAR(50),
	@Presupuesto float = 0.0
AS
	BEGIN 
		INSERT INTO [Departamento] ([Nombre],[Presupuesto])
		VALUES (@Nombre, @Presupuesto)
		END
RETURN 0
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

DELETE FROM Curso;
DBCC CHECKIDENT ('Curso', RESEED, 0);

DELETE FROM Estudiante;
DBCC CHECKIDENT ('Estudiante', RESEED, 0);

DELETE FROM Matricula;
DBCC CHECKIDENT ('Matricula', RESEED, 0);

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
		(1, 'Salas', 'Andrea', '2015-09-01', 'Andrea.Salas@ecci.ucr.ac.cr'),
		(2, 'Guzman', 'Luis', '2016-01-13', 'Luis.Guzman@ecci.ucr.ac.cr'),
		(3, 'Ramirez', 'Erick', '2017-09-03', 'Erick.Ramirez@ecci.ucr.ac.cr') 
) AS Source (EstudianteID, Apellido, Nombre, FechaMatricula, CorreoElectronico)
ON Target.EstudianteID = Source.EstudianteID 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (Apellido, Nombre, FechaMatricula, CorreoElectronico) 
VALUES (Apellido, Nombre, FechaMatricula, CorreoElectronico); 

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
PRINT N'Actualización completada.';


GO
