WITH cte1 AS (
  SELECT 
    c.market,
    c.region,
    round(sum(f.sold_quantity * g.gross_price) / 1000000,2) AS gross_sales_mln
  FROM fact_sales_monthly f 
  JOIN dim_customer c 
    ON f.customer_code = c.customer_code
  JOIN fact_gross_price g 
    ON f.product_code = g.product_code
	AND YEAR(DATE_ADD(f.date, INTERVAL 4 MONTH)) = g.fiscal_year
	WHERE g.fiscal_year = 2021
  GROUP BY c.market, c.region,g.fiscal_year
)
, ranked AS (
  SELECT *,
    RANK() OVER (PARTITION BY region ORDER BY gross_sales_mln DESC) AS rnk
  FROM cte1
)
SELECT *
FROM ranked
WHERE rnk <= 2;






