USE [DwParcial]
GO
/****** Object:  StoredProcedure [dbo].[sp_FactVentaOrden]    Script Date: 27/04/2022 18:32:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_FactVentaOrden]
AS
BEGIN
INSERT INTO DwParcial.dbo.FactVentaOrden
(
	IdAtencion,EIdEmpleado,MIdMunicipio,UIdUsuario,FechaId,Total
)
SELECT DISTINCT
at.CodAtencion AS IdAtencion,
f.IdEmpleado AS EIdEmpleado,
f.IdMunicipio AS MIdMunicipio,
at.IdUsuario AS UIdUsuario,
YEAR(f.Fecha) * 10000 + MONTH(f.Fecha) * 100 + DAY(f.Fecha) as FechaId,
pg.Valor AS Total
FROM Salud6.dbo.Atenciones at 
INNER JOIN Salud6.dbo.Fac f
ON at.IdUsuario = f.IdUsuario
INNER JOIN Salud6.dbo.Pagos pg
ON at.IdPag = pg.IdPago
INNER JOIN Salud6.dbo.Usuario usr
ON at.IdUsuario = usr.Cedula
END