-- Q1
INSERT INTO Reviewer (rID, name)
VALUES (209, 'Roger Ebert');

-- Q2
UPDATE Movie
SET year = year + 25
WHERE mID IN (SELECT mID
  FROM (SELECT mID, AVG(stars)
        FROM Rating
        GROUP BY mID
        HAVING AVG(stars) >= 4));

-- Q3
DELETE FROM Rating
WHERE (
    mID IN (
        SELECT mID
        FROM Movie
        WHERE year NOT BETWEEN 1970 AND 2000) AND
    stars < 4);

