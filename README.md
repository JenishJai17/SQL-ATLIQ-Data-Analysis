# SQL_ATLIQ_Data_Analysis

Hey there, this is my SQL Data Analysis Project, where we did analysis of the data from the company name Atliq. The objective is to analyze the data and answer some key insights. By leveraging the power of SQL, we'll gain valuable insights into customers who were prominent for the company for different fiscal years. You can examine the dataset with SQL and help the store understand its business growth by answering simple questions.

## Details:

### Database_tables:

1) dim_customer
2) dim_product
3) fact_forecast_monthly
4) fact_freight_cost
5) fact_gross_price
6) fact_manufacturing_cost
7) fact_post_invoice_deductions
8) fact_pre_invoice_deductions
9) fact_sales_monthly

### Database and Tool Used:

* MySQL


### ATLIQ Question Set

1)	Find ATLIQ hardware sold by Croma in a particular fiscal year 2021 considering the date starts from September
2)	Find ATLIQ hardware sold by Croma in the last quarter of fiscal year 2021
3)	Generate an aggregate monthly gross sales report for Croma India Customers so that we can track how much sales this particular customer is generating for ATLIQ 
  The report should have the following fields.
  #!) Month
  #2) Total gross sales amount to Croma India in this month
5)	Generate a yearly report for Croma India where there are two columns
  #1) Fiscal Year
  #2) Total Gross Sales amount In that year from Croma
6)	Create a store procedure to determine the market badge based on the following.
  If the total sold quantity is> 5 million that market is considered as gold else it is silver.
  Input will be:
    #1) market
    #2) fiscal year
  Output will be
    #1) Market badge
7)	Calculate the value after applying the pre-invoice discount percentage
8)	Calculate the gross price total
9)	Calculate for Post invoice Discount
10)	Print the top markets and customers based on net sales
11)	Accumulate the data regarding the contribution of the top 10 companies for ATLIQ in the year 2021
12)	Create region-wise sales annual report for sales
13)	We have the forecast sales and monthly sales and analyze the prediction accuracy

Stored procedures made:
1)	get_market_badge
2)	get_monthly_gross_sales_for_customer
3)	get_product_by_net_sales
4)	get_top_n_customer_by_net_sales
5)	get_top_n_customer_by_net_sales_by_market
6)	get_top_n_markets_by_net_sales
7)	get_forecast_accuracy

Views made:
1)	gross_sales
2)	net_sales
3)	sales_postinv_discount
4)	sales_preinv_discount

Functions made:
1)	get_fiscal_quarter
2)	get_fiscal_year

### Key Note
Stored Procedure, Views and Functions are provided in a docx file

### Conclusion

#### Findings

- Identify sales of Atliq Hardware conducted by Croma Company

- Identified the total sales conducted based on the quantity sold and given a Market badge based on the output

- Identified the net sales

- Calculated all the prices after applying the pre-invoice discount, net-invoice-discount, and post-invoice-discount

- Identified the performance of all the companies having a tie-up with Atliq and their performance based on sales.

- Verified the forecast predictions and analyzed and created a table to compare their accuracy



#### Valuable Insights Gained
-	In the 2021 fiscal year the sold quantity for atliq products by Croma was at its highest on 2021-05-01 which was 1735 units.
-	The Highest Gross price total was witnessed as 1953k on 2021-12-01
-	In 2021 the best forecast accuracy was by Coolblue from Italy market with the accuracy being 47.23%.

### Reference

Dhaval Patel, CodeBasics
