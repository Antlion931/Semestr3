SELECT first_name, last_name FROM customer
    JOIN
(SELECT customer_id, AVG(amount) AS avg FROM payment GROUP BY customer_id) AS allDay ON customer.customer_id = allDay.customer_id
    JOIN
(SELECT customer_id, AVG(amount) AS avg FROM payment WHERE DATE(payment_date) = '2005-07-30' GROUP BY customer_id) AS thatDay
ON customer.customer_id = thatDay.customer_id WHERE allDay.avg < thatDay.avg;

