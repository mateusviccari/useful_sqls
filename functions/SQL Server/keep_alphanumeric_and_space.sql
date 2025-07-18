/*
Function to strip all characters, except alphanumerics and spaces, from a string.
*/
CREATE FUNCTION dbo.KeepAlphanumericAndSpace
(
    @input VARCHAR(max)
)
RETURNS VARCHAR(max)
AS
BEGIN
    DECLARE @output VARCHAR(max) = ''
    DECLARE @index INT = 1
    DECLARE @char CHAR(1)

    WHILE @index <= LEN(@input)
    BEGIN
        SET @char = SUBSTRING(@input, @index, 1)
        IF @char LIKE '[A-Za-z0-9 ]'
            SET @output = @output + @char
        SET @index = @index + 1
    END

    RETURN @output
END
