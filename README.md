# Gravity Books Data Warehouse (ETL with SSIS + Star Schema)

An end-to-end Data Warehouse project built on the **Gravity Books** sample database. The project extracts data from the OLTP source, transforms it with **SQL Server Integration Services (SSIS)**, and loads it into a **Star Schema** designed for analytics and reporting.

## Overview

- **Source:** Gravity Books OLTP database (SQL Server)
- **ETL Tool:** SQL Server Integration Services (SSIS)
- **Target:** Data Warehouse modeled as a Star Schema (fact and dimension tables)
- **Goal:** Make book sales data easy to analyze (by customer, book, author, time, shipping, and more)

## Architecture

```
Gravity Books (OLTP)  -->  SSIS ETL Packages  -->  Data Warehouse (Star Schema)
```

1. **Extract:** read data from the source tables.
2. **Transform:** clean the data, handle keys, and shape it into dimensions and facts.
3. **Load:** populate dimension tables first, then the fact table.

## Star Schema

The warehouse follows the dimensional modeling approach:

- **Fact table:** stores the measurable business events (e.g., sales / orders).
- **Dimension tables:** descriptive context for the facts (e.g., customer, book, date).

## Project Structure

```
ETL Using SSIS/
├── ...   SSIS projects and packages
├── ...   SQL scripts
└── ...   Documentation / diagrams
```

> Update the tree above to match your actual folders.

## Tools & Technologies

- SQL Server
- SQL Server Integration Services (SSIS)
- SQL Server Data Tools (Visual Studio)

## How to Run

1. Restore or create the **Gravity Books** source database in SQL Server.
2. Create the Data Warehouse database and run the DDL scripts for the dimension and fact tables.
3. Open the SSIS solution in Visual Studio (SSDT).
4. Update the connection managers to point to your own SQL Server instance.
5. Run the packages: dimensions first, then the fact table.

## Author

**Shalaby**
GitHub: [shalaby-lv](https://github.com/shalaby-lv)
