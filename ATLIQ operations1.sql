# 1
#  Find atliq hardware sold by croma at a particular fiscal year 2021 considering date from sept
Select customer_code from dim_customer where customer like "%croma%";

Select * from fact_sales_monthly where customer_code = 90002002;

Select * from fact_sales_monthly 
	where customer_code = 90002002 and
	YEAR(date_add(date, Interval 4 month)) = 2021
order by date desc;

#or By function

Select * from fact_sales_monthly 
where 
	customer_code = 90002002 and
	get_fiscal_year(date) = 2021
order by date;



#2 
#ind atliq hardware sold by croma at the last quarter of fiscal year 2021
-- Q1 --> 9,10,11
-- Q2 --> 12,1,2
-- Q3 --> 3,4,5
-- Q4 --> 6,7,8
#Created stored procedure for getting the fiscal year and quarter info from date

Select * from fact_sales_monthly 
where 
	customer_code = 90002002 and
	get_fiscal_year(date) = 2021 and
    get_fiscal_quarter(date) = "Q4"
order by date
limit 100000;

Select s.date,s.product_code ,p.product, p.variant, s.sold_quantity 
from fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
where 
	customer_code = 90002002 and
	get_fiscal_year(date) = 2021 and
    get_fiscal_quarter(date) = "Q4"
order by date
limit 100000;

Select 
	s.date, 
    s.product_code, 
    p.product, 
    p.variant, 
    s.sold_quantity, 
    g.gross_price, 
    g.gross_price*s.sold_quantity as gross_price_total 
from fact_sales_monthly s
join dim_product p
on 
	p.product_code = s.product_code
join fact_gross_price g
on 
	g.product_code = s.product_code AND 
    g.fiscal_year = get_fiscal_year(s.date)
where 
	customer_code = 90002002 and
	get_fiscal_year(date) = 2021 and
    get_fiscal_quarter(date) = "Q4"
order by date
limit 100000;



#3
# Generate an aggregate monthly gross sales report for Croma India Customer so that we can track how much sales this particular customer is generating for Atliq 
# The report should have the following fields.
#!) Month
#2) Total gross sales amount to croma india in this month


select  
	s.date,
	SUM(g.gross_price*s.sold_quantity) as gross_price_total
from fact_sales_monthly s 
join fact_gross_price g
on 
	g.product_code = s.product_code
and g.fiscal_year = get_fiscal_year(s.date)
where 
	customer_code = 90002002 
group by s.date
Order by s.date asc;

/* 4
Generate a yearly report for Croma India where there are two columns
1. Fiscal Year
2. Total Gross Sales amount In that year from Croma
*/

	Select 
		g.fiscal_year,
		SUM(g.gross_price*s.sold_quantity) as Total_Year_Sales
	from fact_sales_monthly s
	join fact_gross_price g
	on 
		s.product_code = g.product_code and
		g.fiscal_year = get_fiscal_year(s.date)
	where 
		customer_code = 90002002
	group by g.fiscal_year
	order by g.fiscal_year asc;

# alternative

	select
		get_fiscal_year(date) as fiscal_year,
		sum(round(sold_quantity*g.gross_price,2)) as yearly_sales
	from fact_sales_monthly s
	join fact_gross_price g
	on 
	    g.fiscal_year=get_fiscal_year(s.date) and
	    g.product_code=s.product_code
	where
	    customer_code=90002002
	group by get_fiscal_year(date)
	order by fiscal_year;
    
    SELECT * from dim_customer where customer like "%amazon%" and market = "India";
    
    /*5  Create a store procedure that can determine the market badge based on the following.
    If total sold quantity > 5 million that market is considered as gold else it is silver.
    !Input will be:
    1) market
	2) fiscal year
    Output will be
    1) market badge
    */
    
    Select Sum(s.sold_quantity) from fact_sales_monthly s
    join dim_customer c
    on s.customer_code = c.customer_code
    where get_fiscal_year(s.date) = 2021 and
    c.market = "indonesia";
    
    # Check the stored procedures which we created in this operation 1 like get_market_badge and get_monthly_gross_sales_for_customers
	# Also the functions like get_fiscal_quarter and get_fiscal_year too