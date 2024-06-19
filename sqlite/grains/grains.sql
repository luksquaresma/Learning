-- Schema: CREATE TABLE "grains" ("task" TEXT, "square" INT, "result" INT);
-- Task: update the grains table and set the result based on the task (and square fields).
WITH RECURSIVE
  board (s) AS (
    SELECT
      64
    UNION ALL
    SELECT
      s - 1
    FROM
      board
    WHERE
      s > 1
  ),
  board_grains AS (
    SELECT
      POWER(2, s - 1) AS result,
      s AS square
    FROM
      board
    ORDER BY
      s ASC
  ),
  grains_squares AS (
    SELECT
      grains.task,
      grains.square,
      board_grains.result
    FROM
      grains
      LEFT JOIN board_grains ON grains.square = board_grains.square
  ),
  tot AS (
    SELECT
      TOTAL(result) AS result
      -- , task
    FROM
      board_grains
  ),
  ng AS (
    SELECT
      task,
      square,
      CASE
        WHEN task == 'single-square' THEN grains_squares.result
        ELSE tot.result
      END AS result
    FROM
      grains_squares,
      tot
  )
UPDATE grains
SET
  result = ng.result
FROM
  ng
WHERE
  grains.task = ng.task
  AND grains.square = ng.square
;