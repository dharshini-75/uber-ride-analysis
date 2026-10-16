-- 1. Select the project database
USE uber_ride_analysis;

-- 2. Check the table structure
DESC uber_ride;

-- 3. Count the total records
SELECT COUNT(*) AS total_records
FROM uber_ride;