SELECT DISTINCT last_name FROM actor WHERE actor_id NOT IN

(SELECT actor.actor_id FROM actor 
    JOIN film_actor ON actor.actor_id = film_actor.actor_id
    JOIN film ON film_actor.film_id = film.film_id
WHERE title LIKE 'C%');