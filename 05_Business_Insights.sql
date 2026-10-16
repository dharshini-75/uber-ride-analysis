USE uber_ride_analysis;

-- Find pickup locations with high cancellation rates
SELECT `Pickup Location`,
COUNT(*) AS total_bookings,
SUM(CASE
WHEN `Booking Status` IN ('Cancelled by Customer','Cancelled by Driver') THEN 1
ELSE 0
END) AS total_cancellations,
ROUND(100.0 * SUM(CASE
WHEN `Booking Status` IN ('Cancelled by Customer','Cancelled by Driver') THEN 1
ELSE 0
END) / COUNT(*), 2) AS cancellation_rate
FROM uber_ride
GROUP BY `Pickup Location`
HAVING COUNT(*) >= 100
ORDER BY cancellation_rate DESC
LIMIT 10;


-- Find vehicle types with the most incomplete rides
SELECT `Vehicle Type`,
COUNT(*) AS incomplete_rides
FROM uber_ride
WHERE `Booking Status`='Incomplete'
GROUP BY `Vehicle Type`
ORDER BY incomplete_rides DESC;


-- Find the most common driver cancellation reasons by vehicle
SELECT `Vehicle Type`,
`Driver Cancellation Reason`,
COUNT(*) AS cancellation_count
FROM uber_ride
WHERE `Booking Status`='Cancelled by Driver'
AND `Driver Cancellation Reason` IS NOT NULL
AND TRIM(`Driver Cancellation Reason`) <> ''
GROUP BY `Vehicle Type`, `Driver Cancellation Reason`
ORDER BY cancellation_count DESC
LIMIT 10;


-- Find pickup locations with the most driver cancellations
SELECT `Pickup Location`,
COUNT(*) AS driver_cancellations
FROM uber_ride
WHERE `Booking Status`='Cancelled by Driver'
GROUP BY `Pickup Location`
ORDER BY driver_cancellations DESC
LIMIT 10;


-- Find routes with high cancellation rates
SELECT `Pickup Location`,
`Drop Location`,
COUNT(*) AS total_bookings,
SUM(CASE
WHEN `Booking Status` IN ('Cancelled by Customer','Cancelled by Driver') THEN 1
ELSE 0
END) AS total_cancellations,
ROUND(100.0 * SUM(CASE
WHEN `Booking Status` IN ('Cancelled by Customer','Cancelled by Driver') THEN 1
ELSE 0
END) / COUNT(*), 2) AS cancellation_rate
FROM uber_ride
GROUP BY `Pickup Location`, `Drop Location`
HAVING COUNT(*) >= 20
ORDER BY cancellation_rate DESC
LIMIT 10;


-- Find common reasons for incomplete rides
SELECT `Incomplete Rides Reason`,
COUNT(*) AS incomplete_count
FROM uber_ride
WHERE `Booking Status`='Incomplete'
AND `Incomplete Rides Reason` IS NOT NULL
AND TRIM(`Incomplete Rides Reason`) <> ''
GROUP BY `Incomplete Rides Reason`
ORDER BY incomplete_count DESC;


-- 7. Find pickup locations with the longest average waiting time
SELECT `Pickup Location`,
COUNT(*) AS completed_bookings,
ROUND(AVG(`Avg VTAT`), 2) AS average_wait_time
FROM uber_ride
WHERE `Booking Status`='Completed'
AND `Avg VTAT` IS NOT NULL
GROUP BY `Pickup Location`
HAVING COUNT(*) >= 100
ORDER BY average_wait_time DESC
LIMIT 10;


-- Find routes with the highest average booking value
SELECT `Pickup Location`,
`Drop Location`,
COUNT(*) AS completed_bookings,
ROUND(AVG(`Booking Value`), 2) AS average_booking_value
FROM uber_ride
WHERE `Booking Status`='Completed'
GROUP BY `Pickup Location`, `Drop Location`
HAVING COUNT(*) >= 10
ORDER BY average_booking_value DESC
LIMIT 10;


-- Compare cancellation rates across payment methods
SELECT `Payment Method`,
COUNT(*) AS total_bookings,
SUM(CASE
WHEN `Booking Status` IN ('Cancelled by Customer','Cancelled by Driver') THEN 1
ELSE 0
END) AS total_cancellations,
ROUND(100.0 * SUM(CASE
WHEN `Booking Status` IN ('Cancelled by Customer','Cancelled by Driver') THEN 1
ELSE 0
END) / COUNT(*), 2) AS cancellation_rate
FROM uber_ride
WHERE `Payment Method` IS NOT NULL
GROUP BY `Payment Method`
HAVING COUNT(*) >= 100
ORDER BY cancellation_rate DESC;


-- Compare booking outcomes by pickup location
SELECT `Pickup Location`,
COUNT(*) AS total_bookings,
SUM(CASE
WHEN `Booking Status`='Completed' THEN 1
ELSE 0
END) AS completed_bookings,
SUM(CASE
WHEN `Booking Status`='Incomplete' THEN 1
ELSE 0
END) AS incomplete_rides,
SUM(CASE
WHEN `Booking Status` IN ('Cancelled by Customer','Cancelled by Driver') THEN 1
ELSE 0
END) AS cancelled_bookings
FROM uber_ride
GROUP BY `Pickup Location`
HAVING COUNT(*) >= 100
ORDER BY incomplete_rides DESC
LIMIT 10;