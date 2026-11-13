/* types whose member Pokemon have an average defense strictly greater than 75.
 */

SELECT t.type_name,
    AVG(p.defense) AS avg_defense
FROM type t
    JOIN pokemon_types pt ON t.type_id = pt.type_id
    JOIN pokemon p ON pt.pokedex_num = p.pokedex_num
GROUP BY t.type_name
HAVING AVG(p.defense) > 75
ORDER BY avg_defense DESC;