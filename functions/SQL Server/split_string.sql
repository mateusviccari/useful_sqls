/*
 * Function to split a string into a table of strings.
 */
CREATE FUNCTION [dbo].[split_string](
  @List       VARCHAR(MAX),
  @Delimiter  VARCHAR(255))
  RETURNS TABLE
AS
RETURN (SELECT
         Item =
           CONVERT(
             VARCHAR(max),
             Item)
        FROM
         (SELECT
           Item =
             x.i.value(
               '(./text())[1]',
               'varchar(max)')
          FROM
           (SELECT
             [XML] =
               CONVERT(
                 XML,
                 '<i>' +
                 REPLACE(
                   @List,
                   @Delimiter,
                   '</i><i>') +
                 '</i>').query('.')) AS a
           CROSS APPLY [XML].nodes('i') AS x(i)) AS y
        WHERE
         Item IS NOT NULL);