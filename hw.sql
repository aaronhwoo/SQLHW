--1A

use sakila:
Select first_name, last_name FROM actor;

--1B

use sakila;
Select UPPER(CONCAT(first_name, ' ',last_name)) AS 'Actor Name' from actor;

--2A

use sakila;
Select actor_id, first_name, last_name from actor where first_name = 'JOE';

--2B
use sakila;
Select first_name, last_name from actor where last_name like '%GEN%';

--2C
use sakila;
select last_name, first_name from actor where last_name like '%LI%' order by last_name, first_name;

--2D
use sakila;
select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');

--3A
ALTER TABLE actor
ADD description BLOB;

--3B
ALTER TABLE actor
DROP COLUMN description;

--4A
SELECT last_name, COUNT(*) 
FROM actor

--4B
SELECT last_name, COUNT(*) 
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1;

--4C
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

--4D
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

--5A
SHOW CREATE TABLE address;

--6A
SELECT staff.last_name, staff.first_name, address.address
FROM staff
INNER JOIN address ON staff.address_id = address.address_id;

--6B

SELECT staff.last_name, staff.first_name, sum(payment.amount)
FROM staff
INNER JOIN payment on staff.staff_id = payment.staff_id
GROUP BY staff.last_name, staff.first_name;

--6C

SELECT f.title, count(a.actor_id) as 'actor count'
FROM film f
INNER JOIN film_actor a ON f.film_id = a.film_id
GROUP BY f.title;

--6D

SELECT f.title, count(i.inventory_id) as 'inventory count'
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;

--6E

SELECT c.first_name, c.last_name, sum(p.amount) as 'Total Amount Paid'
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.last_name, c.first_name;

--7A

SELECT title
FROM film
WHERE film_id in (select film_id from language where language_id = 1) and title like 'K%' OR title like 'Q%';

--7B

SELECT first_name, last_name
FROM actor
WHERE actor_id IN 
(Select actor_id from film_actor where film_id in 
(Select film_id from film where title = 'Alone Trip'));

--7C

SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
INNER JOIN address a on a.address_id = cu.address_id
INNER JOIN city ci on ci.city_id = a.city_id
INNER JOIN country co on co.country_id = ci.country_id
WHERE co.country = 'Canada';


--7D

Select title
FROM ((film f
INNER JOIN film_category fc ON fc.film_id = f.film_id)
INNER JOIN category cat ON cat.category_id = fc.category_id)
WHERE cat.name = 'Family';

--7E
Select f.title, count(r.inventory_id) as 'Rental count'
from film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY count(r.inventory_id) DESC
limit 5;

--7F

select store_id, sum(p.amount) AS 'Total Revenue'
from inventory i
INNER JOIN rental r on r.inventory_id = i.inventory_id
INNER JOIN payment p on p.rental_id = r.rental_id
GROUP BY store_id;

--7G

Select s.store_id, ci.city, co.country
from store s
INNER JOIN address a on s.address_id = a.address_id
INNER JOIN city ci on ci.city_id = a.city_id
INNER JOIN country co on co.country_id = ci.country_id;

--7H

Select ca.name, sum(p.amount) AS 'Total Genre Revenue'
from category ca
INNER JOIN film_category fc on fc.category_id = ca.category_id
INNER JOIN inventory i on i.film_id = fc.film_id
INNER JOIN rental r on r.inventory_id = i.inventory_id
INNER JOIN payment p on p.rental_id = r.rental_id
GROUP BY ca.name
ORDER BY sum(p.amount) DESC
LIMIT 5;

--8A

CREATE VIEW top5genre AS
Select ca.name, sum(p.amount) AS 'Total Genre Revenue'
from category ca
INNER JOIN film_category fc on fc.category_id = ca.category_id
INNER JOIN inventory i on i.film_id = fc.film_id
INNER JOIN rental r on r.inventory_id = i.inventory_id
INNER JOIN payment p on p.rental_id = r.rental_id
GROUP BY ca.name
ORDER BY sum(p.amount) DESC
LIMIT 5;

--8B

select * from top5genre;

--8C

DROP VIEW top5genre;

--Part 2

CREATE DEFINER=`root`@`localhost` PROCEDURE `enroll_student`(
  StudentID_in varchar(45),
  CourseCode_in varchar(45),
  Section_in varchar(45),
  EndDate_in date
)
BEGIN

UPDATE classparticipant
SET EndDate = Effective_date
WHERE ID_Student = StudentID_in AND Section_in =

END