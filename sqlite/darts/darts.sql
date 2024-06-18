-- Schema: CREATE TABLE "darts" ("x" REAL, "y" REAL, score INTEGER);
-- Task: update the darts table and set the score based on the x and y values.

WITH
d AS ( SELECT x, y, SQRT( POW(ABS(x), 2) + POW(ABS(y),2) ) AS dist FROM darts ),
s AS (
  SELECT
    x,
    y,
    CASE
      WHEN dist <=  1 THEN 10
      WHEN dist <=  5 AND dist > 1 THEN  5
      WHEN dist <= 10 AND dist > 5 THEN  1
    ELSE 0 END AS score
  FROM d
)

UPDATE darts SET score = s.score FROM s WHERE darts.x = s.x AND darts.y = s.y;
