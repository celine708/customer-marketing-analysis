USE marketing_project;

-- Q1: Customers and total spend by income group
SELECT
    CASE
        WHEN c.income < 40000 THEN 'Low'
        WHEN c.income < 80000 THEN 'Medium'
        ELSE 'High'
    END AS income_group,
    COUNT(*) AS customers,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM customers), 1) AS pct_of_customers,
    SUM(p.mnt_wines + p.mnt_fruits + p.mnt_meat + p.mnt_fish + p.mnt_sweets + p.mnt_gold) AS total_spend
FROM customers c
JOIN purchases p ON p.customer_id = c.customer_id
GROUP BY income_group
ORDER BY total_spend DESC;

-- Q2: Average spend by number of children
SELECT
    c.kidhome + c.teenhome AS total_children,
    COUNT(*) AS customers,
    ROUND(AVG(p.mnt_wines + p.mnt_fruits + p.mnt_meat + p.mnt_fish + p.mnt_sweets + p.mnt_gold), 1) AS avg_spend
FROM customers c
JOIN purchases p ON p.customer_id = c.customer_id
GROUP BY total_children
ORDER BY total_children;

-- Q3: Acceptance rate for each campaign
SELECT
    cm.campaign_name,
    SUM(r.accepted) AS accepted,
    COUNT(*) AS customers_contacted,
    ROUND(SUM(r.accepted) * 100 / COUNT(*), 1) AS acceptance_rate_pct
FROM campaign_responses r
JOIN campaigns cm ON cm.campaign_id = r.campaign_id
GROUP BY cm.campaign_id, cm.campaign_name
ORDER BY cm.campaign_id;

-- Q4: Share of total spend by product category
SELECT category, total_spend,
       ROUND(total_spend * 100 / SUM(total_spend) OVER (), 1) AS pct_of_spend
FROM (
    SELECT 'Wine' AS category, SUM(mnt_wines) AS total_spend FROM purchases
    UNION ALL SELECT 'Meat', SUM(mnt_meat) FROM purchases
    UNION ALL SELECT 'Gold', SUM(mnt_gold) FROM purchases
    UNION ALL SELECT 'Fish', SUM(mnt_fish) FROM purchases
    UNION ALL SELECT 'Sweets', SUM(mnt_sweets) FROM purchases
    UNION ALL SELECT 'Fruits', SUM(mnt_fruits) FROM purchases
) t
ORDER BY total_spend DESC;

-- Q5: Top 10 customers by total spend
SELECT
    c.customer_id,
    c.income,
    p.mnt_wines + p.mnt_fruits + p.mnt_meat + p.mnt_fish + p.mnt_sweets + p.mnt_gold AS total_spend
FROM customers c
JOIN purchases p ON p.customer_id = c.customer_id
ORDER BY total_spend DESC
LIMIT 10;

-- Q6: Last-campaign acceptance rate by relationship status
SELECT
    c.relationship_status,
    COUNT(*) AS customers,
    SUM(r.accepted) AS accepted,
    ROUND(SUM(r.accepted) * 100 / COUNT(*), 1) AS acceptance_rate_pct
FROM customers c
JOIN campaign_responses r ON r.customer_id = c.customer_id
WHERE r.campaign_id = 6
GROUP BY c.relationship_status
ORDER BY acceptance_rate_pct DESC;