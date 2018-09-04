CREATE PROCEDURE [dbo].[Departamento_Insert]
	@Nombre NVARCHAR(50),
	@Presupuesto float = 0.0
AS
	BEGIN 
		INSERT INTO [Departamento] ([Nombre],[Presupuesto])
		VALUES (@Nombre, @Presupuesto)
		END
RETURN 0
