SQL Query for Comprehensive Booking Details
-- This query retrieves all bookings along with the details of the guest who made the booking,
-- the property that was booked, and the payment associated with that booking.
-- It uses INNER JOINs to ensure that only bookings with matching user, property, and payment records are returned.

SELECT
    b.bookingId,
    b.checkInDate,
    b.checkOutDate,
    b.numberOfGuests,
    b.status AS booking_status,
    b.totalPrice AS booking_total_price,
    -- User (Guest) Details
    u.userId AS guest_userId,
    u.email AS guest_email,
    u.firstName AS guest_firstName,
    u.lastName AS guest_lastName,
    -- Property Details
    p.listingId AS property_listingId,
    p.title AS property_title,
    p.city AS property_city,
    p.country AS property_country,
    p.pricePerNight AS property_price_per_night,
    -- Payment Details
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
    Users AS u ON b.guestId = u.userId -- Join with Users for guest details
INNER JOIN
    Properties AS p ON b.propertyId = p.listingId -- Join with Properties for property details
INNER JOIN
    Payments AS pay ON b.bookingId = pay.bookingId -- Join with Payments for payment details
ORDER BY
    b.checkInDate DESC, b.bookingId;

