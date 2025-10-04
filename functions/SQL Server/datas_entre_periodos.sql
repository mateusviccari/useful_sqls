/*
Function to return all the dates between two dates.
*/
create function dbo.datas_entre_periodo(@data_inicial date, @data_final date)
returns @retorno table(
	data_calculada date
)
begin
declare @intervalo date = @data_inicial;

while @intervalo <= @data_final begin
	insert into @retorno(data_calculada) select @intervalo;

	set @intervalo = dateadd(day, 1, @intervalo);
end

return;
end