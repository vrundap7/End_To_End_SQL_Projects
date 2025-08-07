CREATE DATABASE DAC;
USE DAC;

-- 71. Show salespeople who have NO customers in their city (using ALL)
SELECT * FROM salespeople
WHERE snum <> ALL (
  SELECT snum
  FROM customers
  WHERE customers.city = salespeople.city
);

-- 72. Show salespeople with customers in their city who they do NOT serve (using EXISTS)
SELECT *
FROM salespeople
WHERE EXISTS (
  SELECT * FROM customers
  WHERE customers.city = salespeople.city
    AND customers.snum <> salespeople.snum
);

-- 73. Show all customers who are served by Peel or Motika
SELECT * FROM customers
WHERE snum IN (
  SELECT snum FROM salespeople WHERE sname IN ('Peel', 'Motika')
);

-- 74. Count number of salespeople registering orders per day (only count once per day)
SELECT odate, COUNT(DISTINCT snum) AS salespeople_count
FROM orders
GROUP BY odate;

-- 75. Show all orders handled by salespeople in London
SELECT orders.*
FROM orders
JOIN salespeople ON orders.snum = salespeople.snum
WHERE salespeople.city = 'London';

-- 76. Show orders where customer and salesperson are from different cities
SELECT orders.*
FROM orders
JOIN customers ON orders.cnum = customers.cnum
JOIN salespeople ON orders.snum = salespeople.snum
WHERE customers.city <> salespeople.city;

-- 77. Show salespeople who have customers with more than one order
SELECT salespeople.*
FROM salespeople
JOIN customers ON salespeople.snum = customers.snum
JOIN orders ON customers.cnum = orders.cnum
GROUP BY salespeople.snum, salespeople.sname, salespeople.city, salespeople.comm
HAVING COUNT(orders.onum) > 1;

-- 78. Show customers assigned to salespeople who have at least one other customer with an order
SELECT *
FROM customers
WHERE EXISTS (
  SELECT *
  FROM customers AS other_customers
  JOIN orders ON other_customers.cnum = orders.cnum
  WHERE other_customers.snum = customers.snum
    AND other_customers.cnum <> customers.cnum
);

-- 79. Show all customers whose names start with 'C'
SELECT *
FROM customers
WHERE cname LIKE 'C%';

-- 80. Show highest rating in each city
SELECT city, MAX(rating) AS highest_rating
FROM customers
GROUP BY city;
