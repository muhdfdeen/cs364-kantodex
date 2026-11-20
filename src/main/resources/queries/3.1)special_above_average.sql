/* lists pokemon with special stat above the average special of all pokemon.
 */

SELECT pokedex_num, name, special
FROM pokemon
WHERE special > (SELECT AVG(special)
    FROM pokemon
)
ORDER BY special DESC, name;