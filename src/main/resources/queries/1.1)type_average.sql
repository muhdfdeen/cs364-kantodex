/* average base stat total for each type. Grouped by primary type.
 */

SELECT t.type_name,
    AVG(p.hp + p.attack + p.defense + p.special + p.speed) AS avg_base_stat_total
FROM pokemon p
    JOIN pokemon_types pt ON p.pokedex_num = pt.pokedex_num
    JOIN type t ON pt.type_id = t.type_id
WHERE pt.slot = 1
GROUP BY t.type_name
ORDER BY avg_base_stat_total DESC;