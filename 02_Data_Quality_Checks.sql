USE uber_ride_analysis;

-- Check duplicate ride IDs

SELECT
ride_id,
COUNT(*) AS total_count
FROM uber_ride
GROUP BY ride_id
HAVING COUNT(*) > 1;

-- Check missing booking IDs

SELECT COUNT(*) AS missing_booking_ids
FROM uber_ride
WHERE `Booking ID` IS NULL
OR TRIM(`Booking ID`) = '';

-- Check missing customer IDs

SELECT COUNT(*) AS missing_customer_ids
FROM uber_ride
WHERE `Customer ID` IS NULL
OR TRIM(`Customer ID`) = '';

-- Check invalid booking values

SELECT COUNT(*) AS invalid_booking_values
FROM uber_ride WHERE `Booking Value` < 0;

-- Check invalid ride distances

SELECT COUNT(*) AS invalid_ride_distances
FROM uber_ride WHERE `Ride Distance` < 0;