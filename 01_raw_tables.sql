-- ================================
-- 01_raw_tables.sql
-- Load raw data into database
-- ================================
DROP TABLE IF EXISTS raw_orders CASCADE;
DROP TABLE IF EXISTS raw_attendees CASCADE;
DROP TABLE IF EXISTS raw_checkins CASCADE;


CREATE TABLE raw_orders (
    order_id TEXT,
    order_date TEXT,
    buyer_first_name TEXT,
    buyer_last_name TEXT,
    buyer_email TEXT,
    phone_number TEXT,
    purchaser_city TEXT,
    purchaser_state TEXT,
    purchaser_country TEXT,
    billing_zip_code TEXT,
    billing_country TEXT,
    event_name TEXT,
    event_id TEXT,
    event_start_date TEXT,
    event_start_time TEXT,
    event_timezone TEXT,
    event_location TEXT,
    ticket_quantity INT,
    add_ons_quantity INT,
    currency TEXT,
    payment_status TEXT,
    payment_type TEXT,
    payment_details TEXT,
    gross_sales NUMERIC,
    eventbrite_service_fee NUMERIC,
    eventbrite_payment_processing_fee NUMERIC,
    eventbrite_tax NUMERIC,
    organizer_tax NUMERIC,
    royalty NUMERIC,
    ticket_revenue NUMERIC,
    add_ons_revenue NUMERIC,
    ticket_addons_revenue NUMERIC,
    net_sales NUMERIC,
    guest TEXT
);

CREATE TABLE raw_attendees (
    order_id TEXT,
    order_date TEXT,
    attendee_first_name TEXT,
    attendee_last_name TEXT,
    attendee_email TEXT,
    phone_number TEXT,
    purchaser_city TEXT,
    purchaser_state TEXT,
    purchaser_country TEXT,
    event_name TEXT,
    event_id TEXT,
    event_start_date TEXT,
    event_start_time TEXT,
    event_timezone TEXT,
    event_location TEXT,
    ticket_quantity INT,
    ticket_tier TEXT,
    ticket_type TEXT,
    currency TEXT,
    ticket_price NUMERIC,
    buyer_first_name TEXT,
    buyer_last_name TEXT,
    buyer_email TEXT,
    seating_location1 TEXT,
    seating_location2 TEXT,
    seating_location3 TEXT,
    barcode_number TEXT,
    guest TEXT
);

CREATE TABLE raw_checkins (
    order_id TEXT,
    order_date TEXT,
    attendee_first_name TEXT,
    attendee_last_name TEXT,
    attendee_email TEXT,
    event_name TEXT,
    event_id TEXT,
    event_start_date TEXT,
    event_start_time TEXT,
    event_timezone TEXT,
    event_location TEXT,
    ticket_quantity INT,
    ticket_tier TEXT,
    ticket_type TEXT,
    barcode_number TEXT,
    checkin_status TEXT,
    checkin_datetime TEXT,
    device_name TEXT,
    guest TEXT
);

COPY raw_orders
FROM 'C:\cozycraft_sql\orders.csv'
DELIMITER ','
CSV HEADER;

COPY raw_attendees
FROM 'C:\cozycraft_sql\attendees.csv'
DELIMITER ','
CSV HEADER;

COPY raw_checkins
FROM 'C:\cozycraft_sql\checkins.csv'
DELIMITER ','
CSV HEADER;