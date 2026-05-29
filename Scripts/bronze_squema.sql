/*
	CREATE THE TABLES IN THE BRONZE SCHEMA

	This script creates the tables in the bronze schema after checking if they already exists.
	If the tables already exist, they will be dropped and recreated.

	This will cause the lost of all the previous data in the table, so be careful when running this script.
*/

use retail_data_warehouse;

go

if object_id('bronze.sales', 'U') is not null
	drop table bronze.sales;

go

create table bronze.sales(
	sls_sales_id int,
	sls_order_id int,
	sls_customer_id int,
	sls_product_id int,
	sls_order_date_id int,
	sls_quantity_sold int
);

go

if object_id('bronze.products', 'U') is not null
	drop table bronze.products;

go

create table bronze.products(
	pdc_product_id int,
	pdc_product_name varchar(255),
	category varchar(255),
	subcategory varchar(255),
	brand varchar(255),
	unit_cost decimal(10,2),
	unit_price decimal(10,2),
	launch_date date
);

go

if object_id('bronze.customers', 'U') is not null
	drop table bronze.customers;

go

create table bronze.customers(
	cst_customer_id int,
	cst_customer_name varchar(255),
	cst_gender varchar(10),
	cst_birth_date date,
	cst_city varchar(255),
	cst_state varchar(255),
	cst_registration_date date
);

go

if object_id('bronze.dates', 'U') is not null
	drop table bronze.dates;

go

create table bronze.dates(
	dat_date_id int,
	dat_full_date date,
	dat_day_number int,
	dat_day_name varchar(20),
	dat_month_number int,
	dat_month_name varchar(20),
	dat_quarter int,
	dat_year int,
	dat_weekend_flag bit
);
