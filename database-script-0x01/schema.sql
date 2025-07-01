-- SQL CREATE TABLE Statements for Airbnb Clone Backend
-- Using PostgreSQL syntax

-- Table: Users
-- Stores user profiles, authentication details, and preferences.
CREATE TABLE Users (
    userId UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    passwordHash VARCHAR(255) NOT NULL, -- Stores hashed password
    role VARCHAR(50) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    profilePhotoUrl TEXT, -- URL to cloud storage for profile picture
    contactInfo JSONB, -- Stores flexible contact details (e.g., phone, address)
    preferences JSONB, -- Stores user-specific settings/preferences
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster email lookups
CREATE INDEX idx_users_email ON Users (email);
-- Index for role-based queries
CREATE INDEX idx_users_role ON Users (role);


-- Table: Properties
-- Stores details of all property listings.
CREATE TABLE Properties (
    listingId UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    hostId UUID NOT NULL, -- Foreign Key to Users table (host)
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    zipCode VARCHAR(20),
    country VARCHAR(100) NOT NULL,
    latitude NUMERIC(10, 8), -- Optional geographical coordinates
    longitude NUMERIC(11, 8), -- Optional geographical coordinates
    pricePerNight NUMERIC(10, 2) NOT NULL CHECK (pricePerNight > 0),
    maxGuests INT NOT NULL CHECK (maxGuests > 0),
    bedrooms INT NOT NULL CHECK (bedrooms >= 0),
    bathrooms NUMERIC(4, 2) NOT NULL CHECK (bathrooms >= 0),
    propertyType VARCHAR(100) NOT NULL,
    availableStartDate DATE NOT NULL,
    availableEndDate DATE NOT NULL,
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_host
        FOREIGN KEY (hostId)
        REFERENCES Users (userId)
        ON DELETE CASCADE -- If a host is deleted, their properties are also deleted
);

-- Indexes for common search/filter criteria
CREATE INDEX idx_properties_hostId ON Properties (hostId);
CREATE INDEX idx_properties_location ON Properties (city, state, country);
CREATE INDEX idx_properties_price ON Properties (pricePerNight);
CREATE INDEX idx_properties_guests ON Properties (maxGuests);
CREATE INDEX idx_properties_availability ON Properties (availableStartDate, availableEndDate);


-- Table: Amenities
-- Stores unique amenity definitions.
CREATE TABLE Amenities (
    amenityId UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Index for amenity name lookups
CREATE INDEX idx_amenities_name ON Amenities (name);


-- Table: PropertyAmenities
-- Junction table for the many-to-many relationship between Properties and Amenities.
CREATE TABLE PropertyAmenities (
    propertyId UUID NOT NULL,
    amenityId UUID NOT NULL,
    PRIMARY KEY (propertyId, amenityId), -- Composite Primary Key
    CONSTRAINT fk_property_amenity_property
        FOREIGN KEY (propertyId)
        REFERENCES Properties (listingId)
        ON DELETE CASCADE, -- If a property is deleted, its amenity links are removed
    CONSTRAINT fk_property_amenity_amenity
        FOREIGN KEY (amenityId)
        REFERENCES Amenities (amenityId)
        ON DELETE CASCADE -- If an amenity type is deleted, its links are removed
);

-- Indexes for efficient lookups on the junction table
CREATE INDEX idx_propertyamenities_propertyId ON PropertyAmenities (propertyId);
CREATE INDEX idx_propertyamenities_amenityId ON PropertyAmenities (amenityId);


-- Table: PropertyImages
-- Stores URLs for images associated with a property.
CREATE TABLE PropertyImages (
    imageId UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    propertyId UUID NOT NULL, -- Foreign Key to Properties table
    imageUrl TEXT NOT NULL, -- URL to the image file
    caption VARCHAR(500), -- Optional caption for the image
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property_image
        FOREIGN KEY (propertyId)
        REFERENCES Properties (listingId)
        ON DELETE CASCADE -- If a property is deleted, its images are also deleted
);

-- Index for property image lookups
CREATE INDEX idx_propertyimages_propertyId ON PropertyImages (propertyId);


-- Table: Bookings
-- Stores confirmed or pending reservations of a property by a guest.
CREATE TABLE Bookings (
    bookingId UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    propertyId UUID NOT NULL, -- Foreign Key to Properties table
    guestId UUID NOT NULL, -- Foreign Key to Users table (guest)
    checkInDate DATE NOT NULL,
    checkOutDate DATE NOT NULL,
    numberOfGuests INT NOT NULL CHECK (numberOfGuests > 0),
    status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled', 'completed')),
    totalPrice NUMERIC(10, 2) NOT NULL CHECK (totalPrice > 0),
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_property
        FOREIGN KEY (propertyId)
        REFERENCES Properties (listingId)
        ON DELETE RESTRICT, -- Prevent deleting a property if it has active bookings
    CONSTRAINT fk_booking_guest
        FOREIGN KEY (guestId)
        REFERENCES Users (userId)
        ON DELETE RESTRICT, -- Prevent deleting a user if they have active bookings
    CONSTRAINT chk_dates_order
        CHECK (checkOutDate > checkInDate)
);

-- Indexes for common booking queries
CREATE INDEX idx_bookings_propertyId ON Bookings (propertyId);
CREATE INDEX idx_bookings_guestId ON Bookings (guestId);
CREATE INDEX idx_bookings_dates ON Bookings (checkInDate, checkOutDate);
CREATE INDEX idx_bookings_status ON Bookings (status);


-- Table: Reviews
-- Stores reviews and ratings left by a guest for a property after a booking.
CREATE TABLE Reviews (
    reviewId UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bookingId UUID UNIQUE NOT NULL, -- Foreign Key to Bookings table (one review per booking)
    guestId UUID NOT NULL, -- Foreign Key to Users table (guest who wrote review)
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    reviewDate TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    hostResponse TEXT, -- Optional response from the host
    CONSTRAINT fk_review_booking
        FOREIGN KEY (bookingId)
        REFERENCES Bookings (bookingId)
        ON DELETE CASCADE, -- If a booking is deleted, its review is also deleted
    CONSTRAINT fk_review_guest
        FOREIGN KEY (guestId)
        REFERENCES Users (userId)
        ON DELETE RESTRICT -- Prevent deleting a user if they have reviews
);

-- Indexes for review lookups
CREATE INDEX idx_reviews_bookingId ON Reviews (bookingId);
CREATE INDEX idx_reviews_guestId ON Reviews (guestId);
CREATE INDEX idx_reviews_rating ON Reviews (rating);


-- Table: Payments
-- Stores financial transactions related to bookings (e.g., guest payment, host payout).
CREATE TABLE Payments (
    paymentId UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bookingId UUID NOT NULL, -- Foreign Key to Bookings table
    payerId UUID NOT NULL, -- Foreign Key to Users table (who initiated payment)
    receiverId UUID NOT NULL, -- Foreign Key to Users table (who received payment)
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    currency VARCHAR(3) NOT NULL, -- e.g., 'USD', 'EUR'
    transactionId VARCHAR(255) UNIQUE NOT NULL, -- External ID from payment gateway
    paymentDate TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'successful', 'failed', 'refunded')),
    type VARCHAR(50) NOT NULL CHECK (type IN ('upfront', 'payout', 'refund')),
    CONSTRAINT fk_payment_booking
        FOREIGN KEY (bookingId)
        REFERENCES Bookings (bookingId)
        ON DELETE RESTRICT, -- Prevent deleting a booking if it has associated payments
    CONSTRAINT fk_payment_payer
        FOREIGN KEY (payerId)
        REFERENCES Users (userId)
        ON DELETE RESTRICT, -- Prevent deleting a user if they are a payer in a payment
    CONSTRAINT fk_payment_receiver
        FOREIGN KEY (receiverId)
        REFERENCES Users (userId)
        ON DELETE RESTRICT -- Prevent deleting a user if they are a receiver in a payment
);

-- Indexes for payment lookups
CREATE INDEX idx_payments_bookingId ON Payments (bookingId);
CREATE INDEX idx_payments_payerId ON Payments (payerId);
CREATE INDEX idx_payments_receiverId ON Payments (receiverId);
CREATE INDEX idx_payments_transactionId ON Payments (transactionId);
CREATE INDEX idx_payments_status ON Payments (status);
CREATE INDEX idx_payments_type ON Payments (type);

