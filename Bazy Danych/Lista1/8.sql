SELECT DISTINCT title FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
WHERE DATE(rental_date) BETWEEN '2005-05-31' AND '2005-06-15'
ORDER BY title ASC;