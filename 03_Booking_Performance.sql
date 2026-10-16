USE uber_ride_analysis;

-- Count bookings for each pickup and drop location

SELECT
`Pickup Location`,
`Drop Location`,
COUNT(*) AS total_bookings
FROM uber_ride
GROUP BY
`Pickup Location`,
`Drop Location`
ORDER BY total_bookings DESC
LIMIT 10;

-- Count completed bookings for each route

SELECT
`Pickup Location`,
`Drop Location`,
COUNT(*) AS completed_bookings
FROM uber_ride
WHERE `Booking Status`='Completed'
GROUP BY
`Pickup Location`,
`Drop Location`
ORDER BY completed_bookings DESC
LIMIT 10;

