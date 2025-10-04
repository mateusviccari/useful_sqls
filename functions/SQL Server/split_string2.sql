/*
 * Function to split a string into a table of strings.
 * Esta implementação é mais eficiente que a dbo.split_string mas só permite strings de até 2^16 (65536) caracteres.
 * Pode criar mais uma potência abaixo se necessário.
 */
CREATE   FUNCTION dbo.split_string2
(
    @str       VARCHAR(MAX),
    @delimiter VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    WITH
    -- Tally (numbers) generator
    E1(N) AS (SELECT 1 UNION ALL SELECT 1),
    E2(N) AS (SELECT 1 FROM E1 a CROSS JOIN E1 b),    
    E4(N) AS (SELECT 1 FROM E2 a CROSS JOIN E2 b),    
    E8(N) AS (SELECT 1 FROM E4 a CROSS JOIN E4 b),    
    E16(N) AS (SELECT 1 FROM E8 a CROSS JOIN E8 b),   
    Tally(N) AS 
    (
        SELECT TOP (LEN(@str)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
        FROM E16
    ),
    -- Find all delimiter start positions
    Delims AS
    (
        SELECT N AS Pos
        FROM Tally
        WHERE SUBSTRING(@str, N, LEN(@delimiter)) = @delimiter
        UNION ALL
        SELECT LEN(@str) + 1 -- sentinel
    ),
    -- Extract pieces between delimiters
    Pieces AS
    (
        SELECT 
            ROW_NUMBER() OVER (ORDER BY Pos) AS pos,
            LTRIM(RTRIM(
                SUBSTRING(
                    @str,
                    ISNULL(LAG(Pos) OVER (ORDER BY Pos), 0) + CASE WHEN LAG(Pos) OVER (ORDER BY Pos) IS NULL THEN 1 ELSE LEN(@delimiter) END,
                    Pos - (ISNULL(LAG(Pos) OVER (ORDER BY Pos), 0) + CASE WHEN LAG(Pos) OVER (ORDER BY Pos) IS NULL THEN 1 ELSE LEN(@delimiter) END)
                )
            )) AS item
        FROM Delims
    )
    SELECT item, pos
    FROM Pieces
);