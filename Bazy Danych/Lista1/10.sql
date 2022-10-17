SELECT MAX(c.first_name), MAX(c.last_name) FROM customer AS c
    JOIN rental ON c.customer_id = rental.customer_id
    JOIN staff AS rs ON rental.staff_id = rs.staff_id
    JOIN payment ON rental.rental_id = payment.rental_id
    JOIN staff AS ps ON payment.staff_id = ps.staff_id
WHERE ps.staff_id <> rs.staff_id
GROUP BY c.customer_id;