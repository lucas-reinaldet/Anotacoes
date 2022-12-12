CREATE TYPE myenum AS ENUM (
'value1',
'value2'
);

SELECT enum_range(NULL::myenum)
SELECT unnest(enum_range(NULL::myenum)) 