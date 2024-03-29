WITH landlocked AS(
  
  --cities not touching water (based on located)
  
  SELECT *
  FROM located LEFT JOIN city
    ON located.city = city.name AND 
      city.population > 3000000
  WHERE river IS NULL AND 
    lake IS NULL AND 
    sea IS NULL
)

  --count landlocked and all countries

  SELECT (SELECT count(*) AS landlocked 
      FROM landlocked), 
    count(*) AS all
  FROM city
  WHERE city.population > 3000000;
