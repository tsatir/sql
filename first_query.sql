SELECT	column_name, data_type
FROM	information_schema.columns
WHERE	table_name = 'film' ;

SELECT	*
FROM	film
LIMIT 	100;