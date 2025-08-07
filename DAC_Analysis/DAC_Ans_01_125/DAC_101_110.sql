CREATE DATABASE DAC;
USE DAC;

-- 101. Has the customer who spent the most money been given the highest rating?
SELECT customers.cname, customers.rating, MAX(customers.rating) AS highest_rating_in_table
FROM customers
JOIN (
  SELECT orders.cnum, SUM(orders.amt) AS total_spent
  FROM orders
  GROUP BY orders.cnum
  ORDER BY total_spent DESC LIMIT 1)
  AS top_spender ON customers.cnum = top_spender.cnum;

-- 102. List all customers in descending order of rating
SELECT *
FROM customers
ORDER BY rating DESC;

-- 103. On which days has Hoffman placed orders?
SELECT orders.odate
FROM orders
WHERE orders.cnum = (
  SELECT customers.cnum
  FROM customers
  WHERE customers.cname = 'Hoffman'
);


-- 104. Do all salespeople have different commissions?
SELECT COUNT(DISTINCT comm) AS unique_commissions,
       COUNT(*) AS total_salespeople
FROM salespeople;

-- 105. Salespeople who have no orders between 1996-10-03 and 1996-10-05
SELECT *
FROM salespeople
WHERE snum NOT IN (
  SELECT snum
  FROM orders
  WHERE odate BETWEEN '1996-10-03' AND '1996-10-05'
);

-- 106. How many salespeople have placed orders?
SELECT COUNT(DISTINCT snum) AS total_salespeople_with_orders
FROM orders;

-- 107. How many customers have placed orders?
SELECT COUNT(DISTINCT cnum) AS total_customers_with_orders
FROM orders;

-- 108. On which date did each salesperson book their highest order?
SELECT orders.snum, orders.odate, orders.amt
FROM orders
WHERE amt = (
  SELECT MAX(amt)
  FROM orders AS inner_orders
  WHERE inner_orders.snum = orders.snum
);

-- 109. Who is the most successful salesperson (by total order amount)?
SELECT snum, SUM(amt) AS total_sales
FROM orders
GROUP BY snum
ORDER BY total_sales DESC
LIMIT 1;

-- 110. Who is the worst customer (least total spend)?
SELECT cnum, SUM(amt) AS total_spent
FROM orders
GROUP BY cnum
ORDER BY total_spent ASC
LIMIT 1;


