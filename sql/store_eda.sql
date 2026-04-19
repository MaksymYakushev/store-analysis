/************************************************************
 * File:    store_eda.sql
 * Purpose: Exploratory Data Analysis — store table
 * Author:  Maksym Yakushev
 * Date:    2026-04-19
 ************************************************************/


-- ============================================================
-- 1. RAW DATA PREVIEW
-- ============================================================

SELECT
	*
FROM store;


-- ============================================================
-- 2. BASIC PROFILING
-- ============================================================

SELECT
	COUNT(*) AS cnt_rows
	, COUNT(DISTINCT row_id) AS unq_rows
	, COUNT(DISTINCT order_id) AS cnt_orders
	, COUNT(DISTINCT customer_id) AS cnt_customers
	, COUNT(DISTINCT country) AS cnt_contries
	, COUNT(DISTINCT state) AS cnt_states
	, COUNT(DISTINCT city) AS cnt_cities
	, COUNT(DISTINCT product_id) AS unq_products
FROM store;


-- ============================================================
-- 3. DATA QUALITY CHECK
-- ============================================================

SELECT
	-- Date range & anomalies
	MIN(order_date) AS min_order_date
	, MAX(order_date) AS max_order_date
	, MIN(ship_date) AS min_ship_date
	, MAX(ship_date) AS max_ship_date
	, SUM(CASE WHEN ship_date < order_date THEN 1 ELSE 0 END) AS cnt_non_right_date
	
	-- Formatting
	, SUM(CASE WHEN LENGTH(postal_code::TEXT) != 5 THEN 1 ELSE 0 END) AS not_right_postal_code

	-- Numeric ranges
	, MIN(sales) AS min_sales
	, MAX(sales) AS max_sales
	, MIN(quantity) AS min_quantity
	, MAX(quantity) AS max_quantity
	, MIN(discount) AS min_discount
	, MAX(discount) AS max_discount
	, MIN(profit) AS min_profit
	, MAX(profit) AS max_profit
	, SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS profit_less_then_zero
FROM store;


-- ============================================================
-- 4. DISTINCT VALUES — INDIVIDUAL COLUMNS
-- ============================================================

-- ship_mode
SELECT
	DISTINCT ship_mode
FROM store;

-- segment
SELECT
	DISTINCT segment
FROM store;

-- country
SELECT
	DISTINCT country
FROM store;

-- city
SELECT
	DISTINCT city
FROM store
ORDER BY 
	city ASC;

-- state
SELECT
	DISTINCT state
FROM store
ORDER BY 
	state ASC;

-- region
SELECT
	DISTINCT region
FROM store;

-- category
SELECT
	DISTINCT category
FROM store;

-- sub_category
SELECT
	DISTINCT sub_category
FROM store
ORDER BY 
	sub_category ASC;


-- ============================================================
-- 5. DISTINCT VALUES — COMBINED VIEW
-- ============================================================

SELECT 
	'ship_mode' AS column_name
	, ship_mode::TEXT AS distinct_value 
FROM store GROUP BY ship_mode

UNION ALL

SELECT 
	'segment' AS column_name
	, segment::TEXT AS distinct_value 
FROM store 
GROUP BY segment

UNION ALL

SELECT 
	'country' AS column_name
	, country::TEXT AS distinct_value
FROM store 
GROUP BY country

UNION ALL

SELECT 
	'region' AS column_name
	, region::TEXT AS distinct_value 
FROM store 
GROUP BY region

UNION ALL

SELECT 
	'category' AS column_name
	, category::TEXT AS distinct_value 
FROM store 
GROUP BY category

UNION ALL

SELECT 
	'sub_category' AS column_name
	, sub_category::TEXT AS distinct_value 
FROM store 
GROUP BY sub_category

ORDER BY 
	column_name
	, distinct_value;




