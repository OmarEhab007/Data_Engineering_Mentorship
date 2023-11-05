/*
Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.

Table: sf_transactions
*/

SELECT DATE_FORMAT(created_at, '%Y-%m') AS month,
ROUND(100*(SUM(value) - LAG(SUM(value), 1) OVER (ORDER BY DATE_FORMAT(created_at, '%Y-%m'))) / LAG(SUM(value), 1) OVER (ORDER BY DATE_FORMAT(created_at, '%Y-%m')), 2) AS pct_change
FROM sf_transactions
GROUP BY DATE_FORMAT(created_at, '%Y-%m')
HAVING COUNT(*) > 1
ORDER BY month;
