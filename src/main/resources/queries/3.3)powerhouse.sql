/*
Combines top physical attackers (attack >= 110) and top special attackers (special >= 110) into a single unified ranking labeled by their offensive specialty.
*/
SELECT pokedex_num,
       name,
       attack AS stat_value,
       'Physical Powerhouse' AS offensive_role
FROM pokemon
WHERE attack >= 110
UNION
SELECT pokedex_num,
       name,
       special AS stat_value,
       'Special Powerhouse' AS offensive_role
FROM pokemon
WHERE special >= 110
ORDER BY stat_value DESC, name ASC;