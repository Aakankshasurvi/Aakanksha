SELECT * FROM gdb0041.dim_customer
90002002
select s.get_fiscal_year(date), sum(s.sold_quantity*g.gross_price) as gross_sales
from fact_gross_price g join fact_sales_monthly s
on 
g.product_code=s.product_code and
g.fiscal_year=s.get_fiscal_year(s.date)
where customer_code=90002002
group by g.fiscal_year_year(date)