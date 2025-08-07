CREATE DATABASE DAC;
USE DAC;

-- 91. Show average amount from the orders table
SELECT AVG(amt) AS average_order_amount
FROM orders;

-- 92. What would this query return?
SELECT * FROM orders 
WHERE NOT (
     odate = '1996-10-03' OR snum > 1006) AND amt >= 1500;

-- 93. Show customers who are NOT in San Jose and have rating above 200
SELECT *
FROM customers
WHERE city <> 'San Jose' AND rating > 200;

-- 94. Show all salespeople whose commission is NOT exactly 0.12
SELECT snum, sname, city, comm
FROM salespeople
WHERE comm <> 0.12;

-- 95. What does this query return?
SELECT * FROM orders 
WHERE NOT (
      (odate = '1996-10-03' AND snum > 1002) OR amt > 2000.00);

-- 96. Show salespeople serving customers not in their city
SELECT DISTINCT salespeople.*
FROM salespeople
JOIN customers ON salespeople.snum = customers.snum
WHERE salespeople.city <> customers.city;

-- 97. Show salespeople with commission > 0.11 and customers with rating < 250
SELECT DISTINCT salespeople.*
FROM salespeople
JOIN customers ON salespeople.snum = customers.snum
WHERE salespeople.comm > 0.11
  AND customers.rating < 250;

-- 98. Show salespeople from the same city but with different commissions
SELECT salespeople1.sname AS salesperson1,
       salespeople2.sname AS salesperson2,
       salespeople1.city
FROM salespeople AS salespeople1, salespeople AS salespeople2
WHERE salespeople1.city = salespeople2.city
  AND salespeople1.comm <> salespeople2.comm
  AND salespeople1.snum < salespeople2.snum;

-- 99. Show the salesperson who earned the most commission (amt × commission)
SELECT salespeople.sname,
       MAX(orders.amt * salespeople.comm) AS highest_commission_value
FROM salespeople
JOIN orders ON salespeople.snum = orders.snum;

-- 100. Does the customer who placed the most orders have the highest rating?
SELECT customers.cname, customers.rating, (
      SELECT MAX(customers_2.rating) FROM customers AS customers_2) AS highest_rating
FROM customers
WHERE customers.cnum = (
  SELECT orders.cnum
  FROM orders
  GROUP BY orders.cnum
  ORDER BY COUNT(*) DESC
  LIMIT 1
);
