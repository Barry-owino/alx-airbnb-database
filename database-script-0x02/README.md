README: Sample Data for Airbnb Clone Backend Database
This README.md provides an overview of the SQL script containing INSERT statements for populating the Airbnb Clone backend database with sample data.

1. Purpose
The sql-insert-statements script is designed to:

Populate Tables: Add realistic sample data into the Users, Properties, Amenities, PropertyAmenities, PropertyImages, Bookings, Reviews, and Payments tables.

Demonstrate Relationships: Showcase how data is linked across tables using foreign keys, reflecting the relationships defined in the database schema.

Enable Testing: Provide a quick way to set up a functional dataset for development, testing, and demonstration purposes.

2. Sample Data Overview
The script includes sample data for:

Users: A mix of guest, host, and admin roles, with realistic email addresses and placeholder hashed passwords.

Properties: Diverse property listings (apartment, house, cabin) with various details, owned by the sample hosts.

Amenities: A predefined set of common amenities (e.g., Wi-Fi, Pool, Kitchen).

PropertyAmenities: Links properties to their respective amenities.

PropertyImages: Sample image URLs for each property.

Bookings: Examples of confirmed, pending, and completed bookings made by guests on various properties.

Reviews: A sample review linked to a completed booking.

Payments: Sample payment transactions, including upfront payments by guests and payouts to hosts, demonstrating the financial flow.

3. Usage
To use this sample data script:

Ensure Schema Exists: Make sure you have already executed the CREATE TABLE statements (from the sql-create-tables Canvas) to set up the database schema. This script depends on those tables and their constraints being in place.

Connect to Database: Use a PostgreSQL client (e.g., psql, pgAdmin) to connect to your target database.

Execute Script: Run the entire SQL script. The data will be inserted into the respective tables.

Example using psql:

psql -U your_username -d your_database_name -f path/to/sql-insert-statements.sql

4. Important Notes
UUIDs: The script uses hardcoded UUIDs for primary and foreign keys for demonstration purposes. In a real application, these would typically be generated dynamically by the database (e.g., using gen_random_uuid() as specified in the CREATE TABLE statements) or by the application logic.

Password Hashes: The passwordHash values are placeholders ('hashed_password_alice', etc.). In a production environment, actual strong hashing algorithms (e.g., bcrypt) must be used.

Dates: Dates are set to future or recent past values to reflect active bookings and completed reviews.

Foreign Key Constraints: The order of INSERT statements is crucial to satisfy foreign key constraints (e.g., Users must be inserted before Properties or Bookings that reference them).
