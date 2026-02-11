-- 1. Monthly MRR (Monthly Recurring Revenue)
SELECT DATE_FORMAT(start_date,'%Y-%m') as month, SUM(monthly_price) MRR
FROM subscriptions
WHERE status='Active'
GROUP BY 1


-- 2. ARR (Annual Recurring Revenue)
select SUM(monthly_price) * 12 AS ARR
FROM subscriptions
WHERE status = 'Active';


-- 3. Customer (logo) churn rate
SELECT DATE_FORMAT(end_date,'%Y-%m') month, COUNT(DISTINCT customer_id) churned
FROM subscriptions
WHERE end_date IS NOT NULL
GROUP BY 1;


-- 4. Revenue churn rate
SELECT DATE_FORMAT(end_date,'%Y-%m') month, SUM(monthly_price) churned_mrr
FROM subscriptions
WHERE end_date IS NOT NULL
GROUP BY 1;


-- 5. Average Revenue per Customer (ARPC)

SELECT SUM(monthly_price)/COUNT(DISTINCT customer_id) ARPC
FROM subscriptions WHERE status='Active';






