CREATE DATABASE DAC;
USE DAC;

-- 81. Show SNUMs of all salespeople with at least one order (no repeats)
SELECT DISTINCT snum
FROM orders;

-- 82. Show all customers sorted by rating (highest first), showing rating, name, and number
SELECT rating, cname, cnum
FROM customers
ORDER BY rating DESC;

-- 83. Show average commission of salespeople in London
SELECT AVG(comm) AS average_commission
FROM salespeople
WHERE city = 'London';

-- 84. Show all orders placed through the same salesperson who serves Hoffman
SELECT *
FROM orders
WHERE snum = (
  SELECT snum FROM customers WHERE cname = 'Hoffman'
);

-- 85. Show salespeople with commission between 0.10 and 0.12 (inclusive)
SELECT *
FROM salespeople
WHERE comm BETWEEN 0.10 AND 0.12;

-- 86. Show names and cities of salespeople in London with commission above 0.10
SELECT sname, city
FROM salespeople
WHERE city = 'London' AND comm > 0.10;

-- 87. What will this query output?
SELECT * 
FROM orders 
WHERE (amt < 1000 OR NOT (
	odate = '1996-10-03' AND cnum > 2003
  )
);


-- 88. Show each customer’s smallest order
SELECT cnum, MIN(amt) AS smallest_order
FROM orders
GROUP BY cnum;

-- 89. Show the first customer in alphabetical order whose name starts with 'G'
SELECT * FROM customers
WHERE cname LIKE 'G%'
ORDER BY cname
LIMIT 1;

-- 90. Count how many different non-NULL cities exist in the customers table
SELECT COUNT(DISTINCT city) AS unique_city_count
FROM customers;
