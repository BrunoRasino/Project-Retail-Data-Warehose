/*
	QUALITY CHECK OF BRONZE LAYER
	before loading data from bronze to silver layer, we need to check the quality of data in bronze layer.
	this script creates a procedure that can be used to check the quality of data in bronze layer.
*/

	create or alter procedure quality_check_bronze as

	begin

	print 'Starting quality check of sales table';

	--Search for null values
	if exists(
	select 1 from bronze.sales 
	where sls_sales_id is null 
	or sls_order_id is null
	or sls_customer_id is null 
	or sls_product_id is null
	or sls_order_date_id is null
	or sls_quantity_sold is null
)
	print '[FAIL] Null values found in sales'
	else print '[PASS] No null values found in sales';

	--Search for negative values
	if exists(
	select 1 from bronze.sales
	where sls_quantity_sold < 1
) 
	print '[FAIL] Negative values found in sales'
	else print '[PASS] No negative values found in sales';

	--Search for duplicates
	if exists(
	select 
	sls_sales_id, count(*) as record_count 
	from bronze.sales
	group by sls_sales_id
	having count(*) > 1
)
	print '[FAIL] Duplicate records found in sales'
	else print '[PASS] No duplicate records found in sales';

	--Search for orphan records in sales table (sales records that do not have a corresponding customer record)
	if exists(
	select 1 from bronze.sales s
	left join bronze.customers c
		on s.sls_customer_id = c.cst_customer_id
	where c.cst_customer_id is null
)
	print '[FAIL] Orphan records found in sales and customers'
	else print '[PASS] No orphan records found in sales and customers';

	--Search for orphan records in sales table (sales records that do not have a corresponding product record)
	if exists(
	select 1 from bronze.sales s
	left join bronze.products p
		on s.sls_product_id = p.pdc_product_id
	where p.pdc_product_id is null
) 
	print '[FAIL] Orphan records found in sales and products'
	else print '[PASS] No orphan records found in sales and products';

	--Search for orphan records in sales table (sales records that do not have a corresponding date record)
	if exists(
	select 1 from bronze.sales s
	left join bronze.dates d
		on s.sls_order_date_id = d.dat_date_id
	where d.dat_date_id is null
) 
	print '[FAIL] Orphan records found in sales and dates'
	else print '[PASS] No orphan records found in sales and dates';

	print 'Sales quality check completed';
	print '==========================================='

	print 'Starting quality check of customer table';

	--search for null values
	if exists(
	select 1 from bronze.customers
	where cst_customer_id		is null
	or	  cst_customer_name		is null
	or    cst_gender			is null
	or    cst_birth_date		is null
	or    cst_city			    is null
	or    cst_state             is null
	or    cst_registration_date is null
) 
	print	   '[FAIL] Null values found in customers'
	else print '[PASS] No null values found in customers';

	--search for duplicates
	if exists(
	select cst_customer_id, count(*) as record_count
	from bronze.customers
	group by cst_customer_id
	having count(*) > 1
)
	print '[FAIL] Duplicate records found in customers'
	else print '[PASS] No duplicate records found in customers';

	--search for future birth dates
	if exists(
	select 1
	from bronze.customers
	where cst_birth_date > getdate()
)
	print '[FAIL] Future birth dates found in customers'
	else print '[PASS] No future birth dates found in customers';

	--search for registration dates before birth dates
	if exists(
	select 1
	from bronze.customers
	where cst_registration_date < cst_birth_date
)
	print '[FAIL] Invalid registration dates found in customers'
	else print '[PASS] No invalid registration dates found in customers';

	--search for empty customer names
	if exists(
	select 1
	from bronze.customers
	where trim(cst_customer_name) = ''
)
	print '[FAIL] Empty customer names found'
	else print '[PASS] No empty customer names found';

	--search for empty city values
	if exists(
	select 1
	from bronze.customers
	where trim(cst_city) = ''
)
	print '[FAIL] Empty city values found'
	else print '[PASS] No empty city values found';

	print 'customer quality check completed';
	print '===========================================';

	print 'Starting quality check of products table';

	--search for null or empty values
	if exists(
	select 1 from bronze.products
	where pdc_product_id		is null
	or	  pdc_product_name		is null
	or	  trim(pdc_product_name) = ''
	or    pdc_category			is null
	or    trim(pdc_category)	 = ''
	or	  pdc_subcategory		is null
	or    trim(pdc_subcategory)  = ''
	or	  pdc_brand				is null
	or    trim(pdc_brand)		 = ''
	or	  pdc_unit_cost			is null
	or	  pdc_unit_price		is null
	or    pdc_launch_date		is null
) 
	print	   '[FAIL] Null or empty values found in products'
	else print '[PASS] No null or empty values found in products';

	--search for duplicates
	if exists(
	select 1
	from bronze.products
	group by pdc_product_id
	having count(*) > 1
)
	print '[FAIL] Duplicate records found in products'
	else print '[PASS] No duplicate records found in products';

	--search for cost higher than prince
	if exists(
	select 1 from bronze.products
	where pdc_unit_cost > pdc_unit_price
)
	print '[FAIL] Invalid product pricing found'
	else print '[PASS] All products have valid pricing';

	--search for cost or price values less than zero
	if exists(
	select 1 from bronze.products
	where pdc_unit_cost  <= 0
	or	  pdc_unit_price <= 0
)
	print '[FAIL] Negative cost or price values found in products'
	else print '[PASS] No negative cost or price values found in products';

	--search for future launch dates
	if exists(
	select 1
	from bronze.products
	where pdc_launch_date > getdate()
)
	print '[FAIL] Future launch dates found in products'
	else print '[PASS] No future launch dates found in products';

	print 'products quality check completed';
	print '===========================================';

	print 'Starting quality check of dates table';

	--search for null values
	if exists(
	select 1 from bronze.dates
	where dat_date_id is null
	or dat_full_date is null
	or dat_day_number is null
	or dat_day_name is null
	or dat_month_number is null
	or dat_month_name is null
	or dat_quarter is null
	or dat_year is null
	or dat_weekend_flag is null
)
	print '[FAIL] Null values found in dates'
	else print '[PASS] No null values found in dates';

	--search for duplicates
	if exists(
	select 1
	from bronze.dates
	group by dat_full_date
	having count(*) > 1
)
	print '[FAIL] Duplicate records found in dates'
	else print '[PASS] No duplicate records found in dates';

	--validate day of month

	if exists(
	select 1 from bronze.dates
	where dat_day_number not between 1 and 31
)
	print '[FAIL] Invalid day numbers found in dates'
	else print '[PASS] All day numbers are valid in dates';

	--validate month of year
	if exists(
	select 1 from bronze.dates
	where dat_month_number not between 1 and 12
)
	print '[FAIL] Invalid month numbers found in dates'
	else print '[PASS] All month numbers are valid in dates';

	--validate quarter
	if exists(
	select 1 from bronze.dates
	where dat_quarter not between 1 and 4
)
	print '[FAIL] Invalid quarter values found in dates'
	else print '[PASS] All quarter values are valid in dates';

	print 'dates quality check completed';
	print '===========================================';

	end
