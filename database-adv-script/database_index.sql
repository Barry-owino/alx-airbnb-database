SQL CREATE INDEX Commands for Airbnb Clone Backend
-- These indexes complement the ones already defined in the CREATE TABLE statements.
-- They are specifically added based on common query patterns (WHERE, JOIN, ORDER BY, GROUP BY).

-- Index for Properties.title
-- Useful for queries that sort or group by property title,
-- or filter by title (though exact matches are less common than partial).
CREATE INDEX idx_properties_title ON Properties (title);

-- Index for Reviews.reviewDate
-- Useful for queries that order reviews by date, especially when combined with other filters.
CREATE INDEX idx_reviews_reviewDate ON Reviews (reviewDate DESC);

