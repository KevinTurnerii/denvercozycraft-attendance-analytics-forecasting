-- ================================
-- 02_data_cleaning.sql
-- Clean raw data and remove invalid rows
-- ================================

-- Remove invalid summary rows from export
DELETE FROM raw_orders
WHERE order_id = 'TOTALS';

-- Check for missing event names
SELECT *
FROM raw_orders
WHERE event_name IS NULL;

-- Verify row count after cleaning
SELECT COUNT(*) AS total_rows
FROM raw_orders; 