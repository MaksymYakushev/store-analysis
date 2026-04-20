/************************************************************
 * File:    store_cleaned.sql
 * Purpose: Cleaned dataset for analysis and visualization
 * Author:  Maksym Yakushev
 * Date:    2026-04-20
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
*
FROM store;


-- ============================================================
-- 2. CLEANED DATASET – VIEW
-- ============================================================

CREATE VIEW store_cleaned AS
SELECT *
FROM (
    SELECT
        *
        , ROW_NUMBER() OVER(PARTITION BY order_id, product_id ORDER BY order_id) AS rnk
    FROM store
    WHERE 
		LENGTH(postal_code::TEXT) = 5
) AS t
WHERE rnk = 1;

