CREATE DATABASE DAC;
USE DAC;


-- 51. Show each order number and the name of the customer who placed it
SELECT orders.onum, customers.cname
FROM orders
JOIN customers ON orders.cnum = customers.cnum;

-- 52. Show salespeople who have customers in their cities but don’t serve them (using JOIN)
SELECT DISTINCT salespeople.snum, salespeople.sname
FROM salespeople
JOIN customers ON salespeople.city = customers.city
WHERE salespeople.snum <> customers.snum;

-- 52 (Alternate using correlated subquery)
SELECT *
FROM salespeople
WHERE EXISTS (
  SELECT * FROM customers
  WHERE customers.city = salespeople.city
    AND customers.snum <> salespeople.snum
);

-- 53. Show all customers whose rating is equal to or greater than any rating of Serres' customers
SELECT * FROM customers
WHERE rating >= ANY (SELECT rating FROM customers WHERE snum = (
    SELECT snum FROM salespeople WHERE sname = 'Serres'
  )
);

-- 54. Show all orders placed on October 3 or October 4
SELECT *
FROM orders
WHERE odate IN ('1996-10-03', '1996-10-04');

-- 54 (Alternate using OR)
SELECT *
FROM orders
WHERE odate = '1996-10-03' OR odate = '1996-10-04';

-- 55. Show all pairs of orders by customer 'Cisneros', remove duplicates
SELECT orders1.onum AS order1, orders2.onum AS order2
FROM orders AS orders1, orders AS orders2
WHERE orders1.cnum = orders2.cnum
  AND orders1.cnum = (
    SELECT cnum FROM customers WHERE cname = 'Cisneros'
  )
  AND orders1.onum < orders2.onum;

-- 56. Show customers whose rating is higher than all customers in Rome
SELECT *
FROM customers
WHERE rating > ALL (
  SELECT rating FROM customers WHERE city = 'Rome'
);

-- 57. Show all customers with rating > 100 OR those in Rome (even if rating <= 100)
SELECT *
FROM customers
WHERE rating > 100 OR city = 'Rome';

-- 58. Show all customers assigned to salesperson number 1001
SELECT *
FROM customers
WHERE snum = 1001;

-- 59. Show orders placed on the same day as customer 'Cisneros'
SELECT * FROM orders
WHERE orders.odate IN (
  SELECT orders.odate FROM orders
	WHERE orders.cnum = (
    SELECT customers.cnum FROM customers
	WHERE customers.cname = 'Cisneros'
  )
);

-- 60. Show salespeople who handled orders from more than 1 customer
SELECT salespeople.snum, salespeople.sname
FROM salespeople
JOIN orders ON salespeople.snum = orders.snum
GROUP BY salespeople.snum, salespeople.sname
HAVING COUNT(DISTINCT orders.cnum) > 1;
