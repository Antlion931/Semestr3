INSERT INTO language(name) VALUES('Spanish');

UPDATE film SET language_id = (SELECT language_id FROM language WHERE name = 'Spanish')

WHERE film_id IN

(SELECT film.film_id FROM film
    JOIN film_actor ON film.film_id = film_actor.film_id
    JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE first_name = 'ED' AND last_name = 'CHASE');