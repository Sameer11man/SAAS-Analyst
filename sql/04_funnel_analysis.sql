-- 1. Funnel Counts 

SELECT 
  e.source,
  c.segment,
  COUNT(DISTINCT CASE WHEN e.event_type='signup' THEN c.customer_id END) AS signup,
  COUNT(DISTINCT CASE WHEN e.event_type='trial_start' THEN c.customer_id END) AS trial,
  COUNT(DISTINCT CASE WHEN e.event_type='activated' THEN c.customer_id END) AS activated,
  COUNT(DISTINCT CASE WHEN e.event_type='churned' THEN c.customer_id END) AS churned
FROM customers c
LEFT JOIN events e ON c.customer_id = e.customer_id
GROUP BY 1,2;


-- 2. Conversion Rates

WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'signup' THEN customer_id END) AS signup,
        COUNT(DISTINCT CASE WHEN event_type = 'trial_start' THEN customer_id END) AS trial,
        COUNT(DISTINCT CASE WHEN event_type = 'activated' THEN customer_id END) AS activated,
        COUNT(DISTINCT CASE WHEN event_type = 'churned' THEN customer_id END) AS churned
    FROM events
)
SELECT
    signup,
    trial,
    activated,
    churned,
    ROUND(trial/signup * 100, 2) AS signup_to_trial_pct,
    ROUND(activated/trial * 100, 2) AS trial_to_activated_pct,
    ROUND(churned/activated * 100, 2) AS activated_to_churned_pct
FROM funnel;

-- Drop of analysis
WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'signup' THEN customer_id END) AS signup,
        COUNT(DISTINCT CASE WHEN event_type = 'trial_start' THEN customer_id END) AS trial,
        COUNT(DISTINCT CASE WHEN event_type = 'activated' THEN customer_id END) AS activated,
        COUNT(DISTINCT CASE WHEN event_type = 'churned' THEN customer_id END) AS churned
    FROM events
)
SELECT
  signup - trial AS signup_to_trial_dropoff,
  trial - activated AS trial_to_activated_dropoff,
  activated - churned AS activated_to_churned_dropoff
FROM funnel;

-- funnel performance by source or segment 

SELECT e.source, c.segment,
       COUNT(DISTINCT CASE WHEN event_type='activated' THEN c.customer_id END) /
       COUNT(DISTINCT c.customer_id) * 100 AS signup_to_activated_conversion
FROM customers c
LEFT JOIN events e ON c.customer_id = e.customer_id
GROUP BY 1,2;

