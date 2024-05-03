/* Error Codes

*/

/* Exercise 1:

Goal: Here we use users table to pull a list of user email addresses. Edit the query to pull email
addresses, but only for non-deleted users.

Code:*/

SELECT 
  id AS user_id
	,email_address
FROM dsv1069.users
WHERE deleted_at IS NULL;

--************************************************************************************************************

/*Exercise 2:

--Goal: Use the items table to count the number of items for sale in each category

Code:*/

SELECT 
  category
	,COUNT(id) AS item_count
FROM dsv1069.items
GROUP BY category
ORDER BY item_count DESC;

--************************************************************************************************************

/*Exercise 3:

--Goal: Select all of the columns from the result when you JOIN the users table to the orders
table

Code:*/

SELECT *
FROM dsv1069.orders
JOIN dsv1069.users ON orders.user_id = users.id;

--************************************************************************************************************

/*Exercise 4:

--Goal: Check out the query below. This is not the right way to count the number of viewed_item
events. Determine what is wrong and correct the error.

Code:*/

SELECT COUNT(DISTINCT event_id) AS events
FROM dsv1069.events
WHERE event_name = "view_item";

--************************************************************************************************************

/* Exercise 5:

--Goal:Compute the number of items in the items table which have been ordered. The query
below runs, but it isn’t right. Determine what is wrong and correct the error or start from scratch.

Code:*/

SELECT COUNT(DISTINCT orders.item_id) AS item_count
FROM dsv1069.orders;

--************************************************************************************************************

/* Exercise 6:

--Goal: For each user figure out IF a user has ordered something, and when their first purchase was.

Code:*/

SELECT users.id AS user_id
	,MIN(orders.paid_at) AS min_paid_at
FROM dsv1069.users
LEFT OUTER JOIN dsv1069.users.orders ON orders.user_id = user.id
ORDER BY user.id;

--************************************************************************************************************

/* Exercise 7:

--Goal: Figure out what percent of users have ever viewed the user profile page, but this query
isn’t right. Check to make sure the number of users adds up, and if not, fix the query.

Code:*/

SELECT (
		CASE 
			WHEN first_view IS NULL
				THEN FALSE
			ELSE TRUE
			END
		) AS has_viewed_profile_page
	,COUNT(user_id) AS users

FROM (
	SELECT users.id AS user_id
		,MIN(event_time) AS first_view
	
	FROM dsv1069.users
	LEFT OUTER JOIN dsv1069.events ON events.user_id = user.id
		AND events.event_name = "view_user_profile"
	
	GROUP BY users.id
	) first_profiles_views

GROUP BY (
	CASE 
		WHEN first_view IS NULL
			THEN FALSE
		ELSE TRUE
		END
	);
