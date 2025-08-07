
--  CASE STUDY --------------------------------------------------------

CREATE DATABASE DAC;
USE DAC;

-- SUPPLIERS TABLE
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20)
);

INSERT INTO suppliers (supplier_name, address, phone) VALUES
('ABC Traders', 'Mumbai', '9876543210'),
('Global Supply Co.', 'Delhi', '9123456780');

-- CUSTOMERSs TABLE
CREATE TABLE customerss (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20)
);

INSERT INTO customerss (customer_name, address, phone) VALUES
('Vikas Engineering', 'Pune', '9845123456'),
('Omega Pvt. Ltd.', 'Hyderabad', '9745234567');

-- TRANSACTIONS TABLE
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_type ENUM('invoice', 'payment', 'receipt') NOT NULL,
    party_type ENUM('supplier', 'customer') NOT NULL,
    party_id INT NOT NULL,
    transaction_date DATE,
    amount DECIMAL(10,2),
    remarks TEXT
);

INSERT INTO transactions (transaction_type, party_type, party_id, transaction_date, amount, remarks) VALUES
('invoice', 'supplier', 1, '2023-06-10', 15000.00, 'Invoice from ABC Traders'),
('invoice', 'supplier', 2, '2023-06-15', 32000.50, 'Invoice from Global Supply Co.'),
('payment', 'supplier', 1, '2023-06-20', 15000.00, 'Payment to ABC Traders'),
('receipt', 'customer', 1, '2023-06-21', 25000.00, 'Payment from Vikas Engineering'),
('receipt', 'customer', 2, '2023-06-29', 12000.00, 'Payment from Omega Pvt. Ltd.');



-- 1. Total invoice amount per supplier
SELECT 
    suppliers.supplier_name,
    SUM(transactions.amount) AS total_invoiced
FROM suppliers
JOIN transactions 
    ON transactions.party_type = 'supplier' 
    AND transactions.party_id = suppliers.supplier_id
WHERE transactions.transaction_type = 'invoice'
GROUP BY suppliers.supplier_id;

-- 2. Total payment made per supplier
SELECT 
    suppliers.supplier_name,
    SUM(transactions.amount) AS total_paid
FROM suppliers
JOIN transactions 
    ON transactions.party_type = 'supplier' 
    AND transactions.party_id = suppliers.supplier_id
WHERE transactions.transaction_type = 'payment'
GROUP BY suppliers.supplier_id;

-- 3. Total receipt amount from each customer
SELECT 
    customerss.customer_name,
    SUM(transactions.amount) AS total_received
FROM customerss
JOIN transactions 
    ON transactions.party_type = 'customer' 
    AND transactions.party_id = customerss.customer_id
WHERE transactions.transaction_type = 'receipt'
GROUP BY customerss.customer_id;

-- 4. Supplier-wise outstanding balance
SELECT 
    suppliers.supplier_name,
    SUM(CASE WHEN transactions.transaction_type = 'invoice' THEN transactions.amount ELSE 0 END) -
    SUM(CASE WHEN transactions.transaction_type = 'payment' THEN transactions.amount ELSE 0 END) 
    AS outstanding_balance
FROM suppliers
JOIN transactions 
    ON transactions.party_type = 'supplier' 
    AND transactions.party_id = suppliers.supplier_id
GROUP BY suppliers.supplier_id;

-- 5. All transactions for a given customer (e.g., customer_id = 1)
SELECT * 
FROM transactions
WHERE party_type = 'customer' AND party_id = 1
ORDER BY transaction_date;

-- 6. Total net balance per customer
SELECT 
    customerss.customer_name,
    SUM(CASE 
        WHEN transactions.transaction_type = 'receipt' THEN transactions.amount 
        ELSE 0 
    END) AS total_received
FROM customerss
JOIN transactions 
    ON transactions.party_type = 'customer' 
    AND transactions.party_id = customerss.customer_id
GROUP BY customerss.customer_id;


