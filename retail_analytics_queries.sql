/* ============================================================================
   PORTFOLIO PROJECT: RETAIL SALES DATA PIPELINE & ANALYTICS
   Database: Microsoft SQL Server (MS SQL)
   ============================================================================ */

-- Always start by ensuring we are targeting the correct database
USE retail_project;

-- Let's take a quick look at the data structure first
SELECT TOP 5 * FROM df_orders;

-- Q1: The Urgent First Class Check
-- Business Context: Operations wants to analyze financial performance on high-priority shipping.
-- Find all records where ship_mode is 'First Class' and profit is negative, sorted worst to best.
SELECT * FROM df_orders
WHERE ship_mode = 'First Class' 
  AND profit < 0
ORDER BY profit ASC;


-- Q2: The High-Volume State Target
-- Business Context: Logistics wants to identify bulk ordering patterns in major hub states.
-- Find all orders shipped to 'California' where the customer bought a quantity of 8 or more items.
SELECT * FROM df_orders
WHERE state = 'California' 
  AND quantity >= 8;

-- Q3: The Big Ticket Items
-- Business Context: Marketing wants to target high-value corporate transactions.
-- Isolate the top 10 most expensive transactions based on sale_price.
SELECT TOP 10 * FROM df_orders
ORDER BY sale_price DESC;

-- Q4: The Category Leaderboard
-- Business Context: Executive leadership wants to identify the main profit-driving business divisions.
-- Calculate Total Profit for each unique product category.
SELECT category, 
       SUM(profit) AS total_category_profit
FROM df_orders
GROUP BY category
ORDER BY total_category_profit DESC;


-- Q5: Sub-Category Profitability & Discount Impact
-- Business Context: Inventory Management needs to identify bleeding or highly successful product lines.
-- Calculate Total Profit and Average Discount for every unique sub-category.
SELECT sub_category, 
       SUM(profit) AS total_profit, 
       AVG(discount) AS average_discount
FROM df_orders
GROUP BY sub_category
ORDER BY total_profit DESC;


-- Q6: Customer Segment Volume Split
-- Business Context: Marketing needs data to allocate the next quarter's advertising budget.
-- Extract Total Sales, Total Profit, and Total Order count for each customer segment.
SELECT segment, 
       SUM(sale_price) AS total_sales, 
       SUM(profit) AS total_profit, 
       COUNT(*) AS total_orders
FROM df_orders
GROUP BY segment
ORDER BY total_sales DESC;


-- Q7: Top 2 Regional Product Lines
-- Business Context: Regional Managers need localized insights on consumer demand.
-- Find the Top 2 highest-revenue product sub-categories for EACH unique region.
WITH RegionalRanking AS (
    SELECT region, 
           sub_category, 
           SUM(sale_price) AS total_sales,
           DENSE_RANK() OVER (PARTITION BY region ORDER BY SUM(sale_price) DESC) AS sales_rank
    FROM df_orders
    GROUP BY region, sub_category
)
SELECT region, 
       sub_category, 
       total_sales, 
       sales_rank
FROM RegionalRanking
WHERE sales_rank <= 2;


-- Q8: High-Value Revenue Outlier Cities
-- Business Context: Strategy team wants to find cities significantly beating the baseline average.
-- Identify all cities whose Total Sales are higher than the Average Total Sales of all cities combined.
WITH CitySales AS (
    SELECT city, 
           SUM(sale_price) AS total_city_sales
    FROM df_orders
    GROUP BY city
)
SELECT city, 
       total_city_sales
FROM CitySales
WHERE total_city_sales > (SELECT AVG(total_city_sales) FROM CitySales)
ORDER BY total_city_sales DESC;