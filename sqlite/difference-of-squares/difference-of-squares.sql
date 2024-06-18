-- Schema: CREATE TABLE "difference-of-squares" ("number" INT", property" TEXT, "result" INT);
-- Task: update the difference-of-squares table and set the result based on the number and property fields.

WITH RECURSIVE cd(x) AS (
  SELECT MAX(number) AS x FROM "difference-of-squares"
  UNION ALL
  SELECT x - 1 FROM cd WHERE x > 1
),
sqs AS (
  SELECT
    x,
    SUM(POW(x, 2)) OVER (ORDER BY x) AS sum_sq,
    POW(SUM(x) OVER (ORDER BY x), 2) AS sq_sum
   FROM cd
)

UPDATE "difference-of-squares"
SET result = CASE
  WHEN property = 'differenceOfSquares'
  THEN sq_sum - sum_sq
  
  WHEN property = 'squareOfSum'
  THEN sq_sum

  WHEN property = 'sumOfSquares'
  THEN sum_sq
END
FROM sqs
WHERE number = sqs.x;
