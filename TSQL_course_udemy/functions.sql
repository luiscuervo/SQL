
/* Function to concatenate name and surname */

CREATE FUNCTION concatenar (
				@apellido varchar(50),
				@nombre varchar(50)
				)
RETURNS varchar(100)

AS
BEGIN
	declare @resultado varchar(100)
	set @resultado = @apellido + ', ' + @nombre
	return @resultado	

END

/* function to obtain the country of a Patient based on the id */

CREATE FUNCTION obtenerPais(
				@idpaciente paciente
				)
RETURNS varchar(50)

AS
BEGIN
	declare @pais varchar(50)
	SET @pais = (SELECT PA.pais From paciente P
					INNER JOIN Pais PA
					ON PA.idPais = P.idPais
					WHERE idPaciente=@idpaciente)
	
	RETURN @pais
END



/* Function to create a table with a list of pre-defined countries */


CREATE FUNCTION listaPaises()
RETURNS @paises TABLE(idpais char(3), pais varchar(50))
AS
BEGIN
	
	INSERT INTO @paises values('ESP','Espa�a')
	INSERT INTO @paises values('MEX','Mexico')
	INSERT INTO @paises values('CHI','Chile')
	INSERT INTO @paises values('PER','Per�')
	INSERT INTO @paises values('ARG','Argentina')

	RETURN

END
-- select * from dbo.listaPaises()




