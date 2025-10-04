/*
 * Function to strip all characters, except numerics, from a string.
 */
CREATE FUNCTION [dbo].[StripNonNumerics]
(
  @Temp varchar(max)
)
RETURNS varchar(max)
AS
Begin

    Declare @KeepValues as varchar(max)
    Set @KeepValues = '%[^0-9]%'
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')

    Return @Temp
End