COUNT and GROUP BY: Find the total number of bookings made by each user.
-- This query groups bookings by the guest user and counts the total number of bookings for each.
SELECT
    u.userId,
    u.email,
    u.firstName,
    u.lastName,
    COUNT(b.bookingId) AS total_bookings_made
FROM
    Users AS u
INNER JOIN
    Bookings AS b ON u.userId = b.guestId
GROUP BY
    u.userId, u.email, u.firstName, u.lastName
ORDER BY
    total_bookings_made DESC;

-- Window Function (RANK): Rank properties based on the total number of bookings they have received.
-- This query first calculates the total bookings for each property, then uses the RANK() window function
-- to assign a rank based on this count. Properties with the same number of bookings will receive the same rank.
SELECT
    p.listingId,
    p.title AS property_title,
    COUNT(b.bookingId) AS total_bookings_received,
    RANK() OVER (ORDER BY COUNT(b.bookingId) DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.bookingId) DESC) AS booking_row_number
FROM
    Properties AS p
LEFT JOIN
    Bookings AS b ON p.listingId = b.propertyId
GROUP BY
    p.listingId, p.title
ORDER BY
    booking_rank ASC, total_bookings_received DESC;

