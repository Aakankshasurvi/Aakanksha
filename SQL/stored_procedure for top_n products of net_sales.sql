CREATE PROCEDURE `top_n_products` ()
in_fiscal_year year,
in_top_n_products INT
BEGIN
select p.product,round(sum(net_sales)/1000000,2) as net_sales_mln
from gdb0041.net_sales s join dim_product p on
s.product_code=p.product_code
where fiscal_year=in_fiscal_year
group by p.product
order by net_sales desc
limit in_top_n_products
END