# End-to-End Retail Sales Data Pipeline & Analytics Project

## 📌 Project Overview
This project demonstrates an end-to-end data pipeline (ETL) and exploratory data analysis. Raw retail sales transaction data was extracted, cleaned, and transformed using **Python (Pandas)**, and then automatically loaded into a custom-designed **Microsoft SQL Server** database. Advanced relational database queries were executed using **SSMS** to uncover critical business KPIs and actionable sales insights for executive decision-making.

## 🛠️ Tech Stack & Tools
* **Data Manipulation & ETL:** Python 3, Pandas Jupyter Notebook
* **Database Ingestion:** SQLAlchemy, PyODBC
* **Database Engine:** Microsoft SQL Server (MS SQL)
* **SQL Environment:** SQL Server Management Studio (SSMS)
* **Advanced SQL Concepts:** Window Functions (`DENSE_RANK`), CTEs, Subqueries, Complex Aggregations

## 📐 Data Architecture & Cleaning Process
The raw data presented standard ingestion challenges such as irregular case formatting, spaces in column headers, and uncalculated financial matrices. The pipeline achieved the following:
1. **Header Standardization:** Converted all raw headers to snake_case format (e.g., `Order Id` became `order_id`).
2. **Schema Alignment:** Dropped redundant financial vectors (`list_price`, `cost_price`, `discount_percent`) to align perfectly with the target relational database configuration.
3. **Optimized Load:** Appended the polished dataframe into SQL Server with strict explicit datatypes utilizing the `to_sql` method.

## 📊 Key Business Insights Discovered
* **High Priority Shipping Efficiency:** An evaluation of 'First Class' shipping rows revealing losses showed that the maximum loss was contained at a minor -$5.00 margin on Phones, proving low structural risk on expedited shipping.
* **The Volume Leader:** The **Consumer** segment is the core engine of the business, accounting for a massive majority of sales and exactly **5,191 individual order lines**.
* **Product Standouts:** **Chairs** emerged as the single highest corporate profit maker, while **Fasteners** were identified as an active financial drain due to aggressive low-margin discounting.
* **Revenue Concentration (The 80/20 Rule):** Out of hundreds of cities mapped, **only 91 cities** generated total revenue higher than the baseline national average, with **New York City** taking the absolute top spot.

## 📂 Repository Contents
* `retail_data_cleaning.ipynb`: Jupyter notebook showcasing the initial Python exploratory analysis and ETL script.
* `retail_analytics_queries.sql`: Structured SQL file containing business-critical analytical queries ranging from baseline filters to advanced analytics.
