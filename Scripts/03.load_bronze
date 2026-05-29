/*
	LOAD BRONZE DATA INTO THE BRONZE LAYER

	This script creates a procedure called 'load_bronze' that loads the data from the source files into each table of the bronze layer.
	It will be stored as a procedure for better organization and reusability. You can execute this procedure whenever you need to refresh the data in the bronze layer.
	It uses the BULK INSERT statement for efficient data loading. 
	Make sure to adjust the file paths and file formats according to your environment before executing the script.
	This script assumes that the source files are in CSV format and that the columns in the files match the order of the columns in the tables.
	This script removes any existing data by truncating the target table before loading new records, ensuring that no duplicate data is introduced during a full refresh.
*/

use retail_data_warehouse;

go

create or alter procedure load_bronze as

begin

print 'Loading data into sales table...';
truncate table bronze.sales;
bulk insert bronze.sales
from 'C:\Users\Usuario(a) Master\Downloads\RetailDataWarehouse\sales.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '0x0a',
	tablock
	);
print('======================================');

print 'Loading data into products table...';
truncate table bronze.products;
bulk insert bronze.products
from 'C:\Users\Usuario(a) Master\Downloads\RetailDataWarehouse\products.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '0x0a',
	tablock
	);
print('======================================');

print 'Loading data into customers table...';
truncate table bronze.customers;
bulk insert bronze.customers
from 'C:\Users\Usuario(a) Master\Downloads\RetailDataWarehouse\customers.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '0x0a',
	tablock
	);
print('======================================');

print 'Loading data into dates table...';
truncate table bronze.dates;
bulk insert bronze.dates
from 'C:\Users\Usuario(a) Master\Downloads\RetailDataWarehouse\dates.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '0x0a',
	tablock
	);
print('======================================');

end;

/* obs: during the execution of this script, it was observed that Source CSV files use LF (0x0A) as row terminator.
BULK INSERT operations must specify: rowterminator = '0x0a' */
