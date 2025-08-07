CREATE DATABASE DAC;
USE DAC;

-- 21. Show customers whose customer number is 1000 more than Serres' salesperson number
SELECT *
FROM customers
WHERE cnum = (
  SELECT snum + 1000 FROM salespeople WHERE sname = 'Serres'
);

-- 22. Show commission as percentages for all salespeople
SELECT snum, sname, comm * 100 AS commission_percent
FROM salespeople;

-- 23. Show the highest order by each salesperson on each date, but only if it's more than $3000
SELECT snum, odate, MAX(amt) AS max_amount
FROM orders
GROUP BY snum, odate
HAVING MAX(amt) > 3000;

-- 24. Show the highest order on October 3 for each salesperson
SELECT snum, MAX(amt) AS max_amount
FROM orders
WHERE odate = '1996-10-03'
GROUP BY snum;

-- 25. Show customers who live in the same city as any customer of salesperson Serres
SELECT *
FROM customers
WHERE city IN (
  SELECT city FROM customers WHERE snum = 1002
);

-- 26. Show all customers with rating above 200
SELECT *
FROM customers
WHERE rating > 200;

-- 27. Count the number of salespeople who have listed at least one order
SELECT COUNT(DISTINCT snum) AS total_salespeople_with_orders
FROM orders;

-- 28. Show customers served by salespeople with commission above 12%
SELECT customers.cname, salespeople.comm
FROM customers
JOIN salespeople ON customers.snum = salespeople.snum
WHERE salespeople.comm > 0.12;

-- 29. Show salespeople who have more than one customer
SELECT snum
FROM customers
GROUP BY snum
HAVING COUNT(*) > 1;

-- 30. Show salespeople who have customers in the same city as them
SELECT DISTINCT salespeople.*
FROM salespeople
JOIN customers ON salespeople.snum = customers.snum
WHERE salespeople.city = customers.city;