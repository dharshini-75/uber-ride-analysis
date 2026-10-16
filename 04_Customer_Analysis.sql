USE uber_ride_analysis;


-- Check whether each customer has multiple booking records

SELECT
`Customer ID`,
COUNT(*) AS total_bookings,
COUNT(DISTINCT `Booking Status`) AS different_statuses
FROM uber_ride
GROUP BY `Customer ID`
HAVING COUNT(*) > 1
ORDER BY total_bookings DESC
LIMIT 10;

-- Count each booking status for every customer

SELECT
`Customer ID`,
`Booking Status`,
COUNT(*) AS total_bookings
FROM uber_ride
GROUP BY
`Customer ID`,
`Booking Status`
ORDER BY
`Customer ID`,
total_bookings DESC
LIMIT 20;

-- Find customers with the most cancelled bookings

SELECT
`Customer ID`,
COUNT(*) AS total_cancellations
FROM uber_ride
WHERE `Booking Status` = 'Cancelled by Customer'
GROUP BY `Customer ID`
ORDER BY total_cancellations DESC
LIMIT 10;

-- Find customers with the highest total booking value

SELECT
`Customer ID`,
SUM(`Booking Value`) AS total_booking_value
FROM uber_ride
WHERE `Booking Status`='Completed'
GROUP BY `Customer ID`
ORDER BY total_booking_value DESC
LIMIT 10;

-- Find customers with the highest average booking value

SELECT
`Customer ID`,
COUNT(*) AS completed_bookings,
ROUND(AVG(`Booking Value`), 2) AS average_booking_value
FROM uber_ride
WHERE `Booking Status`='Completed'
GROUP BY `Customer ID`
HAVING COUNT(*) >= 2
ORDER BY average_booking_value DESC
LIMIT 10;




-- Compare booking outcomes for customers with 2 or more records

SELECT `Customer ID`,
SUM(
CASE
WHEN `Booking Status`='Completed' THEN 1
ELSE 0
END
)AS completed_bookings,
SUM(
CASE
WHEN `Booking Status`='Cancelled by Customer' THEN 1
ELSE 0
END
)AS customer_cancellations,
SUM(
CASE
WHEN `Booking Status`='Cancelled by Driver' THEN 1
ELSE 0
END
) AS driver_cancellations
FROM uber_ride
GROUP BY `Customer ID`
HAVING COUNT(*) >= 2
ORDER BY customer_cancellations DESC
LIMIT 10;