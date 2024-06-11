/*

WSDA Music Sales Goal
They want as many as customers as possible to spend between $7.00 and $15.00
Sales Categories:
Baseline Purchase- Between $0.99 and $1.99
Low Purchase- Between $2.00 and $6.99
Target Purchase- Between $7.00 and $15.00
Top Performer- Above $15.00

-- WHERE clause used after FROM clause and before ORDER BY clause

*/


SELECT
  InvoiceDate,
  BillingAddress,
  BillingCity,
  total,
  CASE
  WHEN total < 2.00 THEN 'Baseline Purchase'
  WHEN total BETWEEN 2.00 AND 6.99 THEN 'Low Purchase'
  WHEN total BETWEEN 7.00 AND 15.00 THEN 'Target Purchase'
  ELSE 'Top Performer'
  END AS Purchase Type
FROM
  Invoice
WHERE 
  Purchase Type = 'Top Performer'
ORDER BY
   BillingCity
  