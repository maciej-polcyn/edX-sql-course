SELECT DISTINCT
    (SELECT name FROM Reviewer WHERE rID = A.rID) AS Reviewer1
    ,(SELECT name FROM Reviewer WHERE rID = B.rID) AS Reviewer2
FROM Rating A, Rating B
JOIN Reviewer USING (rID)
WHERE A.rID <> B.rID AND A.mID = B.mID AND Reviewer1 < Reviewer2
ORDER BY Reviewer1
