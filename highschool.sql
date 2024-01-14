-- Q1
SELECT name FROM Highschooler
WHERE ID IN (SELECT ID2
             FROM Friend
             WHERE ID1 IN (SELECT ID
                           FROM Highschooler
                           WHERE name = 'Gabriel'));

-- Q2
SELECT DISTINCT
    (SELECT name FROM Highschooler WHERE ID = ID1) AS like,
    (SELECT grade FROM Highschooler WHERE ID = ID1) AS grade_like,
    (SELECT name FROM Highschooler WHERE ID = ID2) AS being_liked,
    (SELECT grade FROM Highschooler WHERE ID = ID2) AS grade_liked
FROM Likes
JOIN Highschooler
WHERE (grade_like - grade_liked >= 2);

-- Q3
SELECT C.name, C.grade, D.name, D.grade
FROM Likes A, Likes B
JOIN Highschooler C ON C.ID = A.ID1
JOIN Highschooler D ON D.ID = B.ID1
WHERE A.ID1 = B.ID2 AND A.ID2 = B.ID1 AND C.name < D.name;

-- Q4
SELECT name, grade
FROM Highschooler
WHERE ID NOT IN (
    SELECT ID1 FROM Likes
    UNION
    SELECT ID2 FROM Likes
    );

-- Q5
SELECT C.name, C.grade, D.name, D.grade
FROM Likes, Highschooler C, Highschooler D
WHERE C.ID = ID1 AND 
      D.ID = ID2 AND 
      ID2 NOT IN (SELECT ID1 FROM Likes);

-- Q6
SELECT DISTINCT C.name, C.grade
FROM Friend
JOIN Highschooler C ON C.ID = ID1
JOIN Highschooler D ON D.ID = ID2
WHERE C.grade = D.grade AND C.ID NOT IN (
    SELECT ID1
    FROM Friend
    JOIN Highschooler C ON C.ID = ID1
    JOIN Highschooler D ON D.ID = ID2
    WHERE C.grade <> D.grade
    )
ORDER BY C.grade, C.name;

-- Q6 ALT
SELECT DISTINCT H1.name, H1.grade
FROM Friend, Highschooler H1, Highschooler H2
WHERE H1.grade = H2.grade AND H1.ID NOT IN (
    SELECT ID1
    FROM Friend
    JOIN Highschooler C ON C.ID = ID1
    JOIN Highschooler D ON D.ID = ID2
    WHERE C.grade <> D.grade
    )
ORDER BY H1.grade, H1.name;

-- Q7
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM Highschooler H1,
     Highschooler H2,
     Highschooler H3,
     Likes L,
     Friend F1,
     Friend F2
WHERE H1.ID = L.ID1 AND H2.ID = L.ID2 AND   -- H1 LIKES H2
      H1.ID = F1.ID1 AND H3.ID = F1.ID2 AND -- H1 IS FRIENDS WITH H3
      H2.ID = F2.ID1 AND H3.ID = F2.ID2 AND -- H2 IS FRIENDS WITH H3
      H2.ID NOT IN (SELECT ID2              -- H2 IS NOT FRIENDS WITH H1
                    FROM Friend
                    WHERE ID1 = H1.ID
                    );

-- Q8
SELECT
    (SELECT COUNT(*) FROM Highschooler) -
    (SELECT COUNT(DISTINCT name) FROM Highschooler);

-- Q9
SELECT name, grade
FROM Highschooler
WHERE ID IN (SELECT ID2
             FROM (SELECT ID2, count(ID2) AS liked_by
                   FROM Likes
                   GROUP BY ID2
                   HAVING liked_by > 1))