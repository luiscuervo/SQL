/*** Stored procedure to add records to the table Paciente ***/

CREATE proc ALTA_Paciente(
			@dni varchar(20),
			@nombre varchar(50),
			@apellido varchar(50),
			@fnacimiento varchar(8),
			@domicilio varchar(50),
			@idpais char(3),
			@tel varchar(20)='',
			@email varchar(30),
			@observacion varchar(1000)=''
			)
	/* Previously stated variables are the fields that will be fed to the procedure*/
as

/* Now we check if the record exists alredy, based on primary key dni*/
IF NOT EXISTS(SELECT * from Paciente WHERE dni=@dni)
BEGIN
	INSERT INTO Paciente (dni,nombre,apellido,fnacimiento,domicilio,idpais,telefono,email,observacion)
	VALUES (@dni,@nombre,@apellido,@fnacimiento,@domicilio,@idpais,@tel,@email,@observacion)
	print 'El paciente se agregó correctamente'
	return
END
ELSE
BEGIN
	print 'El paciente ya existe.'
	return
END



/*** Stored procedure to update a patient ***/

CREATE PROC UPD_Paciente(
				@idpaciente paciente,
				@nombre varchar(50),
				@apellido varchar(50),
				@domicilio varchar(50),
				@email varchar(30))

AS
set nocount on

if exists(SELECT * from Paciente
			WHERE idPaciente = @idpaciente)
	UPDATE Paciente SET nombre = @nombre,
					apellido = @apellido,
					domicilio = @domicilio,
					email = @email
	WHERE idpaciente = @idpaciente


ELSE
	SELECT 0 as resultado

-- Here would be the code to test the procedure:
-- exec UPD_Paciente 4,'Jean','Darros','montes 435',jeand@gmail.com
