#6)	Calculate the value after applying the pre invoice discount percentage
Select s.date, 
s.product_code, 
p.product, p.variant, s.sold_quantity, 
g.gross_price, 
g.gross_price*s.sold_quantity as gross_price_total,
pre.pre_invoice_discount_pct 
from fact_sales_monthly s
join dim_product p
on 
	p.product_code = s.product_code
join fact_gross_price g
on  
    g.product_code = s.product_code AND 
	g.fiscal_year = get_fiscal_year(s.date)
join fact_pre_invoice_deductions pre
on 
	pre.customer_code = s.customer_code AND 
	pre.fiscal_year = get_fiscal_year(s.date)

where 
	get_fiscal_year(date) = 2021 
order by date
limit 100000;

# now using look up table we created using date_seed csv file in dim_date

Select s.date, 
s.product_code, 
p.product, p.variant, s.sold_quantity, 
g.gross_price, 
g.gross_price*s.sold_quantity as gross_price_total,
pre.pre_invoice_discount_pct 
from fact_sales_monthly s
join dim_product p
on 
	p.product_code = s.product_code
join dim_date dt
on
	dt.calender_date = s.date
join fact_gross_price g
on  
    g.product_code = s.product_code AND 
	g.fiscal_year = dt.fiscal_year
join fact_pre_invoice_deductions pre
on 
	pre.customer_code = s.customer_code AND 
	pre.fiscal_year = dt.fiscal_year

where 
	dt.fiscal_year = 2021 
order by date
limit 100000;


# OR we could add the fiscal year in the fact_monthly_sales now we added the fiscal year

Select s.date, 
s.product_code, 
p.product, p.variant, s.sold_quantity, 
g.gross_price, 
g.gross_price*s.sold_quantity as gross_price_total,
pre.pre_invoice_discount_pct 
from fact_sales_monthly s
join dim_product p
on 
	p.product_code = s.product_code
join fact_gross_price g
on  
    g.product_code = s.product_code AND 
	g.fiscal_year = s.fiscal_year
join fact_pre_invoice_deductions pre
on 
	pre.customer_code = s.customer_code AND 
	pre.fiscal_year = s.fiscal_year

where 
	s.fiscal_year = 2021 
order by date
limit 100000;
