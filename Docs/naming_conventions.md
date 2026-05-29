# **Naming Conventions**

## **General Principles**

- **Naming Conventions**: Use lowercase letters and underscores (`_`) to separate words.
- **Language**: Use English for all names.
- **Avoid Reserved Words**: Do not use SQL reserved words as object names.

## Schema Naming Conventions

Schemas must represent the Medallion Architecture layers:

- `bronze`
- `silver`
- `gold`

- ## **Table Naming Conventions**

### **Bronze Rules**
- All table names must preserve the original source file names without renaming..

- ### **Silver Rules**
- All table names must preserve the same naming structure as the Bronze layer..

- ### **Gold Rules**
- All table names must follow meaningful, business-aligned naming conventions optimized for analytics and reporting..
- **`<category>_<entity>`**  
  - `<category>`: Describes the role of the table, such as `dim` (dimension) or `fact` (fact table).  
  - `<entity>`: Descriptive name of the table, aligned with the business domain (e.g., `customers`, `products`, `sales`).
    - Examples:
    - `dim_customers` → Dimension table for customer data.

## Key Naming Conventions

### Primary Keys
- All primary keys must follow the format:
  - `<table_name>_id`
  - Example:
    - `customer_id`
    - `product_id`

### Foreign Keys
- Foreign keys must preserve the referenced primary key name.
- Example:
  - `customer_id` in `fact_sales` references `customer_id` in `dim_customers`.

## **Column Naming Conventions**

### **Systen table columns**
- All columns that came from the csv files must start with the prefix referring to the file where they are from.
- Example: sales 'sls', customers 'cst', dates 'dat', products 'pdc'. 

### **Technical Columns**
- All technical columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's purpose.
- **`dwh_<column_name>`**  
  - `dwh`: Prefix exclusively for system-generated metadata.  
  - `<column_name>`: Descriptive name indicating the column's purpose.  
  - Example: `dwh_load_date` → System-generated column used to store the date when the record was loaded.

## **Stored Procedure**

- All stored procedures used for loading data must follow the naming pattern:
- **`load_<layer>`**.
  
  - `<layer>`: Represents the layer being loaded, such as `bronze`, `silver`, or `gold`.
  - Example: 
    - `load_bronze` → Stored procedure for loading data into the Bronze layer.
    - `load_silver` → Stored procedure for loading data into the Silver layer.
