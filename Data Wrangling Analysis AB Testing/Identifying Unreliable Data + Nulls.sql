/* Identifying Unreliable Data + Nulls

*/

-- *************************************************************************************************************************************************

/* Exercise 1: Using any methods you like determine if you can you trust this events table.

Code: */

SELECT DATE (event_time) AS DATE
	,COUNT(*)
FROM dsv1069.events_201701
GROUP BY DATE (event_time);

-- *************************************************************************************************************************************************

/* Exercise 2: Using any methods you like, determine if you can you trust this events table. (HINT: When did
we start recording events on mobile)

Code: */

SELECT DATE (event_time) AS DATE
  ,event_name
	,COUNT(*)
FROM dsv1069.events_201701
GROUP BY DATE (event_time);

-- *************************************************************************************************************************************************

/* Exercise 3: Imagine that you need to count item views by day. You found this table
item_views_by_category_temp - should you use it to answer your questiuon?

Code: */

SELECT COUNT(DISTINCT event_id) AS event_count
FROM dsv1069.events
WHERE event_name = 'view_item';

-- *************************************************************************************************************************************************

/* Exercise 4: Using any methods you like, decide if this table is ready to be used as a source of
truth. 

Code: */

SELECT DATE (event_time) AS DATE
	,platform
	,COUNT(user_id) AS users
FROM dsv1069.events
GROUP BY DATE
	,platform;

-- *************************************************************************************************************************************************

/* Exercise 5: Is this the right way to join orders to users? Is this the right way this join.


Code: */

SELECT COUNT(*)
FROM dsv1069.orders
JOIN dsv1069.users ON orders.user_id = COALESCE(users.parent_user_id, user_id)
