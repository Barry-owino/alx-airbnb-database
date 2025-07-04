README: SQL Join Queries for Airbnb Clone Backend
This README.md provides an overview of the SQL queries demonstrated in the "SQL Join Queries for Airbnb Clone Backend" Canvas. These queries showcase various types of SQL JOIN operations to retrieve combined data from multiple tables in the Airbnb Clone database schema.

1. Purpose
The SQL queries provided serve to illustrate how to:

Combine Data: Retrieve related information from different tables (Users, Properties, Bookings, Reviews) using SQL JOIN clauses.

Understand Relationships: Demonstrate the practical application of the defined primary and foreign key relationships in the database schema.

Handle Different Scenarios: Show how INNER JOIN, LEFT JOIN, and FULL OUTER JOIN can be used to include or exclude data based on matching criteria.

2. Query Types Included
The Canvas includes examples of three fundamental SQL JOIN types:

INNER JOIN:

Purpose: Retrieves rows when there is a match in both tables based on the join condition.

Example: Used to get all bookings along with the details of the users who made those specific bookings.

LEFT JOIN (or LEFT OUTER JOIN):

Purpose: Retrieves all rows from the left table, and the matching rows from the right table. If there's no match in the right table, NULL values are returned for the right table's columns.

Example: Used to get all properties and their associated reviews. Properties without any reviews (or bookings that lead to reviews) will still be listed.

FULL OUTER JOIN:

Purpose: Retrieves all rows when there is a match in either the left or the right table. If there's no match, NULL values are returned for the columns of the non-matching table.

Example: Used to retrieve all users and all bookings, showing users who have made bookings, users who haven't, and (theoretically) bookings not linked to a user (though foreign key constraints should prevent the latter in a well-maintained database).

3. Usage
To execute these queries:

Database Setup: Ensure you have a PostgreSQL database set up with the Airbnb Clone schema and sample data (as provided in the sql-create-tables and sql-insert-statements Canvases).

SQL Client: Use any PostgreSQL-compatible SQL client (e.g., psql, pgAdmin, DBeaver).

Run Queries: Copy and paste the desired query from the "SQL Join Queries for Airbnb Clone Backend" Canvas into your SQL client and execute it.

4. Expected Output
Each query will return a result set combining columns from the joined tables. The presence of NULL values will depend on the type of join and whether matching data exists in the joined tables.
