/*
 12) We have the forecast sales and monthly sales and we want to analyze 
 our prediction accuracy
*/
Select count(*) from fact_forecast_monthly; #1885941

Select count(*) from fact_sales_monthly; #1425706

Create Table fact_act_est (
	Select 
		s.date as date,
		s.fiscal_year as fiscal_year, 
		s.product_code as producct_code, 
		s.customer_code as customer_code,
		s.sold_quantity as sold_quantity,
		f.forecast_quantity as forecast_quantity 
	from fact_sales_monthly s 
	left join fact_forecast_monthly f
	using (date, product_code, customer_code)
	UNION
	Select 
		f.date as date,
		f.fiscal_year as fiscal_year, 
		f.product_code as producct_code, 
		f.customer_code as customer_code,
		s.sold_quantity as sold_quantity,
		f.forecast_quantity as forecast_quantity 
	from fact_forecast_monthly f 
	left join fact_sales_monthly s
	using (date, product_code, customer_code)
)
