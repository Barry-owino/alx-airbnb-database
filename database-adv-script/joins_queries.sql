-- SQL Join Queries for Airbnb Clone Backend

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings.
-- This query will only return rows where there is a match in both the Bookings and Users tables.
SELECT
    b.bookingId,
    b.checkInDate,
    b.checkOutDate,
    b.numberOfGuests,
    b.status AS booking_status,
    b.totalPrice,
    u.userId AS guest_userId,
    u.email AS guest_email,
    u.firstName AS guest_firstName,
    u.lastName AS guest_lastName
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.guestId = u.userId;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews.
-- This query will return all properties, and if a property has associated bookings and reviews,
-- those review details will be included. Properties without reviews (or bookings) will still appear.
SELECT
    p.listingId,
    p.title AS property_title,
    p.city,
    p.pricePerNight,
    b.bookingId,
    b.checkInDate,
    b.checkOutDate,
    r.reviewId,
    r.rating,
    r.comment,
    r.reviewDate
FROM
    Properties AS p
LEFT JOIN
    Bookings AS b ON p.listingId = b.propertyId
LEFT JOIN
    Reviews AS r ON b.bookingId = r.bookingId;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings,
-- even if the user has no booking or a booking is not linked to a user.
-- This query will show:
-- - Users who have made bookings (matched rows)
-- - Users who have not made any bookings (booking columns will be NULL)
-- - Bookings that are not linked to any user (user columns will be NULL - though this should be rare
--   in a database with foreign key constraints, it helps identify data inconsistencies if they exist).
SELECT
    u.userId,
    u.email,
    u.firstName,
    u.lastName,
    b.bookingId,
    b.propertyId,
    b.checkInDate,
    b.checkOutDate,
    b.status AS booking_status,
    b.totalPrice
FROM
    Users AS u
FULL OUTER JOIN
    Bookings AS b ON u.userId = b.guestId;

