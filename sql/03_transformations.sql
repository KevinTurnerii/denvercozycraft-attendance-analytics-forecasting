-- ================================
-- 03_transformations.sql
-- Transform raw data into business metrics
-- ================================

DROP TABLE IF EXISTS event_performance CASCADE;
DROP TABLE IF EXISTS event_kpis CASCADE;
DROP TABLE IF EXISTS event_summary CASCADE;
DROP TABLE IF EXISTS attendee_loyalty CASCADE;



-- Event-level summary (orders & tickets)
CREATE TABLE event_summary AS
SELECT
    event_name,
    COUNT(DISTINCT order_id) AS orders,
    SUM(ticket_quantity) AS tickets_sold
FROM raw_orders
GROUP BY event_name
ORDER BY tickets_sold DESC;


-- Event KPIs (attendance & conversion rate)
CREATE TABLE event_kpis AS
SELECT
    c.event_name,
    COUNT(*) FILTER (WHERE c.checkin_status = 'Checked In') AS checked_in,
    COUNT(*) AS registrations,
    ROUND(
        COUNT(*) FILTER (WHERE c.checkin_status = 'Checked In')::numeric /
        COUNT(*), 2
    ) AS attendance_rate
FROM raw_checkins c
GROUP BY c.event_name;


-- Attendee loyalty (repeat participation)
CREATE TABLE attendee_loyalty AS
SELECT
    attendee_email,
    COUNT(DISTINCT event_name) AS events_attended
FROM raw_attendees
GROUP BY attendee_email
ORDER BY events_attended DESC;


-- Combine event performance metrics
CREATE TABLE event_performance AS
SELECT
    e.event_name,
    e.orders,
    e.tickets_sold,
    k.checked_in,
    k.registrations,
    k.attendance_rate
FROM event_summary e
LEFT JOIN event_kpis k
ON e.event_name = k.event_name;


-- Loyalty segmentation
SELECT
    attendee_email,
    events_attended,
    CASE
        WHEN events_attended >= 6 THEN 'Core Member'
        WHEN events_attended >= 3 THEN 'Regular Attendee'
        ELSE 'Occasional'
    END AS loyalty_level
FROM attendee_loyalty
ORDER BY events_attended DESC;