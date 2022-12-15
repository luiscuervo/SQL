/******** Create a table and set primary key ****************/

CREATE TABLE Paciente(
	idPaciente int NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NULL,
	fnacimiento date NULL,
	domicilio varchar(50) NULL,
	idPais char(3) NULL,
	telefono varchar(20) NULL,
	email varchar(30) NULL,
	observation varchar(1000) NULL,
	fechaAlta datetime NOT NULL,
 CONSTRAINT PK_idPaciente PRIMARY KEY (idPaciente)
)

CREATE TABLE dbo.Historia(
	idHistoria int IDENTITY(1,1) NOT NULL,
	fechaHistoria datetime NOT NULL,
	observacion varchar(2000) NULL,
	fechaAlta datetime NULL,
 CONSTRAINT PK_PacienteHistoria_1 PRIMARY KEY (idHistoria)



/* Create many2many relation table, with 3 clustered primary key */

CREATE TABLE HistoriaPaciente(
	idHistoria int NOT NULL,
	idPaciente int NOT NULL,
	idMedico int NOT NULL,
 CONSTRAINT PK_HistoriaPaciente PRIMARY KEY CLUSTERED 
(
	idHistoria ASC,
	idPaciente ASC,
	idMedico ASC
)



/* Update table to set foreign key */

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

