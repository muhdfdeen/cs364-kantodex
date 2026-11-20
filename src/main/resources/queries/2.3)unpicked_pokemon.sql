/*
Finds all Gen 1 Pokémon that have never been added to any user team
*/
SELECT p.pokedex_num,
       p.name,
       p.hp,
       p.attack,
       p.defense,
       p.special,
       p.speed
FROM pokemon p
LEFT OUTER JOIN team_member tm ON p.pokedex_num = tm.pokedex_num
WHERE tm.member_id IS NULL
ORDER BY p.pokedex_num ASC
LIMIT 10 OFFSET 0;