SELECT MAX(a1.first_name), MAX(a1.last_name), MAX(a2.first_name), MAX(a2.last_name), count(*) FROM actor AS a1
    JOIN film_actor AS fa1 ON a1.actor_id = fa1.actor_id
    JOIN film_actor AS fa2 ON fa1.film_id = fa2.film_id
    JOIN actor AS a2 ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id < a2.actor_id
GROUP BY a1.actor_id, a2.actor_id
HAVING count(*) > 1;