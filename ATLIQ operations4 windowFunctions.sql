
#10) Accumulatethe data of the contribution of top 10 companies for ATLIQ in the year 2021
# copy pasting the same code from get_top_n_customer_by_net_sales
with cte1 as (
	Select 
		customer,
		Round(sum(net_sales)/1000000,2) as net_sales_millions
	from net_sales s
	join dim_customer c 
	on
		s.customer_code = c.customer_code
	where fiscal_year = 2021
	group by customer
)
Select 
	*,
	net_sales_millions*100/sum(net_sales_millions) over() as percent_contribution 
from cte1 
order by net_sales_millions desc;

# 11) create region wise sales annual report for sales

with cte2 as (
Select 
	c.region,
    customer,
    Round(sum(net_sales)/1000000,2) as net_sales_millions
    from net_sales s
    join dim_customer c
	on
		s.customer_code = c.customer_code
	where fiscal_year = 2021
    group by c.region
) 
Select *,
net_sales_millions*100/sum(net_sales_millions) over(partition by region) as percent_contribution 
 from cte2 
 order by net_sales_millions desc;
