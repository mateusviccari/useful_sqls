/*
Function to get the latitude from a coordinate string.
*/
CREATE function [dbo].[get_lat](@coordenada varchar(180))
returns double precision
as begin
	set @coordenada = REPLACE(@coordenada, char(9), '')
	return try_cast(SUBSTRING(@coordenada, 0, charindex(',', @coordenada)) as double precision);
end;

/*
Function to get the longitude from a coordinate string.
*/
CREATE function [dbo].[get_lon](@coordenada varchar(180))
returns double precision
as begin
	set @coordenada = REPLACE(@coordenada, char(9), '')
	return try_cast(SUBSTRING(@coordenada, charindex(',', @coordenada)+1, len(@coordenada)) as double precision);
end;