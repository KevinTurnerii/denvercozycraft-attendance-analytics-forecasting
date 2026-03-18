 -- ============================================================
-- 04_data_warehouse.sql
-- Build warehouse (fact + dimension tables)
-- ============================================================

-- =========================
-- DROP TABLES (SAFE REBUILD)
-- =========================

DROP TABLE IF EXISTS fact_event_performance CASCADE;
DROP TABLE IF EXISTS dim_event CASCADE;
DROP TABLE IF EXISTS dim_attendees CASCADE;


-- ========================= -- FACT TABLE: Event Performance -- ========================= CREATE TABLE fact_event_performance AS SELECT event_name, event_start_date, SUM(ticket_quantity) AS registrations, SUM(CASE WHEN checkin_status = 'Checked In' THEN 1 ELSE 0 END) AS checked_in, ROUND( SUM(CASE WHEN checkin_status = 'Checked In' THEN 1 ELSE 0 END)::numeric / NULLIF(SUM(ticket_quantity), 0), 2) AS attendance_rate, 80 AS venue_capacity FROM raw_checkins GROUP BY event_name, event_start_date;


-- =========================
-- DIMENSION TABLE: Event
-- =========================

CREATE TABLE dim_event AS
SELECT DISTINCT
    event_id,
    event_name,
    event_start_date,
    event_location
FROM raw_orders;


-- =========================
-- DIMENSION TABLE: Attendees
-- =========================

CREATE TABLE dim_attendees AS
SELECT
    attendee_email,
    COUNT(DISTINCT event_name) AS events_attended,
    CASE
        WHEN COUNT(DISTINCT event_name) >= 6 THEN 'Core Member'
        WHEN COUNT(DISTINCT event_name) >= 3 THEN 'Regular Attendee'
        ELSE 'Occasional'
    END AS loyalty_level
FROM raw_attendees
GROUP BY attendee_email;


-- =========================
-- VALIDATION QUERIES
-- =========================

SELECT * FROM fact_event_performance LIMIT 5;
SELECT * FROM dim_event LIMIT 5;
SELECT * FROM dim_attendees LIMIT 5;

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'fact_event_performance';