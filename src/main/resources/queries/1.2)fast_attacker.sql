/*
 Finds the top 10 fastest physical attackers with at least 80 Speed.
 */

SELECT pokedex_num, name, attack, speed
FROM pokemon
WHERE speed >= 80
ORDER BY attack DESC, speed DESC
LIMIT 10;