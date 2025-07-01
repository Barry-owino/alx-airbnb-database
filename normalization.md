Database Normalization Steps for Airbnb Clone Backend
This document explains the normalization steps applied to the Airbnb Clone Backend ER Diagram to achieve Third Normal Form (3NF), addressing potential redundancies and improving data integrity.

1. Initial Schema Review (Before Normalization)
Upon reviewing the initial ER Diagram, the following potential violations of normalization principles were identified:

Property Entity - Violation of 1NF (First Normal Form):

The amenities attribute was defined as a "list of strings." In a relational database, this typically means storing multiple amenity values within a single column (e.g., "Wi-Fi, Pool, Pet-Friendly"). This violates 1NF, which requires that all attributes be atomic (indivisible) and that there are no repeating groups within a table.

Similarly, the imageUrls attribute was defined as a "list of strings (URL to cloud storage)." Storing multiple image URLs in a single column also violates 1NF.

Other Entities (User, Booking, Review, Payment):

These entities generally appeared to be in 1NF and 2NF (all non-key attributes fully depend on the primary key, and there are no partial dependencies on composite primary keys, which were not present in these tables anyway).

No immediate transitive dependencies (violation of 3NF) were apparent in these entities based on the provided attributes. For instance, in User, contactInfo and preferences are assumed to be atomic values (e.g., single JSON strings) for the purpose of this normalization. If they were to contain structured, queryable sub-attributes, further normalization might be required.

2. Normalization Steps to Achieve 3NF
To bring the database design to Third Normal Form (3NF), the primary focus was on resolving the 1NF violations in the Property entity. By addressing 1NF, and ensuring no transitive dependencies are introduced, the schema naturally moves towards 3NF.

Step 1: Resolve Multi-Valued amenities Attribute (1NF to 3NF)
Problem: The amenities attribute in the Property entity stored multiple amenity values, violating 1NF.

Solution:

Create a new entity Amenity: This entity will store unique amenity definitions.

Amenity Table:

amenityId (Primary Key)

name (e.g., 'Wi-Fi', 'Pool', 'Pet-Friendly')

Create a new junction (linking) entity PropertyAmenity: This table resolves the many-to-many relationship between Property and Amenity. A property can have many amenities, and an amenity can be offered by many properties.

PropertyAmenity Table:

propertyId (Composite Primary Key, Foreign Key referencing Property.listingId)

amenityId (Composite Primary Key, Foreign Key referencing Amenity.amenityId)

Impact on Property table: The amenities attribute is removed from the Property entity.

Step 2: Resolve Multi-Valued imageUrls Attribute (1NF to 3NF)
Problem: The imageUrls attribute in the Property entity stored multiple image URLs, violating 1NF.

Solution:

Create a new entity PropertyImage: This entity will store individual image URLs associated with a property.

PropertyImage Table:

imageId (Primary Key)

propertyId (Foreign Key referencing Property.listingId)

imageUrl

caption (optional)

Impact on Property table: The imageUrls attribute is removed from the Property entity.

3. Resulting Schema in 3NF
After these normalization steps, the database schema is in Third Normal Form (3NF).

First Normal Form (1NF): All attributes are atomic, and there are no repeating groups. This was achieved by creating separate tables for Amenity, PropertyAmenity, and PropertyImage.

Second Normal Form (2NF): All non-key attributes are fully functionally dependent on the primary key. This was already largely true for the original tables, and the new tables (Amenity, PropertyImage) inherently satisfy this. For PropertyAmenity, its non-key attributes (none in this case) would depend on the entire composite key.

Third Normal Form (3NF): There are no transitive dependencies. This means no non-key attribute is dependent on another non-key attribute. By isolating amenities and imageUrls into their own entities and linking them via foreign keys, we ensure that all attributes directly depend on their respective primary keys.

This normalized design reduces data redundancy, improves data integrity, and makes the database more flexible and easier to maintain. For example, adding a new amenity type or a new image to a property no longer requires modifying a single, potentially large string field; instead, it involves adding a new row to a dedicated table.
