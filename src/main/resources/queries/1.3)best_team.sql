/*
Calculates how many Pokémon are on each trainer's team and sums up their combined base stats to rank the strongest teams from highest to lowest.
*/
SELECT tt.team_id,
       tt.team_name,
       tt.trainer_name,
       COUNT(tm.member_id) AS team_size,
       SUM(p.hp + p.attack + p.defense + p.special + p.speed) AS total_team_stats
FROM trainer_team tt
JOIN team_member tm ON tt.team_id = tm.team_id
JOIN pokemon p ON tm.pokedex_num = p.pokedex_num
GROUP BY tt.team_id, tt.team_name, tt.trainer_name
ORDER BY total_team_stats DESC;