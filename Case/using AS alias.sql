/*

Created by: Merve Gamze Cinar
Create Date: 11.06.2024
Description: This query displays all customers first, last name and email addresses

*/

SELECT
  FirstName AS [Customer First Name], 
  LastName AS "Customer Last Name", 
  Email AS EMAIL
FROM
  Customer
ORDER BY
  LastName DESC