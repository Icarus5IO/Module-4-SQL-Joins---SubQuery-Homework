--1. List all customers who live in Texas (use JOINs)
--Answer: 599
SELECT count(distinct customer_id) as total_customers_in_texas
FROM customer
INNER JOIN address ON customer_id = customer_id
WHERE district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name
--Answer: 1,423 results found
SELECT c.first_name || ' ' || c.last_name AS full_name, p.amount
FROM payment p
INNER JOIN customer c ON p.customer_id = c.customer_id
WHERE p.amount > 6.99;

--3. Show all customers names who have made payments over $175(use subqueries)
--Answer: none(no results)
SELECT c.first_name, c.last_name
FROM customer c
WHERE EXISTS (
  SELECT 1
  FROM payment p
  WHERE p.customer_id = c.customer_id
  AND p.amount > 175
);

--4. List all the customers that live in nepal (use the city table)
--Answer: Inconclusive, upon using the first program I get 1 result. 
--Yet once I checked my answer with the second program, I get over 500 results
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
INNER JOIN address a ON c.customer_id = a.address_id
INNER JOIN city ct ON a.city_id = ct.city_id
INNER JOIN country co ON ct.country_id = co.country_id  
WHERE co.country = 'Nepal';

SELECT c.customer_id, c.first_name, c.last_name, co.country
FROM customer c
INNER JOIN address a ON c.customer_id = a.address_id
INNER JOIN country co ON co.country_id = co.country_id  
WHERE co.country = 'Nepal';

--5. Witch staff member has the most transactions?
--Answer: Mike at a count of 8,040
SELECT s.first_name, r.staff_id, COUNT(*) AS transaction_count
FROM rental r
INNER JOIN staff s ON r.staff_id = s.staff_id  -- Assuming 'staff_id' connects staff and rentals
GROUP BY r.staff_id, s.first_name
ORDER BY transaction_count DESC
LIMIT 1;

--6. How many movies of each rating are there?
--Answer: 5 (nc-17,G,PG,R,PG-13)
SELECT rating, COUNT(*) AS number_of_movies
FROM film
GROUP BY rating;

--7. Show all customers who have made a single payment above $6.99
--Answer: None
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING COUNT(p.payment_id) = 1 AND MAX(p.amount) > 6.99;

--8. How many free rentals did our store give
--Answer: 24 free rentals
SELECT COUNT(*) AS free_rentals
FROM payment p 
WHERE amount = 0;


