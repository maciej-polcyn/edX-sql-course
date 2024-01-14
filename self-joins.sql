SELECT name, title
FROM Rating A, Rating B
JOIN Reviewer USING (rID)
JOIN Movie USING(mID)
WHERE A.rID = B.rID AND A.mID = B.mID AND A.ratingDate <> B.ratingDate AND A.stars > B.stars AND A.ratingDate > B.ratingDate
