CREATE DATABASE DAC;
USE DAC;

-- 111. Show all salespeople who did NOT handle any order
SELECT *
FROM salespeople
WHERE snum NOT IN (
  SELECT DISTINCT snum FROM orders
);

-- 112. Show all customers who did NOT place any order
SELECT *
FROM customers
WHERE cnum NOT IN (
  SELECT DISTINCT cnum FROM orders
);

-- 113. Find total number of orders placed by each customer
SELECT cnum, COUNT(*) AS total_orders
FROM orders
GROUP BY cnum;

-- 114. Find average order amount per customer
SELECT cnum, AVG(amt) AS average_amount
FROM orders
GROUP BY cnum;

-- 115. Show all orders with amount above the average amount of all orders
SELECT *
FROM orders
WHERE amt > (
  SELECT AVG(amt) FROM orders
);

-- 116. Show customer(s) with the highest rating
SELECT *
FROM customers
WHERE rating = (
  SELECT MAX(rating) FROM customers
);

-- 117. Show salesperson(s) with the highest commission
SELECT *
FROM salespeople
WHERE comm = (
  SELECT MAX(comm) FROM salespeople
);

-- 118. Show the number of orders placed in each city (based on customer city)
SELECT customers.city, COUNT(orders.onum) AS total_orders
FROM customers
JOIN orders ON customers.cnum = orders.cnum
GROUP BY customers.city;

-- 119. Find total sales amount (amt) handled by each salesperson
SELECT snum, SUM(amt) AS total_sales
FROM orders
GROUP BY snum;

-- 120. Show names of all customers and their salesperson's name
SELECT customers.cname AS customer_name, salespeople.sname AS salesperson_name
FROM customers
JOIN salespeople ON customers.snum = salespeople.snum;

-- 121. List all orders along with customer name and salesperson name
SELECT orders.onum, orders.odate, orders.amt,
       customers.cname AS customer_name,
       salespeople.sname AS salesperson_name
FROM orders
JOIN customers ON orders.cnum = customers.cnum
JOIN salespeople ON orders.snum = salespeople.snum;

-- 122. Show the number of customers served by each salesperson
SELECT snum, COUNT(*) AS total_customers
FROM customers
GROUP BY snum;

-- 123. Find customers who have placed more than one order
SELECT cnum, COUNT(*) AS order_count
FROM orders
GROUP BY cnum
HAVING COUNT(*) > 1;

-- 124. Find salespeople who serve more than one city
SELECT snum
FROM customers
GROUP BY snum
HAVING COUNT(DISTINCT city) > 1;

-- 125. Show customers who placed an order of more than 2000 and have rating below 150
SELECT DISTINCT customers.*
FROM customers
JOIN orders ON customers.cnum = orders.cnum
WHERE orders.amt > 2000 AND customers.rating < 150;
