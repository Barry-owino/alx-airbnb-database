--Subquery: Find all properties where the average rating is greater than 4.0.
-- This query first calculates the average rating for each property that has reviews,
-- and then selects properties whose average rating exceeds 4.0.
SELECT
    p.listingId,
    p.title,
    p.city,
    p.pricePerNight,
    avg_ratings.average_rating
FROM
    Properties AS p
INNER JOIN (
    SELECT
        b.propertyId,
        AVG(r.rating) AS average_rating
    FROM
        Bookings AS b
    INNER JOIN
        Reviews AS r ON b.bookingId = r.bookingId
    GROUP BY
        b.propertyId
    HAVING
        AVG(r.rating) > 4.0
) AS avg_ratings ON p.listingId = avg_ratings.propertyId;

--Correlated Subquery: Find users who have made more than 3 bookings.
-- This query selects users where the count of their bookings (calculated in the subquery)
-- is greater than 3. The subquery is "correlated" because it depends on the outer query's user ID.
SELECT
    u.userId,
    u.email,
    u.firstName,
    u.lastName
FROM
    Users AS u
WHERE (
    SELECT
        COUNT(b.bookingId)
    FROM
        Bookings AS b
    WHERE
        b.guestId = u.userId
) > 3;
