CREATE DATABASE DAC;
USE DAC;

-- 41. Show all orders with amount greater than the average amount
SELECT *
FROM orders
WHERE orders.amt > (SELECT AVG(orders.amt) FROM orders);

-- 42. Show all customers with rating above the average rating
SELECT *
FROM customers
WHERE customers.rating > (SELECT AVG(customers.rating) FROM customers);

-- 43. Show all salespeople who work in the same city as any customer
SELECT *
FROM salespeople
WHERE salespeople.city IN (
      SELECT customers.city FROM customers);

-- 44. Show all customers who are served by a salesperson in the same city
SELECT *
FROM customers
WHERE customers.city = (
   SELECT salespeople.city FROM salespeople 
     WHERE salespeople.snum = customers.snum);

-- 45. Show all customers who placed an order
SELECT DISTINCT customers.*
FROM customers
JOIN orders ON customers.cnum = orders.cnum;

-- 46. Show all customers who have not placed any order
SELECT *
FROM customers
WHERE customers.cnum NOT IN (
      SELECT orders.cnum FROM orders);

-- 47. Show all salespeople who handled orders worth more than 2000
SELECT DISTINCT salespeople.*
FROM salespeople
JOIN orders ON salespeople.snum = orders.snum
WHERE orders.amt > 2000;

-- 48. Show all customers whose rating is greater than 200 and have placed an order
SELECT DISTINCT customers.*
FROM customers
JOIN orders ON customers.cnum = orders.cnum
WHERE customers.rating > 200;

-- 49. Show all customers whose city matches with any salesperson's city but are not served by that salesperson
SELECT *
FROM customers
WHERE customers.city IN (SELECT salespeople.city FROM salespeople)
  AND customers.snum NOT IN (
    SELECT salespeople.snum FROM salespeople WHERE salespeople.city = customers.city
  );

-- 50. Show orders where the salesperson and the customer are in the same city
SELECT orders.*
FROM orders
JOIN customers ON orders.cnum = customers.cnum
JOIN salespeople ON orders.snum = salespeople.snum
WHERE customers.city = salespeople.city;
