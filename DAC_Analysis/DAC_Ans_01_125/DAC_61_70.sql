CREATE DATABASE DAC;
USE DAC;

-- 61.  Show combinations of salespeople and customer names 
--      where salesperson name comes first alphabetically AND customer rating is less than 200
SELECT salespeople.sname, customers.cname
FROM salespeople, customers
WHERE salespeople.sname < customers.cname
  AND customers.rating < 200;

-- 62. Show all salespeople names and the commission they have earned (just the rate)
SELECT sname, comm
FROM salespeople;

-- 63.  Show names and cities of customers who have the same rating as Hoffman
--      Use Hoffman's customer number (not rating directly)
SELECT cname, city
FROM customers
WHERE rating = (
  SELECT rating FROM customers WHERE cname = 'Hoffman'
);

-- 64. Show salespeople for whom there are customers whose names come after theirs alphabetically
SELECT *
FROM salespeople
WHERE EXISTS (
  SELECT * FROM customers
  WHERE customers.cname > salespeople.sname
);

-- 65. Show names and ratings of customers who have above-average order amounts
SELECT DISTINCT customers.cname, customers.rating
FROM customers
JOIN orders ON customers.cnum = orders.cnum
GROUP BY customers.cnum, customers.cname, customers.rating
HAVING AVG(orders.amt) > (
  SELECT AVG(amt) FROM orders
);

-- 66. Show the total amount from all orders
SELECT SUM(amt) AS total_orders_amount
FROM orders;

-- 67. Show order number, amount, and date for all orders
SELECT onum, amt, odate
FROM orders;

-- 68. Count all rating values in the customer table (excluding NULL)
SELECT COUNT(rating) AS total_non_null_ratings
FROM customers;

-- 69. Show order number, salesperson name, and customer name for each order
SELECT orders.onum, salespeople.sname, customers.cname
FROM orders
JOIN salespeople ON orders.snum = salespeople.snum
JOIN customers ON orders.cnum = customers.cnum;

-- 70. Show commission of all salespeople serving customers in London
SELECT DISTINCT salespeople.comm
FROM salespeople
JOIN customers ON salespeople.snum = customers.snum
WHERE customers.city = 'London';
