WITH mountains AS(
  SELECT country.name AS name, 
    mountain.name AS mountain, 
    encompasses.continent AS continent,
    mountain.elevation AS height,
    
    --the mountains distance from 0.0 using the Pythagorian theorem
    
    sqrt(POWER((mountain.coordinates).latitude, 2)
      + POWER((mountain.coordinates).longitude, 2)) AS distance
      
  FROM mountain LEFT JOIN geo_mountain
    ON mountain.name = geo_mountain.mountain 
  LEFT JOIN encompasses
  ON encompasses.country = geo_mountain.country
  LEFT JOIN country
  ON geo_mountain.country = country.code
)

SELECT DISTINCT name, mountain, continent, height, distance
FROM mountains x 
WHERE distance = (SELECT min(distance) FROM mountains WHERE mountains.continent = x.continent)
ORDER BY distance;
