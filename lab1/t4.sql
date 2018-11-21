-- Counts neigbouring countries from left -> right

WITH c1 AS (
  SELECT country1 AS country, COUNT(country1) AS count FROM borders GROUP BY country1
), 

-- Counts neighbouring countries from right -> left

c2 AS (
  SELECT country2 AS country, COUNT(country2) AS count FROM borders GROUP BY country2
), 

-- Combines the results from the ones above into a total sum and select the minimums 

total AS (
  SELECT COALESCE(c1.country, c2.country) AS CC, COALESCE(c1.count, 0) + COALESCE(c2.count, 0) as total
  FROM c1
  FULL JOIN c2 ON c1.country = c2.country
) SELECT country.name, total.total 
FROM total LEFT JOIN country ON country.code = total.CC 
WHERE total.total = (SELECT min(total) FROM total);
