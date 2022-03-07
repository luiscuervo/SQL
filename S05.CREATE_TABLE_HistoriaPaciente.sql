
/****** Object:  Table [dbo].[HistoriaPaciente]    Script Date: 14/02/2019 00:03:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HistoriaPaciente](
	[idHistoria] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idMedico] [int] NOT NULL,
 CONSTRAINT [PK_HistoriaPaciente] PRIMARY KEY CLUSTERED 		/* We want all three values to be primary keys (Cluster) */
(
	[idHistoria] ASC,
	[idPaciente] ASC,
	[idMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/* Set foreign key */

ALTER TABLE HistoriaPaciente
ADD FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente)
