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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


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
ALTER TABLE [dbo].[Matricula]
    ADD CONSTRAINT [FK_dbo.MAtricula_dbo.Curso_CursoID] FOREIGN KEY ([CursoID]) REFERENCES [dbo].[Curso] ([CursoID]) ON DELETE CASCADE;


GO
PRINT N'Creando [dbo].[FK_dbo.Matricula_dbo.Estudiante_EstudianteID]...';


GO
ALTER TABLE [dbo].[Matricula]
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
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
