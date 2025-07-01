README: Airbnb Clone Backend Database Schema
This README.md provides an overview of the SQL script designed to establish the relational database schema for the Airbnb Clone backend.

1. Project Overview
This SQL script defines the foundational database structure for a robust and scalable Airbnb-like application. It encompasses all core entities required for a rental marketplace, including user management, property listings, booking functionalities, reviews, and payments.

2. Purpose
The primary purpose of this script is to:

Create Tables: Define the necessary tables (Users, Properties, Amenities, PropertyAmenities, PropertyImages, Bookings, Reviews, Payments).

Establish Relationships: Set up primary and foreign key constraints to enforce relationships and data integrity between entities.

Ensure Data Integrity: Implement NOT NULL constraints, CHECK constraints (e.g., for roles, prices, dates, ratings), and UNIQUE constraints (e.g., for email, amenity names, transaction IDs).

Optimize Performance: Create essential indexes on frequently queried columns to ensure efficient data retrieval and manipulation.

Support Normalization: Reflect a database design that adheres to Third Normal Form (3NF), minimizing redundancy and improving data consistency.

3. Database System
This script is specifically written for PostgreSQL. It utilizes PostgreSQL-specific features like UUID PRIMARY KEY DEFAULT gen_random_uuid() for generating unique identifiers and JSONB for flexible data storage in contactInfo and preferences columns.

4. Key Entities and Their Roles
Users: Manages all user accounts (guests, hosts, admins).

Properties: Stores details of all property listings available for rent.

Amenities: Defines a master list of available amenities (e.g., Wi-Fi, Pool).

PropertyAmenities: A junction table linking properties to their specific amenities (many-to-many relationship).

PropertyImages: Stores URLs for images associated with each property.

Bookings: Records all property reservations, including dates, guests, and status.

Reviews: Stores guest reviews and ratings for booked properties.

Payments: Manages all financial transactions, including guest payments and host payouts.

5. Normalization and Design Principles
The schema is designed to achieve Third Normal Form (3NF). This was accomplished by:

Ensuring all attributes are atomic (e.g., separating multi-valued attributes like amenities and imageUrls into their own tables).

Eliminating partial dependencies.

Removing transitive dependencies.

This design minimizes data redundancy, prevents update/delete anomalies, and enhances the overall integrity and maintainability of the database.

6. Usage
To use this script:

Install PostgreSQL: Ensure you have a PostgreSQL server running.

Connect to Database: Use a PostgreSQL client (e.g., psql, pgAdmin) to connect to your target database.

Execute Script: Run the entire SQL script. The tables will be created in the order defined, respecting foreign key dependencies.

Example using psql:

psql -U your_username -d your_database_name -f path/to/this/script.sql

7. Performance Considerations
Indexes: Indexes have been strategically placed on foreign key columns and frequently queried columns (e.g., email, city, state, country, checkInDate, checkOutDate, status, transactionId) to speed up search, filter, and join operations.

Data Types: Appropriate data types (e.g., UUID, VARCHAR, TEXT, NUMERIC, DATE, TIMESTAMP WITH TIME ZONE, JSONB) are used to optimize storage and performance.

ON DELETE Actions:

ON DELETE CASCADE: Used for dependent entities that should be removed if their parent is deleted (e.g., Properties if Users (host) is deleted, PropertyAmenities if Properties or Amenities are deleted, PropertyImages if Properties are deleted, Reviews if Bookings are deleted).

ON DELETE RESTRICT: Used for critical entities to prevent deletion if there are dependent records (e.g., preventing a User or Property from being deleted if they have active Bookings or Payments).
