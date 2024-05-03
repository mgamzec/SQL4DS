/* Flexible Data Formats


-- *************************************************************************************************************************************************

/* Exercise 1:

Goal: Write a query to format the view_item event into a table with the appropriate columns.

Code:*/

SELECT event_id
	,event_time
	,user_id
	,platform
	,parameter_name
	,parameter_value
FROM dsv1069.events
WHERE event_name = 'view_item'
ORDER BY event_id;
  
-- *************************************************************************************************************************************************

/* Exercise 2:

Goal: Write a query to format the view_item event into a table with the appropriate columns
(This replicates what we had in the slides, but it is missing a column).

Code:*/

SELECT event_id
	,event_time
	,user_id
	,platform
	,(
		CASE 
			WHEN paramater_name = item_id
				THEN CAST(paramater_value AS INT)
			ELSE NULL
			END
		) AS time_id
	,(
		CASE 
			WHEN paramater_name = "referrer"
				THEN paramater_value
			ELSE NULL
			END
		) AS referrer
FROM dsv1069.events
WHERE event_name = "view_time"
GROUP BY event_id
	,event_time
	,user_id
	,platform;

-- *************************************************************************************************************************************************

/* Exercise 3:

Goal: Use the result from the previous exercise, but make sure

Code:*/

SELECT event_id
	,event_time
	,user_id
	,platform
	,MAX(CASE 
			WHEN parameter_name = 'item_id'
				THEN CAST(parameter_value AS INT)
			ELSE NULL
			END) AS item_id
	,MAX(CASE 
			WHEN parameter_name = 'referrer'
				THEN parameter_value
			ELSE NULL
			END) AS referrer
FROM dsv1069.events
WHERE event_name = 'view_item'
GROUP BY event_id
	,event_time
	,user_id
	,platform
ORDER BY event_id;

-- *************************************************************************************************************************************************
