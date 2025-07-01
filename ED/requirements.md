Airbnb Clone Backend: Entity-Relationship (ER) Diagram
This diagram illustrates the logical structure of the database for the Airbnb Clone backend, showing the entities, their attributes, and the relationships that connect them.

ER Diagram Notations Used:
Entity: Represented by a rectangle +----------+

Attribute: Listed within the entity rectangle. Primary Keys (PK) and Foreign Keys (FK) are explicitly noted.

Relationship: Represented by a diamond |RELATION| connecting entities.

Cardinality:

1: One

M: Many (or N)

o---: Zero or One

o----->: Zero or Many

|----->: One or Many

1. Entities and Their Attributes
A. User
Description: Represents individuals interacting with the system, either as guests, hosts, or administrators.

Attributes:

userId (PK): Unique identifier for the user.

email: User's email address (unique).

passwordHash: Hashed password for security.

role: Defines the user's role (e.g., 'guest', 'host', 'admin').

firstName: User's first name.

lastName: User's last name.

profilePhotoUrl: URL to the user's profile picture.

contactInfo: User's contact details.

preferences: User-specific settings or preferences.

B. Property
Description: Represents a single property listing available for booking.

Attributes:

listingId (PK): Unique identifier for the property listing.

hostId (FK): Links to the userId of the host who owns this property.

title: Name of the property.

description: Detailed description of the property.

address: Street address of the property.

city: City where the property is located.

state: State/Province where the property is located.

zipCode: Postal code of the property.

country: Country where the property is located.

latitude: Geographical latitude (optional).

longitude: Geographical longitude (optional).

pricePerNight: Cost to book the property for one night.

maxGuests: Maximum number of guests the property can accommodate.

bedrooms: Number of bedrooms.

bathrooms: Number of bathrooms.

amenities: List of available amenities (e.g., Wi-Fi, Pool).

propertyType: Type of property (e.g., 'Apartment', 'House').

imageUrls: URLs to property images.

availableStartDate: Date from which the property is available.

availableEndDate: Date until which the property is available.

C. Booking
Description: Represents a confirmed or pending reservation of a property by a guest.

Attributes:

bookingId (PK): Unique identifier for the booking.

propertyId (FK): Links to the listingId of the booked property.

guestId (FK): Links to the userId of the guest who made the booking.

checkInDate: Date of guest arrival.

checkOutDate: Date of guest departure.

numberOfGuests: Actual number of guests for the booking.

status: Current status of the booking (e.g., 'pending', 'confirmed', 'canceled', 'completed').

totalPrice: Total cost of the booking.

D. Review
Description: Represents a review and rating left by a guest for a property after a booking.

Attributes:

reviewId (PK): Unique identifier for the review.

bookingId (FK): Links to the bookingId for which the review was left.

guestId (FK): Links to the userId of the guest who wrote the review.

rating: Numerical rating (e.g., 1-5 stars).

comment: Textual review.

reviewDate: Timestamp when the review was submitted.

hostResponse: Optional response from the host.

E. Payment
Description: Represents a financial transaction related to a booking (e.g., guest payment, host payout).

Attributes:

paymentId (PK): Unique identifier for the payment transaction.

bookingId (FK): Links to the bookingId the payment is associated with.

payerId (FK): Links to the userId who initiated the payment (e.g., guest for upfront payment).

receiverId (FK): Links to the userId who received the payment (e.g., host for payout).

amount: The monetary value of the transaction.

currency: Currency of the transaction.

transactionId: External ID from the payment gateway.

paymentDate: Timestamp of the transaction.

status: Status of the payment (e.g., 'successful', 'failed', 'pending').

type: Type of payment ('upfront' by guest, 'payout' to host).

2. Relationships Between Entities
+----------------+       1
|      USER      |<------o----->| OWNS |----->+-------------+
|----------------|             M              |   PROPERTY  |
| PK: userId     |                            |-------------|
| email          |                            | PK: listingId |
| passwordHash   |                            | FK: hostId   |
| role           |                            | title        |
| firstName      |                            | description  |
| lastName       |                            | location     |
| profilePhotoUrl|                            | pricePerNight|
| contactInfo    |                            | maxGuests    |
| preferences    |                            | bedrooms     |
+----------------+                            | bathrooms    |
       |                                      | amenities    |
       | 1                                    | propertyType |
       o----->| MAKES |----->+-----------+   | imageUrls    |
       |             M        |  BOOKING  |   | availableStartDate |
       |                      |-----------|   | availableEndDate   |
       |                      | PK: bookingId | +-------------+
       |                      | FK: propertyId|
       |                      | FK: guestId   |
       |                      | checkInDate   |
       |                      | checkOutDate  |
       |                      | numberOfGuests|
       |                      | status        |
       |                      | totalPrice    |
       +----------------------+-----------+
                              | 1
                              o----->| HAS |----->+----------+
                              | 1              |  REVIEW  |
                              |                |----------|
                              |                | PK: reviewId |
                              |                | FK: bookingId|
                              |                | guestId      |
                              |                | rating       |
                              |                | comment      |
                              |                | reviewDate   |
                              |                | hostResponse |
                              +----------+
                              | 1
                              o----->| INVOLVES |----->+-----------+
                              | M                   |   PAYMENT   |
                              |                     |-------------|
                              |                     | PK: paymentId |
                              |                     | FK: bookingId |
                              |                     | payerId       |
                              |                     | receiverId    |
                              |                     | amount        |
                              |                     | currency      |
                              |                     | transactionId |
                              |                     | paymentDate   |
                              |                     | status        |
                              |                     | type          |
                              +-----------+

3. Relationship Explanations
USER OWNS PROPERTY (One-to-Many):

A USER with the role 'host' can OWN multiple PROPERTY listings.

Each PROPERTY is OWNED BY exactly one USER (host).

Implementation: Property entity has hostId as a Foreign Key referencing User.userId.

USER MAKES BOOKING (One-to-Many):

A USER with the role 'guest' can MAKE multiple BOOKINGs.

Each BOOKING is MADE BY exactly one USER (guest).

Implementation: Booking entity has guestId as a Foreign Key referencing User.userId.

PROPERTY HAS BOOKING (One-to-Many):

A PROPERTY can have multiple BOOKINGs associated with it over time.

Each BOOKING is FOR exactly one PROPERTY.

Implementation: Booking entity has propertyId as a Foreign Key referencing Property.listingId.

BOOKING HAS REVIEW (One-to-One):

A BOOKING can optionally HAVE one REVIEW (after completion).

A REVIEW is FOR exactly one BOOKING.

Implementation: Review entity has bookingId as a Foreign Key referencing Booking.bookingId.

BOOKING INVOLVES PAYMENT (One-to-Many):

A BOOKING can INVOLVE multiple PAYMENT transactions (e.g., an initial guest payment and a subsequent host payout).

Each PAYMENT is RELATED TO exactly one BOOKING.

Implementation: Payment entity has bookingId as a Foreign Key referencing Booking.bookingId. It also includes payerId and receiverId to link back to the User entity for clarity on payment flow.

This ER diagram provides a foundational blueprint for designing the database schema for your Airbnb Clone backend.
