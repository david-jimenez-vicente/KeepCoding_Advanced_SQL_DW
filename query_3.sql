CREATE OR REPLACE FUNCTION keepcoding.clean_integer(dato INT64)
    RETURNS INT64 AS
    (IFNULL (dato, -999999));
