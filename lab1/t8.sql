WITH RECURSIVE all_borders AS (

--Make a table that combines boarders from both directions, now have each country on both sides

    SELECT country1 AS fr, country2 AS towards FROM borders
    UNION ALL
    SELECT country2 AS fr, country1 AS towards FROM borders
), 

--The recursive part

res as (
--setup for recursion, (n is number of boarder crossings)
    SELECT fr, towards, 0 AS n
    FROM all_borders
    WHERE fr = 'S'
    
 --recursion
 
    UNION ALL
    SELECT child.fr, child.towards, n + 1
    FROM all_borders AS CHILD
    
--base case for the recursion, check for country in parent from that is the same as child in to, give childs from. max 5 steps
    
    JOIN res AS PARENT ON PARENT.fr = CHILD.towards AND n < 5
)

--give the country and minimum number boarders that you need to cross to get there

SELECT country.name, MIN(n) AS steps
FROM res
LEFT JOIN country
ON country.code = fr
GROUP BY country.name
ORDER BY steps;
