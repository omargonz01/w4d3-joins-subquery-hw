-- Q. 1. List all customers who live in Texas (use JOINs) --------------------------------
    -- found that district = state in db
    -- select *
    -- from address;
select first_name, last_name
from customer
inner join address 
on customer.address_id = address.address_id
where address.district = 'Texas';

-- A. 1. Jennifer Davis, Kim Cruz, Richard, Mccrary, Bryan Hardison, Ian Still. ----------


-- Q. 2. Get all payments above $6.99 with the Customer's Full Name ----------------------
select amount, first_name, last_name
from payment
inner join customer
on payment.customer_id = customer.customer_id
where payment.amount > 6.99;

-- A. 2. Answer... 
-- "amount","first_name","last_name"
-- "919.67","Douglas","Graf"
-- "478.86","Mary","Smith"
-- "74.94","Alfredo","Mcadams"
-- "81.99","Harold","Martino"
-- "34.95","Mary","Smith"
-- "980.45","Mary","Smith"
-- "128.99","Peter","Menard"
-- "122.99","Peter","Menard"
-- "128.99","Peter","Menard"
-- "123.99","Peter","Menard"
-- "128.99","Peter","Menard"
-- "126.99","Peter","Menard"
-- "121.99","Peter","Menard"
-- "127.99","Peter","Menard"
-- "33.44","Alvin","Deloach"
-- "123.99","Peter","Menard"
-- "121.99","Peter","Menard"
-- "129.99","Peter","Menard"
-- "125.99","Peter","Menard"
-- "125.99","Peter","Menard"
-- "121.99","Peter","Menard"
-- "127.99","Peter","Menard"
-- "125.99","Peter","Menard"
-- "123.99","Peter","Menard"
-- "125.99","Peter","Menard"
-- "121.99","Peter","Menard"
-- "123.99","Peter","Menard"
-- "123.99","Peter","Menard"
-- "130.99","Peter","Menard" -------------------------------------------------------------


-- Q. 3.Show all customers names who have made payments over $175(use subqueries)--------- 
select first_name, last_name
from customer
where customer_id in (
    select customer_id
    from payment
    where amount > 175
);

-- A. 3. Answer: Mary Smith, Doughlas Graf. ----------------------------------------------


-- Q. 4. List all customers that live in Nepal (use the city table)-----------------------
    -- going from customer to address to city to country?
select first_name, last_name
from customer
where address_id in(
    select address.address_id
    from address
    inner join city
    on address.city_id = city.city_id
    inner join country
    on city.country_id = country.country_id
    where country.country = 'Nepal'
);

-- A. 4. Answer: Kevin Schuler -----------------------------------------------------------


-- Q. 5. Which staff member had the most transactions?------------------------------------
    -- count() not sum() dummy
    -- remember.. when using sum() or count() aka agregagate - need to use group by
    -- groub by staff.staff_id not payment.staff_id...smh 
select first_name, last_name,
count(payment.payment_id) 
from payment
inner join staff
on payment.staff_id = staff.staff_id
GROUP BY staff.staff_id
order by count desc;

-- A. 5. Answer: Jon Stephens ------------------------------------------------------------


-- Q. 6. How many movies of each rating are there? ---------------------------------------
select rating,
count(*)
from film
GROUP BY rating;

-- A. 6. Answer: 
-- "rating","count"
-- "NC-17","209"
-- "G","178"
-- "PG-13","223"
-- "PG","194"
-- "R","196"  ----------------------------------------------------------------------------


-- Q.7. 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)--
Select first_name, last_name
From customer
where customer_id in(
    select customer_id
    from payment
    where amount > 6.99
);

-- A. 7. Answer: 
-- "first_name","last_name"
-- "Mary","Smith"
-- "Peter","Menard"
-- "Harold","Martino"
-- "Douglas","Graf"
-- "Alvin","Deloach"
-- "Alfredo","Mcadams"--------------------------------------------------------------------


-- Q. 8. How many free rentals did our stores give away? ---------------------------------
    -- select amount
    -- from payment
    -- where amount <= 0; - since free means you didnt pay anything

    -- select amount
    -- from payment 
    -- where amount = 'null';
    
select count(rental.rental_id)
from rental
left join payment
on rental.rental_id = payment.rental_id
where payment.amount <= 0; 

-- A. 8. Answer: 14565? ------------------------------------------------------------------
