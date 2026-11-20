/*
Displays a trainer's complete team roster with nicknames, species names, levels, and primary elemental types
*/

SELECT tt.team_name,
       tt.trainer_name,
       tm.roster_slot,
       tm.nickname,
       p.name AS species_name,
       tm.level,
       t.type_name AS primary_type
FROM trainer_team tt
JOIN team_member tm ON tt.team_id = tm.team_id
JOIN pokemon p ON tm.pokedex_num = p.pokedex_num
JOIN pokemon_types pt ON p.pokedex_num = pt.pokedex_num
JOIN type t ON pt.type_id = t.type_id
WHERE pt.slot = 1 AND tt.team_id = 1
ORDER BY tm.roster_slot ASC;