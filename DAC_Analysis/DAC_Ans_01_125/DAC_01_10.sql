CREATE DATABASE DAC;
USE DAC;

--  SALESPEOPLE Table
CREATE TABLE Salespeople (
  SNUM INT PRIMARY KEY,
  SNAME VARCHAR(50),
  CITY VARCHAR(50),
  COMM DECIMAL(4,2)
);

INSERT INTO Salespeople VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rifkin', 'Barcelona', 0.15),
(1003, 'AxelRod', 'New York', 0.10),
(1005, 'Fran', 'London', 0.26);


--  CUSTOMERS Table
CREATE TABLE Customers (
  CNUM INT PRIMARY KEY,
  CNAME VARCHAR(50),
  CITY VARCHAR(50),
  RATING INT,
  SNUM INT,
  FOREIGN KEY (SNUM) REFERENCES Salespeople(SNUM)
);

INSERT INTO Customers VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Clemens', 'London', 100, 1001),
(2008, 'Cisneros', 'San Jose', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);

--  ORDERS Table
CREATE TABLE Orders (
  ONUM INT PRIMARY KEY,
  AMT DECIMAL(10,2),
  ODATE DATE,
  CNUM INT,
  SNUM INT,
  FOREIGN KEY (CNUM) REFERENCES Customers(CNUM),
  FOREIGN KEY (SNUM) REFERENCES Salespeople(SNUM)
);

INSERT INTO Orders VALUES
(3001, 18.69, '1996-10-03', 2008, 1007),
(3003, 767.19, '1996-10-03', 2001, 1001),
(3002, 1900.10, '1996-10-03', 2007, 1004),
(3005, 5160.45, '1996-10-03', 2003, 1002),
(3006, 1098.16, '1996-10-03', 2008, 1007),
(3009, 1713.23, '1996-10-04', 2002, 1003),
(3007, 75.75, '1996-10-04', 2002, 1003),
(3008, 4723.00, '1996-10-05', 2006, 1001),
(3010, 1309.95, '1996-10-06', 2004, 1002),
(3011, 9891.88, '1996-10-06', 2006, 1001);

-- 1. Show all columns from the salespeople table
SELECT snum, sname, city, comm
FROM salespeople;

-- 2. Show all customers who have a rating of 100
SELECT * FROM customers
WHERE rating = 100;

-- 3. Show all customers where the city is not mentioned (city is NULL)
SELECT * FROM customers
WHERE city IS NULL;

-- 4. Show the highest order amount for each salesperson on each order date
SELECT snum, odate, MAX(amt) AS max_amount
FROM orders
GROUP BY snum, odate;

-- 5. Show all orders sorted by customer number in descending order
SELECT * FROM orders
ORDER BY cnum DESC;

-- 6. Show the salespeople who have at least one order
SELECT DISTINCT snum
FROM orders;

-- 7. Show customer names along with their salesperson names
SELECT customers.cname, salespeople.sname
FROM customers
JOIN salespeople ON customers.snum = salespeople.snum;

-- 8. Show salespeople who have more than one customer
SELECT snum, COUNT(*) AS total_customers
FROM customers
GROUP BY snum
HAVING COUNT(*) > 1;

-- 9. Show how many orders each salesperson has, sorted from highest to lowest
SELECT snum, COUNT(*) AS total_orders
FROM orders
GROUP BY snum
ORDER BY total_orders DESC;

-- 10. Show the full customer table only if there is any customer in San Jose
SELECT *
FROM customers
WHERE EXISTS (
  SELECT * FROM customers WHERE city = 'San Jose'
);


