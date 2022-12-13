/*** Generated script during the Udemy course "Master in SQL server" -by mariano Pugsily **/
/*** NOTE: all these scripts were created from SQL server. They may not work by themselves. ***/
----------------------------------------------------------------------------------------------------

/******** Create a Table with three clustered primary keys ****************/

CREATE TABLE [dbo].[HistoriaPaciente](
	[idHistoria] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idMedico] [int] NOT NULL,
 CONSTRAINT [PK_HistoriaPaciente] PRIMARY KEY CLUSTERED
(
	[idHistoria] ASC,
	[idPaciente] ASC,
	[idMedico] ASC
) 
GO


/* Set foreign key */

ALTER TABLE HistoriaPaciente
ADD FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente)

/* Create types */
CREATE TYPE [dbo].[historia] FROM [int] NOT NULL
GO
CREATE TYPE [dbo].[medico] FROM [int] NOT NULL
GO
CREATE TYPE [dbo].[observacion] FROM [varchar](1000) NULL
GO
CREATE TYPE [dbo].[paciente] FROM [int] NOT NULL
GO
CREATE TYPE [dbo].[pais] FROM [char](3) NULL
GO
CREATE TYPE [dbo].[turno] FROM [int] NOT NULL
GO
