/*

	LOAD GOLD DATA INTO GOLD LAYER
	This script creates a procedure called 'load_gold' that load data from the 'silver' layer into the 'gold' layer.
	The process is done after some calculations to increase the value of the data on business decisions.
*/

use retail_data_warehouse;

go

create or alter procedure load_gold as

begin

print 'Loading data into sales table';

truncate table gold.fact_sales;

insert into gold.fact_sales (
	sales_id,
	order_id,
	customer_id,
	product_id,
	order_date_id,
	quantity_sold,
	cost_amount,
	sales_amount,
	profit_amount
) 
	select
	sls_sales_id,
	sls_order_id,
	sls_customer_id,
	sls_product_id,
	sls_order_date_id,
	sls_quantity_sold,
	s.sls_quantity_sold * p.pdc_unit_cost as cost_amount,
	s.sls_quantity_sold * p.pdc_unit_price as sales_amount,
	(p.pdc_unit_price - p.pdc_unit_cost) * s.sls_quantity_sold as profit_amount
	from silver.sales s
	inner join silver.products p
	on s.sls_product_id = p.pdc_product_id;

print '=================================================';

print 'Loading data into products table';

truncate table gold.dim_products;

insert into gold.dim_products (
	product_id,
	product_name,
	category,
	subcategory,
	brand,
	unit_cost,
	unit_price,
	launch_date
)
	select
	pdc_product_id,
	pdc_product_name,
	pdc_category,
	pdc_subcategory,
	pdc_brand,
	pdc_unit_cost,
	pdc_unit_price,
	pdc_launch_date
	from silver.products;

print '=================================================';

print 'Loading data into customer table';

truncate table gold.dim_customers;

insert into gold.dim_customers (
	customer_id,
	customer_name,
	gender,
	birth_date,
	city,
	state,
	registration_date
)
	select
	cst_customer_id,
	cst_customer_name,
	cst_gender,
	cst_birth_date,
	cst_city,
	cst_state,
	cst_registration_date
	from silver.customers;

print '=================================================';

print 'Loading data into date table';

truncate table gold.dim_dates;

insert into gold.dim_dates (
	date_id,
	full_date,
	day_number,
	day_name,
	month_number,
	month_name,
	quarter,
	year,
	weekend_flag
)
	select
	dat_date_id,
	dat_full_date,
	dat_day_number,
	dat_day_name,
	dat_month_number,
	dat_month_name,
	dat_quarter,
	dat_year,
	dat_weekend_flag
	from silver.dates;

end
