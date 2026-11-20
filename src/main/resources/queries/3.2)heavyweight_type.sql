/*
Finds all Pokémon whose primary type belongs to the subset of elemental types with an average weight above 60 kg (Rock, Ice, Ground, and Dragon), sorted from heaviest to lightest.
*/
SELECT p.pokedex_num,
       p.name,
       p.weight_kg,
       t.type_name AS primary_type
FROM pokemon p
JOIN pokemon_types pt ON p.pokedex_num = pt.pokedex_num
JOIN type t ON pt.type_id = t.type_id
WHERE pt.slot = 1
  AND pt.type_id IN (
      SELECT pt2.type_id
      FROM pokemon_types pt2
      JOIN pokemon p2 ON pt2.pokedex_num = p2.pokedex_num
      GROUP BY pt2.type_id
      HAVING AVG(p2.weight_kg) > 60
  )
ORDER BY p.weight_kg DESC;