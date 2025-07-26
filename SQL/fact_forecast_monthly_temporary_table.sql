CREATE TEMPORARY TABLE forecast_accuracy_2020_2021 AS
SELECT 
  f.fiscal_year,
  f.customer_code,
  c.customer as cutomer_name,
  market,
  100 - (ABS(SUM(f.forecast_quantity) - SUM(s.sold_quantity)) / SUM(f.forecast_quantity)) * 100 AS forecast_accuracy_pct
FROM fact_forecast_monthly f
JOIN dim_customer c ON c.customer_code = f.customer_code
JOIN fact_sales_monthly s 
  ON s.product_code = f.product_code
 AND s.customer_code = f.customer_code
 AND s.date = f.date
WHERE f.fiscal_year IN (2020,2021)
GROUP BY f.customer_code, f.fiscal_year;
SELECT customer_code,cutomer_name,market,
  MAX(CASE WHEN fiscal_year = 2020 THEN forecast_accuracy_pct END) AS forecast_accuracy_2020,
  MAX(CASE WHEN fiscal_year = 2021 THEN forecast_accuracy_pct END) AS forecast_accuracy_2021
FROM forecast_accuracy_2020_2021
group by customer_code,cutomer_name,market
order by forecast_accuracy_2020,forecast_accuracy_2021
