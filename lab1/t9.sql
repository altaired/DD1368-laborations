WITH RECURSIVE donau as (
    SELECT river, name, 'Donau' AS pt, length AS len, 1 AS n
    FROM river
    WHERE name LIKE 'Donau'
    UNION ALL
    SELECT child.river, child.name, 
    CONCAT(parent.pt, ' - ', child.name), parent.len + child.length, n + 1
    FROM river AS CHILD
    JOIN donau AS PARENT ON PARENT.name = CHILD.river
), nile as (
    SELECT river, name, 'Nile' AS pt, length AS len, 1 AS n
    FROM river
    WHERE name LIKE 'Nile'
    UNION ALL
    SELECT child.river, child.name, 
    CONCAT(parent.pt, ' - ', child.name), parent.len + child.length, n + 1
    FROM river AS CHILD
    JOIN nile AS PARENT ON PARENT.name = CHILD.river
), amazon as (
    SELECT river, name, 'Amazonas' AS pt, length AS len, 1 AS n
    FROM river
    WHERE name LIKE 'Amazonas'
    UNION ALL
    SELECT child.river, child.name, 
    CONCAT(parent.pt, ' - ', child.name), parent.len + child.length, n + 1
    FROM river AS CHILD
    JOIN amazon AS PARENT ON PARENT.name = CHILD.river
), jangtse as (
    SELECT river, name, 'Yangtze' AS pt, length AS len, 1 AS n
    FROM river
    WHERE name LIKE 'Yangtze'
    UNION ALL
    SELECT child.river, child.name, 
    CONCAT(parent.pt, ' - ', child.name), parent.len + child.length, n + 1
    FROM river AS CHILD
    JOIN jangtse AS PARENT ON PARENT.name = CHILD.river
), rhein as (
    SELECT river, name, 'Rhein' AS pt, length AS len, 1 AS n
    FROM river
    WHERE name LIKE 'Rhein'
    UNION ALL
    SELECT child.river, child.name, 
    CONCAT(parent.pt, ' - ', child.name), parent.len + child.length, n + 1
    FROM river AS CHILD
    JOIN rhein AS PARENT ON PARENT.name = CHILD.river
), mississippi as (
    SELECT river, name, 'Mississippi' AS pt, length AS len, 1 AS n
    FROM river
    WHERE name LIKE 'Mississippi'
    UNION ALL
    SELECT child.river, child.name, 
    CONCAT(parent.pt, ' - ', child.name), parent.len + child.length, n + 1
    FROM river AS CHILD
    JOIN mississippi AS PARENT ON PARENT.name = CHILD.river
), all_rivers AS (
    SELECT * FROM donau WHERE n = (SELECT MAX(n) FROM donau)
    UNION ALL SELECT * FROM nile WHERE n = (SELECT MAX(n) FROM nile)
    UNION ALL SELECT * FROM jangtse WHERE n = (SELECT MAX(n) FROM jangtse)
    UNION ALL SELECT * FROM rhein WHERE n = (SELECT MAX(n) FROM rhein)
    UNION ALL SELECT * FROM amazon WHERE n = (SELECT MAX(n) FROM amazon)
    UNION ALL SELECT * FROM mississippi WHERE n = (SELECT MAX(n) FROM mississippi)
)

SELECT RANK() OVER(ORDER BY n) AS rank, pt AS path, n AS numrivers, len AS totlength FROM all_rivers
WHERE name NOT IN (SELECT river FROM river WHERE river != '')
ORDER BY numrivers;
