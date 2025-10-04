/*
Function to calculate the distance between two points in kilometers.
Requires the function valida_coordenada and get_lat/get_lon from this same repository
*/
CREATE FUNCTION [dbo].[distancia_km_entre_pontos](@coordenadas_inicio varchar(180), @coordenadas_fim varchar(180))  
RETURNS double precision
AS
BEGIN
	declare @distancia double precision;
	declare @lat_inicio varchar(100);
	declare @lon_inicio varchar(100);
	declare @lat_fim varchar(100);
	declare @lon_fim varchar(100);
	
	if (dbo.valida_coordenada(@coordenadas_inicio) = 'N' or dbo.valida_coordenada(@coordenadas_fim) = 'N') BEGIN
		set @distancia = 99999999;
		return @distancia;
	END
	
	set @lat_inicio = dbo.get_lat(@coordenadas_inicio);
	set @lon_inicio = dbo.get_lon(@coordenadas_inicio);
	set @lat_fim = dbo.get_lat(@coordenadas_fim);
	set @lon_fim = dbo.get_lon(@coordenadas_fim);
	
	if (@lat_inicio is null or @lon_inicio is null or @lat_fim is null or @lon_fim is null) begin
		return null;
	end
	
	set @distancia = geography::Point(@lat_inicio, @lon_inicio, 4326).STDistance(geography::Point(@lat_fim, @lon_fim, 4326));
	set @distancia = @distancia / 1000;
	return @distancia;
END;