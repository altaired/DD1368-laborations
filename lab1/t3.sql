WITH country_mountains AS (

  --number of mountains per country

  SELECT geo_mountain.country, 
    count(geo_mountain.country) AS mountains
  FROM mountain
  FULL JOIN geo_mountain 
    ON mountain.name = geo_mountain.mountain
  GROUP BY country
  ORDER BY mountains DESC
), 

--above average nr mountains

many_mountains AS (
  SELECT * FROM country_mountains 
  WHERE mountains > (SELECT AVG(mountains) FROM country_mountains)
), 

--nr of countries with a certain nr of countries

top AS (
  SELECT count(country) AS count_countries, 
    mountains AS count_mountains 
  FROM many_mountains 
  GROUP BY mountains 
  ORDER BY count_countries DESC, 
    mountains DESC
) 

--max nr of countries with certain nr of mountains

SELECT * 
FROM top 
WHERE count_countries = (SELECT MAX(count_countries) 
  FROM top);
