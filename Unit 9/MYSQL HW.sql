-- 1a
Use sakila;

select first_name, last_name from actor;

-- 1b
alter table actor add column `Actor Name` varchar(50);
UPDATE actor SET  `Actor Name` = CONCAT(first_name, ' ', last_name); 

select upper(`Actor Name`) from actor;

-- 2a
select * from actor
where first_name="JOE";

-- 2b
select last_name from actor
where last_name like "%gen%";

-- 2c
select `Actor Name` from actor
where last_name like "%li%"
order by last_name;

-- 2d 
SELECT country_id, country 
FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a
alter table actor add column `description` blob;

-- 3b
alter table actor drop column `description`;

-- 4a
SELECT last_name, COUNT(*) 
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(*) as actor_count
FROM actor
GROUP BY last_name
HAVING actor_count >= 2;

-- 4c
UPDATE actor 
SET first_name= 'HARPO'
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';

-- 4d
UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';

-- 5a 
show create table address;

-- 6a
select * from address;
select * from staff;
SELECT s.first_name, s.last_name, a.address
FROM staff s LEFT JOIN address a ON s.address_id = a.address_id;

-- 6b ***
select * from payment;
select * from staff;
SELECT s.first_name, s.last_name, SUM(p.amount) AS 'Total Amount'
FROM staff s LEFT JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name AND p.payment_date BETWEEN "2005-08-01" AND "2005-08-31";

-- 6c 
select * from film;
select * from film_actor;
SELECT f.title, COUNT(a.actor_id) AS 'Number of Actors'
FROM film f INNER JOIN film_actor a ON f.film_id = a.film_id
GROUP BY f.title;

-- 6d
select * from inventory;
select count(*) from inventory
where film_id = 439;

-- 6e
select * from payment;
select * from customer;
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'Total Amount Paid'
from customer c left join payment p on c.customer_id = p.customer_id
group by c.first_name, c.last_name
order by c.last_name;

-- 7a
select * from country;
select * from language;
SELECT title FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%' 
AND language_id="1";

-- 7b 
SELECT first_name, last_name FROM actor
WHERE actor_id IN 
(SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id from film where title='ALONE TRIP'));

-- 7c
SELECT first_name, last_name, email FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city cit ON a.city_id=cit.city_id
JOIN country cn ON cit.country_id=cn.country_id
where country="Canada";


-- 7d
select * from film;
SELECT title from film f
JOIN film_category fc on (f.film_id=fc.film_id)
where category_id="8";

-- 7e
SELECT title, COUNT(f.film_id) AS 'Frequently_Rented_Movies' FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY Frequently_Rented_Movies DESC;

-- 7f
SELECT s.store_id, SUM(p.amount) FROM payment p
JOIN staff s ON (p.staff_id=s.staff_id)
GROUP BY store_id;

-- 7g
SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cn ON (c.country_id=cn.country_id);

-- 7h
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross desc LIMIT 5;

-- 8a 
CREATE VIEW view_8a AS
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross desc LIMIT 5;

-- 8b 
select * from view_8a;

-- 8c
drop view view_8a;












