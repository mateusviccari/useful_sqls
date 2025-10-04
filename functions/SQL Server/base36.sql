/*
Function to convert a number to a base-36 string.
*/
create FUNCTION dbo.base36
(
    @number BIGINT
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @characters VARCHAR(36) = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    DECLARE @base INT = 36
    DECLARE @result VARCHAR(50) = ''
    DECLARE @currentNumber BIGINT = @number

    -- Convert the number to a base-36 string
    WHILE @currentNumber > 0
    BEGIN
        SET @result = SUBSTRING(@characters, (@currentNumber % @base) + 1, 1) + @result
        SET @currentNumber = @currentNumber / @base
    END

    -- If the number is zero, return "0"
    IF @result = ''
        SET @result = '0'

    RETURN @result
END