-- SQL INSERT Statements for Airbnb Clone Backend Sample Data
-- Ensure these are run after the CREATE TABLE statements.
-- UUIDs are generated using gen_random_uuid() for primary keys
-- and then referenced for foreign keys.

-- Sample Users
INSERT INTO Users (userId, email, passwordHash, role, firstName, lastName, profilePhotoUrl, contactInfo, preferences) VALUES
('a1b2c3d4-e5f6-7890-1234-567890abcdef', 'alice.guest@example.com', 'hashed_password_alice', 'guest', 'Alice', 'Smith', 'https://placehold.co/150x150/FFD166/073B4C?text=AS', '{"phone": "+11234567890", "address": "123 Guest St"}', '{"notifications": true}'),
('b2c3d4e5-f6a7-8901-2345-67890abcdef0', 'bob.host@example.com', 'hashed_password_bob', 'host', 'Bob', 'Johnson', 'https://placehold.co/150x150/06D6A0/073B4C?text=BJ', '{"phone": "+19876543210", "address": "456 Host Rd"}', '{"listing_updates": true}'),
('c3d4e5f6-a7b8-9012-3456-7890abcdef01', 'charlie.guest@example.com', 'hashed_password_charlie', 'guest', 'Charlie', 'Brown', 'https://placehold.co/150x150/118AB2/073B4C?text=CB', '{"phone": "+15551234567"}', '{"currency": "EUR"}'),
('d4e5f6a7-b8c9-0123-4567-890abcdef012', 'diana.host@example.com', 'hashed_password_diana', 'host', 'Diana', 'Prince', 'https://placehold.co/150x150/FF6B6B/073B4C?text=DP', '{"phone": "+17778889999"}', '{"payout_method": "bank"}'),
('e5f6a7b8-c9d0-1234-5678-90abcdef0123', 'admin@example.com', 'hashed_password_admin', 'admin', 'Admin', 'User', NULL, NULL, NULL);

-- Sample Properties
INSERT INTO Properties (listingId, hostId, title, description, address, city, state, zipCode, country, latitude, longitude, pricePerNight, maxGuests, bedrooms, bathrooms, propertyType, availableStartDate, availableEndDate) VALUES
('p1a2b3c4-d5e6-7890-1234-567890abcdef', 'b2c3d4e5-f6a7-8901-2345-67890abcdef0', 'Cozy Downtown Apartment', 'A beautiful and cozy apartment in the heart of the city, perfect for couples.', '101 Main St', 'Anytown', 'CA', '90210', 'USA', 34.0522, -118.2437, 120.00, 2, 1, 1.0, 'Apartment', '2025-07-15', '2025-12-31'),
('p2b3c4d5-e6f7-8901-2345-67890abcdef1', 'd4e5f6a7-b8c9-0123-4567-890abcdef012', 'Spacious Family House with Pool', 'Large house with a private pool, ideal for families. Close to attractions.', '789 Oak Ave', 'Anyville', 'FL', '33101', 'USA', 25.7617, -80.1918, 350.00, 8, 4, 2.5, 'House', '2025-08-01', '2026-06-30'),
('p3c4d5e6-f7a8-9012-3456-7890abcdef23', 'b2c3d4e5-f6a7-8901-2345-67890abcdef0', 'Seaside Cabin Retreat', 'Quaint cabin with stunning ocean views. Perfect for a peaceful getaway.', '45 Beach Rd', 'Seaside', 'OR', '97138', 'USA', 45.9930, -123.9300, 180.00, 4, 2, 1.0, 'Cabin', '2025-09-01', '2026-03-15');

-- Sample Amenities
INSERT INTO Amenities (amenityId, name) VALUES
('a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1', 'Wi-Fi'),
('b2b2b2b2-b2b2-b2b2-b2b2-b2b2b2b2b2b2', 'Pool'),
('c3c3c3c3-c3c3-c3c3-c3c3-c3c3c3c3c3c3', 'Kitchen'),
('d4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4', 'Free Parking'),
('e5e5e5e5-e5e5-e5e5-e5e5-e5e5e5e5e5e5', 'Pet-Friendly'),
('f6f6f6f6-f6f6-f6f6-f6f6-f6f6f6f6f6f6', 'Air Conditioning');

-- Sample PropertyAmenities (linking properties to amenities)
INSERT INTO PropertyAmenities (propertyId, amenityId) VALUES
('p1a2b3c4-d5e6-7890-1234-567890abcdef', 'a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1'), -- Apartment has Wi-Fi
('p1a2b3c4-d5e6-7890-1234-567890abcdef', 'c3c3c3c3-c3c3-c3c3-c3c3-c3c3c3c3c3c3'), -- Apartment has Kitchen
('p2b3c4d5-e6f7-8901-2345-67890abcdef1', 'b2b2b2b2-b2b2-b2b2-b2b2-b2b2b2b2b2b2'), -- House has Pool
('p2b3c4d5-e6f7-8901-2345-67890abcdef1', 'c3c3c3c3-c3c3-c3c3-c3c3-c3c3c3c3c3c3'), -- House has Kitchen
('p2b3c4d5-e6f7-8901-2345-67890abcdef1', 'd4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4'), -- House has Free Parking
('p3c4d5e6-f7a8-9012-3456-7890abcdef23', 'a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1'), -- Cabin has Wi-Fi
('p3c4d5e6-f7a8-9012-3456-7890abcdef23', 'd4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4'); -- Cabin has Free Parking

-- Sample PropertyImages
INSERT INTO PropertyImages (imageId, propertyId, imageUrl, caption) VALUES
('i1a2b3c4-d5e6-7890-1234-567890abcdef', 'p1a2b3c4-d5e6-7890-1234-567890abcdef', 'https://placehold.co/600x400/FFD166/073B4C?text=Apartment+Front', 'Front view of the apartment.'),
('i2b3c4d5-e6f7-8901-2345-67890abcdef1', 'p1a2b3c4-d5e6-7890-1234-567890abcdef', 'https://placehold.co/600x400/FFD166/073B4C?text=Apartment+Interior', 'Cozy living room.'),
('i3c4d5e6-f7a8-9012-3456-7890abcdef23', 'p2b3c4d5-e6f7-8901-2345-67890abcdef1', 'https://placehold.co/600x400/06D6A0/073B4C?text=House+Exterior', 'Spacious house with garden.'),
('i4d5e6f7-a8b9-0123-4567-890abcdef345', 'p2b3c4d5-e6f7-8901-2345-67890abcdef1', 'https://placehold.co/600x400/06D6A0/073B4C?text=House+Pool', 'Private swimming pool.'),
('i5e6f7a8-b9c0-1234-5678-90abcdef4567', 'p3c4d5e6-f7a8-9012-3456-7890abcdef23', 'https://placehold.co/600x400/118AB2/073B4C?text=Cabin+View', 'Ocean view from the cabin.');

-- Sample Bookings
INSERT INTO Bookings (bookingId, propertyId, guestId, checkInDate, checkOutDate, numberOfGuests, status, totalPrice) VALUES
('b1a2b3c4-d5e6-7890-1234-567890abcdef', 'p1a2b3c4-d5e6-7890-1234-567890abcdef', 'a1b2c3d4-e5f6-7890-1234-567890abcdef', '2025-08-01', '2025-08-05', 2, 'confirmed', 480.00), -- Alice books apartment
('b2c3d4e5-f6a7-8901-2345-67890abcdef0', 'p2b3c4d5-e6f7-8901-2345-67890abcdef1', 'c3d4e5f6-a7b8-9012-3456-7890abcdef01', '2025-09-10', '2025-09-17', 5, 'pending', 2450.00), -- Charlie books house
('b3d4e5f6-a7b8-9012-3456-7890abcdef01', 'p1a2b3c4-d5e6-7890-1234-567890abcdef', 'a1b2c3d4-e5f6-7890-1234-567890abcdef', '2025-07-20', '2025-07-22', 1, 'completed', 240.00); -- Alice completed a past booking

-- Sample Reviews
INSERT INTO Reviews (reviewId, bookingId, guestId, rating, comment, reviewDate, hostResponse) VALUES
('r1a2b3c4-d5e6-7890-1234-567890abcdef', 'b3d4e5f6-a7b8-9012-3456-7890abcdef01', 'a1b2c3d4-e5f6-7890-1234-567890abcdef', 5, 'Fantastic stay! Clean, comfortable, and great location.', '2025-07-23 10:00:00+00', 'Glad you enjoyed your stay, Alice!');

-- Sample Payments
INSERT INTO Payments (paymentId, bookingId, payerId, receiverId, amount, currency, transactionId, paymentDate, status, type) VALUES
('pay1a2b3c4-d5e6-7890-1234-567890abcdef', 'b1a2b3c4-d5e6-7890-1234-567890abcdef', 'a1b2c3d4-e5f6-7890-1234-567890abcdef', 'b2c3d4e5-f6a7-8901-2345-67890abcdef0', 480.00, 'USD', 'txn_123abc456def7890', '2025-07-05 14:30:00+00', 'successful', 'upfront'),
('pay2b3c4d5-e6f7-8901-2345-67890abcdef1', 'b3d4e5f6-a7b8-9012-3456-7890abcdef01', 'a1b2c3d4-e5f6-7890-1234-567890abcdef', 'b2c3d4e5-f6a7-8901-2345-67890abcdef0', 240.00, 'USD', 'txn_098fed765cba3210', '2025-07-10 11:00:00+00', 'successful', 'upfront'),
('pay3c4d5e6-f7a8-9012-3456-7890abcdef23', 'b3d4e5f6-a7b8-9012-3456-7890abcdef01', 'b2c3d4e5-f6a7-8901-2345-67890abcdef0', 'a1b2c3d4-e5f6-7890-1234-567890abcdef', 228.00, 'USD', 'payout_abc123def456', '2025-07-24 09:00:00+00', 'successful', 'payout'); -- Payout to host (assuming 5% platform fee, 240 * 0.95 = 228)

