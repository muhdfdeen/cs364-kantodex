SELECT p.pokedex_num AS '#',
       p.name AS 'Name',
       GROUP_CONCAT(t.type_name ORDER BY pt.slot SEPARATOR ' / ') AS 'Type',
       p.hp AS 'HP',
       p.attack AS 'Attack',
       p.defense AS 'Defense',
       p.special AS 'Special',
       p.speed AS 'Speed',
       p.height_m AS 'Height (m)',
       p.weight_kg AS 'Weight (kg)'
FROM pokemon p
JOIN pokemon_types pt ON p.pokedex_num = pt.pokedex_num
JOIN type t ON pt.type_id = t.type_id
GROUP BY p.pokedex_num
ORDER BY p.pokedex_num ASC;