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

