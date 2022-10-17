SELECT MAX(first_name), MAX(last_name) FROM film
    JOIN film_actor ON film.film_id = film_actor.film_id
    JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE special_features LIKE '%Deleted Scenes%'
GROUP BY actor.actor_id;