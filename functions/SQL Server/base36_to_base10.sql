/*
Function to convert a base-36 string to a base-10 number.
*/
CREATE FUNCTION dbo.base36_to_base10 (
    @Base36Value VARCHAR(36)
) 
RETURNS BIGINT
AS
BEGIN
    DECLARE @Base10Value BIGINT = 0;
    DECLARE @Length INT = LEN(@Base36Value);
    DECLARE @Index INT = 1;
    DECLARE @Char CHAR(1);
    DECLARE @Digit INT;

    WHILE @Index <= @Length
    BEGIN
        -- Get the character at the current position
        SET @Char = SUBSTRING(@Base36Value, @Index, 1);

        -- Convert the character to its numeric value
        SET @Digit = CASE 
            WHEN @Char BETWEEN '0' AND '9' THEN ASCII(@Char) - ASCII('0')
            WHEN @Char BETWEEN 'A' AND 'Z' THEN ASCII(@Char) - ASCII('A') + 10
            ELSE 0 -- You may add error handling for invalid characters here
        END;

        -- Update the Base10 value
        SET @Base10Value = @Base10Value * 36 + @Digit;

        -- Move to the next character
        SET @Index = @Index + 1;
    END;

    RETURN @Base10Value;
END;