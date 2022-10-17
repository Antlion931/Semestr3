SELECT MAX(first_name), MAX(last_name) FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
HAVING count(*) > 

(SELECT count(*) FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
WHERE email = 'MARY.SMITH@sakilacustomer.org');