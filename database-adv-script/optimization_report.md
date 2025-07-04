EXPLAIN ANALYZE
SELECT
    b.bookingId,
    b.checkInDate,
    b.checkOutDate,
    b.numberOfGuests,
    b.status AS booking_status,
    b.totalPrice AS booking_total_price,
    u.userId AS guest_userId,
    u.email AS guest_email,
    u.firstName AS guest_firstName,
    u.lastName AS guest_lastName,
    p.listingId AS property_listingId,
    p.title AS property_title,
    p.city AS property_city,
    p.country AS property_country,
    p.pricePerNight AS property_price_per_night,
    pay.paymentId,
    pay.amount AS payment_amount,
    pay.currency AS payment_currency,
    pay.transactionId,
    pay.paymentDate,
    pay.status AS payment_status,
    pay.type AS payment_type
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.guestId = u.userId
INNER JOIN
    Properties AS p ON b.propertyId = p.listingId
INNER JOIN
    Payments AS pay ON b.bookingId = pay.bookingId
ORDER BY
    b.checkInDate DESC, b.bookingId;
