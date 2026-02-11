
 --  Optional Analysis – Advanced SaaS Insights


-- 1. Customer Lifetime Value 
SELECT 
    c.segment,
    SUM(s.monthly_price * TIMESTAMPDIFF(MONTH, s.start_date, IFNULL(s.end_date, CURDATE()))) 
    / COUNT(DISTINCT c.customer_id) AS avg_LTV
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY c.segment;

-- 2. Retention Cohort (by Signup Month) 
SELECT 
    DATE_FORMAT(c.signup_date, '%Y-%m') AS cohort_month,
    COUNT(DISTINCT s.customer_id) AS retained_customers
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
WHERE s.status = 'active'
GROUP BY 1
ORDER BY 1;

-- 3. Revenue by Segment 
SELECT 
    c.segment,
    SUM(s.monthly_price) AS total_MRR
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
WHERE s.status = 'active'
GROUP BY c.segment;

-- 4. Average Tenure (Months) 
SELECT 
    AVG(TIMESTAMPDIFF(MONTH, start_date, IFNULL(end_date, CURDATE()))) AS avg_customer_tenure
FROM subscriptions;

-- 5. Reactivation Analysis 
SELECT 
    customer_id,
    COUNT(*) AS number_of_subscriptions
FROM subscriptions
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 6. Churn by Segment 
SELECT 
    c.segment,
    COUNT(DISTINCT s.customer_id) AS churned_customers
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
WHERE s.end_date IS NOT NULL
GROUP BY c.segment;

-- 7. Revenue Concentration (Top 20% Customers) 
WITH ranked_customers AS (
    SELECT 
        customer_id,
        SUM(monthly_price) AS total_revenue,
        NTILE(5) OVER (ORDER BY SUM(monthly_price) DESC) AS revenue_bucket
    FROM subscriptions
    GROUP BY customer_id
)
SELECT 
    revenue_bucket,
    SUM(total_revenue) AS bucket_revenue
FROM ranked_customers
GROUP BY revenue_bucket
ORDER BY revenue_bucket;
