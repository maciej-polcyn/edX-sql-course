WITH averages AS (
    SELECT mID, year, AVG(stars) AS avg_rating
    FROM Rating
    JOIN Movie USING (mID)
    GROUP BY mID, year
)
SELECT
    (SELECT AVG(avg_rating)
    FROM averages
    WHERE year < 1980) -
    (SELECT AVG(avg_rating) FROM
    averages
    WHERE year >= 1980) AS difference
