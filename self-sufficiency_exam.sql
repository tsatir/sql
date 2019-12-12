--1

SELECT	column_name, data_type 
FROM 	information_schema.columns
WHERE 	table_name = 'naep';

--2 

SELECT	*
FROM	naep
LIMIT	50;

--3
SELECT	state,
		COUNT(*) AS count_id,
		AVG(avg_math_4_score) AS avg_math_4_score,
		MIN(avg_math_4_score) AS min_avg_math_4_score,
		MAX(avg_math_4_score) AS MAX_avg_math_4_score
FROM	naep
GROUP BY
		state
ORDER BY
		state;
		
		
---4

SELECT	*
FROM
		(
		SELECT	state,
				COUNT(*) AS count_id,
				AVG(avg_math_4_score) AS avg_math_4_score,
				MIN(avg_math_4_score) AS min_avg_math_4_score,
				MAX(avg_math_4_score) AS max_avg_math_4_score
		FROM	naep
		GROUP BY
				state
		ORDER BY
				state
		) x
WHERE	max_avg_math_4_score-min_avg_math_4_score>30;	

--5
SELECT	state AS bottom_10_states
FROM	naep
WHERE	year = 2000
ORDER BY
		avg_math_4_score
LIMIT 10;	


--6 

SELECT	state, 
		ROUND(AVG(avg_math_4_score),2) AS avg_math_4_score_bystate
FROM	naep
WHERE	year = 2000
GROUP BY
		state;
		
--7 

SELECT	DISTINCT state AS below_average_states_y2000
FROM	naep
WHERE	avg_math_4_score < ALL
	(
	SELECT	AVG(avg_math_4_score) AS avg_2000_math4_score
	FROM	naep
	WHERE	year = 2000
	) ;
	
--8 

SELECT	state AS scores_missing_y2000
FROM	naep
WHERE	year = 2000
AND		avg_math_4_score is NULL;

--9

/*
Write a query that returns for the year 2000 the state, avg_math_4_score, and total_expenditure
from the naep table left outer joined with the finance table, using id as the key and ordered 
by total_expenditure greatest to least. Be sure to round avg_math_4_score to the nearest 2 decimal 
places, and then filter out NULL avg_math_4_scores in order to see any correlation more clearly.
*/

SELECT	naep.state, 
		ROUND(naep.avg_math_4_score,2) AS avg_math_4_score,
		total_expenditure
FROM	naep LEFT OUTER JOIN finance 
ON		naep.id = finance.id
WHERE	naep.year = 2000
AND		naep.avg_math_4_score IS NOT NULL
ORDER BY
		total_expenditure DESC




