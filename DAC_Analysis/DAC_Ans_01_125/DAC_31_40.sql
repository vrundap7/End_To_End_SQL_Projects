CREATE DATABASE DAC;
USE DAC;

-- 31. Show salespeople whose name starts with 'P' and the fourth character is 'l'
SELECT *
FROM salespeople
WHERE sname LIKE '___l%';

-- 32. Show all orders made by customer named 'Cisneros' (without knowing customer number)
SELECT *
FROM orders
WHERE cnum = (
  SELECT cnum FROM customers WHERE cname = 'Cisneros'
);

-- 33. Show the largest orders taken by Serres and Rifkin
SELECT *
FROM orders
WHERE amt = (
  SELECT MAX(amt) FROM orders WHERE snum IN (
    SELECT snum FROM salespeople WHERE sname IN ('Serres', 'Rifkin')
  )
);

-- 34. Show the salespeople table with columns: snum, sname, comm, city
SELECT snum, sname, comm, city
FROM salespeople;

-- 35. Show all customers whose names start with A to G (alphabetically)
SELECT *
FROM customers
WHERE cname BETWEEN 'A' AND 'Gz';

-- 36. Show all possible combinations of customers
SELECT customers.cname AS customer1, customers_2.cname AS customer2
FROM customers, customers AS customers_2
WHERE customers.cname <> customers_2.cname;

-- 37. Show all orders greater than the average amount for October 4
SELECT * FROM orders
WHERE odate = '1996-10-04'
  AND amt > (
    SELECT AVG(amt) FROM orders WHERE odate = '1996-10-04'
  );

-- 38. Show names and numbers of customers with the highest rating in their city
SELECT customers.cnum, customers.cname
FROM customers
WHERE customers.rating = (
  SELECT MAX(customers_2.rating)
  FROM customers AS customers_2
  WHERE customers.city = customers_2.city
);

-- 39. Show total order amount by date, sorted from highest to lowest
SELECT odate, SUM(amt) AS total_amount
FROM orders
GROUP BY odate
ORDER BY total_amount DESC;

-- 40. Show the rating and name of each customer in San Jose
SELECT rating, cname
FROM customers
WHERE city = 'San Jose';
