# now for net invoice sales we want gross price - gross price * discount value which we cannot determine so we would use cte
# 7) As mentioned above calculate the gross price total
WITH cte_1 as (Select s.date, 
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
limit 100000)

Select *,
(gross_price_total-gross_price_total*pre_invoice_discount_pct) as net_invoice_sales
 from  cte_1; 
 
 
# Though we can create a view which stores the select query in a database

Select 
	*,
    (gross_price_total-gross_price_total*pre_invoice_discount_pct) as net_invoice_sales
from sales_preinv_discount
where fiscal_year = 2021
limit 100000; 

# 8) Calculate for Post invoice Discount
Select 
		*,
		(1-pre_invoice_discount_pct)*gross_price_total as net_invoice_sales
	from sales_preinv_discount
	where fiscal_year = 2021
	limit 100000; 

# now join with fact_post_invoice_deduction

Select 
		*,
		(1-pre_invoice_discount_pct)*gross_price_total as net_invoice_sales,
        (po.discounts_pct+po.other_deductions_pct) as post_invoice_discount_pct
	from sales_preinv_discount s
    join fact_post_invoice_deductions po
    on 
		s.date = po.date and
		s.customer_code = po.customer_code and
        s.product_code = po.product_code
	where s.fiscal_year = 2021
	limit 100000; 

# now lets make view for post_inv_discount as well

Select 
	*, 
	(1-post_invoice_discount_pct) * net_invoice_sales as net_sales
from sales_postinv_discount
where fiscal_year = 2021
limit 100000;

# now even net_sales have a view so lets call it

Select * from net_sales where fiscal_year = 2021 limit 100000;


#9) Print the top markets and customers on the basis of net sales
#top market
Select 
	market,
	Round(sum(net_sales)/1000000,2) as net_sales_millions
from net_sales
where fiscal_year = 2021
group by market
order by net_sales_millions desc
limit 5;

# we can store this in stored procedure now


# top customer

Select 
	customer,
	Round(sum(net_sales)/1000000,2) as net_sales_millions
from net_sales s
join dim_customer c 
on
	s.customer_code = c.customer_code
where fiscal_year = 2021
group by customer
order by net_sales_millions desc
limit 5;

# lets make stored procedure for this as well

Select 
	product,
	Round(sum(net_sales)/1000000,2) as net_sales_millions
from net_sales s
where fiscal_year = 2021
group by product
order by net_sales_millions desc
limit 5;
