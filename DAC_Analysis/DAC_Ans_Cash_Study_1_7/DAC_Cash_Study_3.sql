
--  CASE STUDY --------------------------------------------------------

CREATE DATABASE DAC;
USE DAC;


-- 1. VENDORS TABLE
CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_name VARCHAR(100),
    contact_number VARCHAR(20)
);

INSERT INTO vendors (vendor_name, contact_number) VALUES
('ABC Traders', '9876543210'),
('Global Supplies', '9123456780');

-- 2. ITEMS TABLE
CREATE TABLE items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100),
    unit_price DECIMAL(10,2),
    reorder_level INT
);

INSERT INTO items (item_name, unit_price, reorder_level) VALUES
('Steel Rods', 500.00, 100),
('Copper Wires', 200.00, 50);

-- 3. PURCHASE_ORDERS TABLE
CREATE TABLE purchase_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT,
    item_id INT,
    quantity INT,
    order_date DATE,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO purchase_orders (vendor_id, item_id, quantity, order_date, amount, payment_status) VALUES
(1, 1, 150, '2024-07-01', 75000.00, 'Paid'),
(2, 2, 40, '2024-07-03', 8000.00, 'Pending');



-- 1. List all vendors
SELECT * FROM vendors;

-- 2. Show all items and their reorder levels
SELECT item_name, unit_price, reorder_level 
FROM items;

-- 3. Show all purchase orders with vendor and item names
SELECT vendors.vendor_name, items.item_name,
    purchase_orders.quantity, 
    purchase_orders.order_date,
    purchase_orders.amount,
    purchase_orders.payment_status
FROM purchase_orders
JOIN vendors ON purchase_orders.vendor_id = vendors.vendor_id
JOIN items ON purchase_orders.item_id = items.item_id;

-- 4. Show items that are below reorder level (assume current stock is 90 for Steel Rods, 40 for Copper Wires)
--    This example skips stock table, just uses VALUES manually
SELECT 
    item_name, reorder_level, 
    CASE 
        WHEN item_name = 'Steel Rods' THEN 90
        WHEN item_name = 'Copper Wires' THEN 40
    END AS current_stock
FROM items
WHERE 
    (item_name = 'Steel Rods' AND 90 < reorder_level) OR
    (item_name = 'Copper Wires' AND 40 < reorder_level);

-- 5. Show only pending payments
SELECT 
    vendors.vendor_name, 
    items.item_name, 
    purchase_orders.amount
FROM purchase_orders
JOIN vendors ON purchase_orders.vendor_id = vendors.vendor_id
JOIN items ON purchase_orders.item_id = items.item_id
WHERE purchase_orders.payment_status = 'Pending';


