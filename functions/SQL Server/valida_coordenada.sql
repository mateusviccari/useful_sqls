/*
Function to validate a lat/lon coordinate.
*/
CREATE function [dbo].[valida_coordenada](@coordenada varchar(180))
returns char(1)
as
begin
	declare @quantosPontos int;
	declare @quantasVirgulas int;
	declare @lat double precision;
	declare @lon double precision;

	if @coordenada like '%- %' begin
		return 'N';
	end
	
	set @coordenada = replace(@coordenada, ' ', '');
	
	set @quantosPontos = LEN(@coordenada) - LEN(REPLACE(@coordenada, '.', ''));
	if (@quantosPontos <> 2) begin
		return 'N';
	end
	
	set @quantasVirgulas = LEN(@coordenada) - LEN(REPLACE(@coordenada, ',', ''));
	if (@quantasVirgulas <> 1) begin
		return 'N';
	end
	
	set @lat = dbo.get_lat(@coordenada)
	set @lon = dbo.get_lon(@coordenada)
	
	if (@lat is null or @lon is null or @lat = 0 or @lon = 0) begin
		return 'N'
	end
	
	if (@lat < -90 or @lat > 90 or @lon < -90 or @lon > 90) BEGIN
		return 'N'
	END 
	
	return 'S';
end