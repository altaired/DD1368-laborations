WITH combined AS(
  SELECT economy.country AS country, encompasses.continent AS continent, COALESCE(economy.GDP, 0) AS GDP
  FROM economy LEFT JOIN encompasses ON economy.country = encompasses.country
  ORDER BY encompasses.continent, GDP DESC
), top20s AS (
    SELECT continent, country, GDP
    FROM (
      SELECT 
        continent, 
        country,
        GDP,
        
       -- split by continent, then number, then select the to 20% of them
        COUNT(*) OVER (PARTITION BY continent) AS total,
        row_number() OVER 
        (PARTITION BY continent ORDER BY GDP DESC) AS rownumber
        FROM combined
    ) t
    where rownumber <= 0.20 * total
), grouped AS (
--lowest GDP of top 20%
    SELECT continent, MIN(GDP) AS GDP
    FROM top20s
    GROUP BY continent
)

SELECT grouped.continent, combined.country, combined.gdp FROM grouped
LEFT JOIN combined 
ON grouped.continent = combined.continent 
AND grouped.GDP = combined.GDP
ORDER BY combined.GDP DESC;
