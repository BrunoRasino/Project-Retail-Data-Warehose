/* 
	LOAD SILVER DATA INTO SILVER LAYER
	This script creates a procedure called 'load_silver' that loads data from the 'bronze' layer into the 'silver' layer.
	The process is done after some transformations and data cleaning to ensure the quality of the data in the 'silver' layer.
*/

	use retail_data_warehouse;

	go

	create or alter procedure load_silver as

	begin

	print 'Loading data into sales table...';

	truncate table silver.sales;

	insert into silver.sales(
		sls_sales_id,
		sls_order_id,
		sls_customer_id,
		sls_product_id,
		sls_order_date_id,
		sls_quantity_sold,
		dwh_load_date
)
	select 
		sls_sales_id,
		sls_order_id,
		sls_customer_id,
		sls_product_id,
		sls_order_date_id,
		sls_quantity_sold,
		dwh_load_date = getdate()
	from bronze.sales;

	print '=================================================';

	print 'Loading data into customers table...';

	truncate table silver.customers;

	insert into silver.customers(
		cst_customer_id,
		cst_customer_name,
		cst_gender,
		cst_birth_date,
		cst_city,
		cst_state,
		cst_registration_date,
		dwh_load_date
)
	select
		cst_customer_id,
		trim(upper(cst_customer_name)),
		case
			when upper(trim(cst_gender)) = 'M' then 'MALE'
			when upper(trim(cst_gender)) = 'F' then 'FEMALE'
		else 'N/A' end as cst_gender,
		cst_birth_date,
		trim(upper(cst_city)),
		trim(upper(cst_state)),
		cst_registration_date,
		dwh_load_date = getdate()
	from bronze.customers;

	print '=================================================';

	print 'Loading data into products table...';

	truncate table silver.products;

	insert into silver.products(
		pdc_product_id,
		pdc_product_name,
		pdc_category,
		pdc_subcategory,
		pdc_brand,
		pdc_unit_cost,
		pdc_unit_price,
		pdc_launch_date,
		dwh_load_date
)
	select
		pdc_product_id,
		trim(upper(pdc_product_name)),
		trim(upper(pdc_category)),
		trim(upper(pdc_subcategory)),
		trim(upper(pdc_brand)),
		pdc_unit_cost,
		pdc_unit_price,
		pdc_launch_date,
		dwh_load_date = getdate()
	from bronze.products

	print '=================================================';

	print 'Loading data into dates table...';

	truncate table silver.dates;

	insert into silver.dates(
		dat_date_id,
		dat_full_date,
		dat_day_number,
		dat_day_name,
		dat_month_number,
		dat_month_name,
		dat_quarter,
		dat_year,
		dat_weekend_flag,
		dwh_load_date
)
	select
		dat_date_id,
		dat_full_date,
		dat_day_number,
		upper(trim(dat_day_name)),
		dat_month_number,
		upper(trim(dat_month_name)),
		dat_quarter,
		dat_year,
		dat_weekend_flag,
		dwh_load_date = getdate()
	from bronze.dates;

	end
