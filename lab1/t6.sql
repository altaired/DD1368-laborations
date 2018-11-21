
WITH tr AS(
  SELECT SUM(population) AS population
  FROM city
  WHERE latitude > 0 AND longitude > 0
), 

tl AS(
  SELECT  SUM(population) AS population
  FROM city
  WHERE latitude < 0 AND longitude > 0
), 

br AS(
  SELECT  SUM(population) AS population
  FROM city
  WHERE latitude > 0 AND longitude < 0
), 

bl AS(
  SELECT  SUM(population) AS population
  FROM city
  WHERE latitude < 0 AND longitude < 0
), 

-- Sums the population for each quarter of the earth

total AS(
  SELECT *
  FROM tr
  UNION ALL
  SELECT * 
  FROM tl
  UNION ALL 
  SELECT *
  FROM br
  UNION ALL 
  SELECT *
  FROM bl
) 
-- Unifies the result retrived for each quarter



-- Takes out the minimum and maximum and calculates the ratio between them
SELECT MIN(population) AS dividend, MAX(population) AS divisor, MIN(population)/MAX(population) AS ratio
FROM total;
