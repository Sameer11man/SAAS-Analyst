-- Identify Data Quality Issues
-- Check duplicate customers
select customer_id, COUNT(*)
from customers
group by customer_id
HAVING COUNT(*) > 1;

-- Check missing values
SELECT *
FROM customers
WHERE signup_date is null
   or segment is null;


-- Check conflicting subscription events
SELECT customer_id, count(distinct status)
from subscriptions
GROUP BY customer_id
HAVING COUNT(DISTINCT status) > 1;


-- checking active subscription with end date
select * from subscriptions where status = 'active' and end_date is not null


--  Handle Data Issues

UPDATE customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
SET c.signup_date = s.start_date
WHERE c.signup_date IS NULL;


UPDATE customers
SET segment = 'Unknown'
WHERE segment IS NULL;
