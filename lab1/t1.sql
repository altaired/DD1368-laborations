WITH country_capital AS (
  
  --merge country and city
  
  SELECT country.name AS country, country.code, city.name AS capital, city.population AS capital_population 
  FROM country 
  LEFT JOIN city ON city.country = country.code AND city.name = country.capital
  ORDER BY country
),

--countries with the population condition

country_capital_limited AS (
  SELECT * FROM country_capital WHERE capital_population > 5000000
), provinces AS (
  SELECT country, count(country) AS provinces 
  FROM province GROUP BY country 
  ORDER BY provinces DESC
), 

shown_countries AS (
    SELECT provinces.country AS ccc, country_capital_limited.country, capital, capital_population, provinces 
    FROM country_capital_limited 
    INNER JOIN provinces 
    ON country_capital_limited.code = provinces.country 
    AND provinces.provinces > 10
), 

with_continent AS (
    SELECT * FROM shown_countries
    LEFT JOIN encompasses ON encompasses.country = ccc
)

SELECT continent, COUNT(ccc) FROM with_continent
GROUP BY continent
ORDER BY count DESC;
