
SELECT DISTINCT last_name FROM actor
    LEFT JOIN
(SELECT actor_id AS id, count(*) AS c FROM film_actor
    JOIN film_category ON film_actor.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
WHERE name = 'Action'
GROUP BY actor_id) AS action ON actor_id = action.id

    LEFT JOIN
(SELECT actor_id AS id, count(*) AS c FROM film_actor
    JOIN film_category ON film_actor.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
WHERE name = 'Horror'
GROUP BY actor_id) AS horror ON actor_id = horror.id

WHERE action.c > horror.c OR (action.c IS NOT NULL AND horror.c IS NULL);
