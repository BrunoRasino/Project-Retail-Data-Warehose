/*
	CREATE THE TABLES IN THE GOLD SCHEMA

	This script creates the tables in the gold schema after checking if they already exist.
	If the tables already exist, they will be dropped and recreated.
	This will cause the lost of all the previous data in the table, so be careful when running this script.

*/

use retail_data_warehouse;

go

if object_id('gold.fact_sales', 'U') is not null
	drop table gold.fact_sales;

go

create table gold.fact_sales
(
	sales_id int,
	order_id int,
	customer_id int,
	product_id int,
	order_date_id int,
	quantity_sold int,
	cost_amount decimal(18, 2),
	sales_amount decimal(18, 2),
	profit_amount decimal(18, 2)
);

go

if object_id('gold.dim_products', 'U') is not null
	drop table gold.dim_products;

go

create table gold.dim_products
(
	product_id int,
	product_name varchar(255),
	category varchar(255),
	subcategory varchar(255),
	brand varchar(255),
	unit_cost decimal(18, 2),
	unit_price decimal(18, 2),
	launch_date date
);

go

if object_id('gold.dim_customers', 'U') is not null
	drop table gold.dim_customers;

go

create table gold.dim_customers
(
	customer_id int,
	customer_name varchar(255),
	gender varchar(50),
	birth_date date,
	city varchar(255),
	state varchar(255),
	registration_date date
);

if object_id('gold.dim_dates', 'U') is not null
	drop table gold.dim_dates;

go

create table gold.dim_dates
(
	date_id int,
	full_date date,
	day_number int,
	day_name varchar(50),
	month_number int,
	month_name varchar(50),
	quarter int,
	year int,
	weekend_flag bit
);
