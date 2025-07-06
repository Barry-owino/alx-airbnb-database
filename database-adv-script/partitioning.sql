-- SQL Table Partitioning for Bookings Table
-- This script demonstrates how to implement range partitioning on the Bookings table
-- based on the 'checkInDate' column. This is suitable for large tables where
-- queries frequently filter data by date ranges, improving performance and manageability.

-- IMPORTANT: Before running this, if you have an existing 'Bookings' table
-- with data, you will need to:
-- 1. Rename the old table (e.g., ALTER TABLE Bookings RENAME TO old_bookings;)
-- 2. Create the new partitioned table below.
-- 3. Create the individual partitions.
-- 4. Migrate data from old_bookings to the new partitioned Bookings table
--    (e.g., INSERT INTO Bookings SELECT * FROM old_bookings;).
--    PostgreSQL will automatically route rows to the correct partition.
-- 5. Drop the old_bookings table after successful migration.

-- Step 1: Create the Master Partitioned Table for Bookings
-- This table is a conceptual parent; it will not store data directly.
-- Data will be routed to its child partitions based on the checkInDate.
CREATE TABLE Bookings (
    bookingId UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    propertyId UUID NOT NULL,
    guestId UUID NOT NULL,
    checkInDate DATE NOT NULL,
    checkOutDate DATE NOT NULL,
    numberOfGuests INT NOT NULL CHECK (numberOfGuests > 0),
    status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled', 'completed')),
    totalPrice NUMERIC(10, 2) NOT NULL CHECK (totalPrice > 0),
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_dates_order
        CHECK (checkOutDate > checkInDate)
) PARTITION BY RANGE (checkInDate);

-- Step 2: Add Foreign Key Constraints to the Master Table
-- Foreign keys are typically defined on the master table.
ALTER TABLE Bookings ADD CONSTRAINT fk_booking_property
    FOREIGN KEY (propertyId) REFERENCES Properties (listingId) ON DELETE RESTRICT;
ALTER TABLE Bookings ADD CONSTRAINT fk_booking_guest
    FOREIGN KEY (guestId) REFERENCES Users (userId) ON DELETE RESTRICT;

-- Step 3: Create Individual Partitions (Child Tables)
-- Each partition is a regular table that inherits from the master 'Bookings' table.
-- Data inserted into 'Bookings' will automatically be routed to the correct partition
-- based on the 'checkInDate' range defined here.

-- Example Partitions (by year)
CREATE TABLE bookings_2024 PARTITION OF Bookings
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF Bookings
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE bookings_2026 PARTITION OF Bookings
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- You can also create partitions for future years as needed.
-- It's common practice to create a few future partitions in advance.

-- Step 4: Add Indexes to Partitions
-- Indexes must be created on individual partitions, not the master table.
-- PostgreSQL will automatically create corresponding indexes on new partitions if
-- indexes are defined on the master table *after* partitioning, but it's good to be explicit.
-- Primary key and foreign key indexes are crucial.

-- For bookings_2024
ALTER TABLE bookings_2024 ADD CONSTRAINT bookings_2024_pkey PRIMARY KEY (bookingId);
CREATE INDEX idx_bookings_2024_propertyId ON bookings_2024 (propertyId);
CREATE INDEX idx_bookings_2024_guestId ON bookings_2024 (guestId);
CREATE INDEX idx_bookings_2024_checkInDate ON bookings_2024 (checkInDate);
CREATE INDEX idx_bookings_2024_status ON bookings_2024 (status);

-- For bookings_2025
ALTER TABLE bookings_2025 ADD CONSTRAINT bookings_2025_pkey PRIMARY KEY (bookingId);
CREATE INDEX idx_bookings_2025_propertyId ON bookings_2025 (propertyId);
CREATE INDEX idx_bookings_2025_guestId ON bookings_2025 (guestId);
CREATE INDEX idx_bookings_2025_checkInDate ON bookings_2025 (checkInDate);
CREATE INDEX idx_bookings_2025_status ON bookings_2025 (status);

-- For bookings_2026
ALTER TABLE bookings_2026 ADD CONSTRAINT bookings_2026_pkey PRIMARY KEY (bookingId);
CREATE INDEX idx_bookings_2026_propertyId ON bookings_2026 (propertyId);
CREATE INDEX idx_bookings_2026_guestId ON bookings_2026 (guestId);
CREATE INDEX idx_bookings_2026_checkInDate ON bookings_2026 (checkInDate);
CREATE INDEX idx_bookings_2026_status ON bookings_2026 (status);

-- Note on existing indexes:
-- If you had indexes like `idx_bookings_dates` on the *original* non-partitioned
-- Bookings table, you would recreate similar indexes on each partition.
-- For example:
-- CREATE INDEX idx_bookings_2025_dates ON bookings_2025 (checkInDate, checkOutDate);
-- This is important for queries that order or filter by date ranges spanning across partitions.

