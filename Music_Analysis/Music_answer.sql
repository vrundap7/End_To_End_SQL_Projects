CREATE DATABASE MUSIC;
USE MUSIC;

-- Table 1: genre
CREATE TABLE genre (
    genre_id INTEGER PRIMARY KEY,
    name TEXT
);

-- INSERT VALUES
LOAD DATA INFILE 'C:/genre.csv'
INTO TABLE genre
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM genre;
SELECT COUNT(*) FROM genre;
----------------------------------------------------------------------------------------------------------------------

-- Table 2: media_type
CREATE TABLE media_type (
    media_type_id INTEGER PRIMARY KEY,
    name TEXT
);

-- INSERT VALUES
LOAD DATA INFILE 'C:/media_type.csv'
INTO TABLE media_type
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM media_type;
SELECT COUNT(*) FROM media_type;
-----------------------------------------------------------------------------------------------------------------------

-- Table 3: playlist
CREATE TABLE playlist (
    playlist_id INTEGER PRIMARY KEY,
    name TEXT
);

-- INSERT VALUES
LOAD DATA INFILE "C:/playlist.csv"
INTO TABLE playlist
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM playlist;
SELECT COUNT(*) FROM playlist;
-----------------------------------------------------------------------------------------------------------------------

-- Table 4: artist
CREATE TABLE artist (
    artist_id INTEGER PRIMARY KEY,
    name TEXT
);

-- INSERT VALUES
LOAD DATA INFILE "C:/artist.csv"
INTO TABLE artist
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM artist;
SELECT COUNT(*) FROM artist;
---------------------------------------------------------------------------------------------------------------------------

-- Table 5: album
CREATE TABLE album (
    album_id INT PRIMARY KEY,
    title VARCHAR(255),
    artist_id INT
);

-- INSERT VALUES
LOAD DATA INFILE "C:/album.csv"
INTO TABLE album
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM album;
SELECT COUNT(*) FROM album;
------------------------------------------------------------------------------------------------------------------------

-- Table 6: track
CREATE TABLE track (
    track_id INTEGER PRIMARY KEY,
    name TEXT,
    album_id INTEGER,
    media_type_id INTEGER,
    genre_id INTEGER,
    composer TEXT,
    milliseconds INTEGER,
    bytes INTEGER,
    unit_price REAL,
    FOREIGN KEY (album_id) REFERENCES album(album_id),
    FOREIGN KEY (media_type_id) REFERENCES media_type(media_type_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

-- INSERT VALUES
LOAD DATA INFILE "C:/track.csv"
INTO TABLE track
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM track;
SELECT COUNT(*) FROM track;

-----------------------------------------------------------------------------------------------------------------------

-- Table 7: playlist_track
CREATE TABLE playlist_track (
    playlist_id INTEGER,
    track_id INTEGER,
    PRIMARY KEY (playlist_id, track_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    FOREIGN KEY (track_id) REFERENCES track(track_id)
);

-- INSERT VALUES
LOAD DATA INFILE "C:/playlist_track.csv"
INTO TABLE playlist_track
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM playlist_track;
SELECT COUNT(*) FROM playlist_track;

---------------------------------------------------------------------------------------------------------------------

-- Table 8: employee
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    last_name VARCHAR(50),
    first_name VARCHAR(50),
    title VARCHAR(100),
    reports_to INT,
    levels VARCHAR(10),
    birthdate DATE,
    hire_date DATE,
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(10),
    country VARCHAR(50),
    postal_code VARCHAR(20),
    phone VARCHAR(30),
    fax VARCHAR(30),
    email VARCHAR(100),
    FOREIGN KEY (reports_to) REFERENCES employee(employee_id)
);

SET FOREIGN_KEY_CHECKS = 0;

LOAD DATA INFILE 'C:/emp.csv'
INTO TABLE employee
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@employee_id, @last_name, @first_name, @title, @reports_to, @levels, @birthdate, @hire_date, @address, @city, @state, @country, @postal_code, @phone, @fax, @email)
SET
  employee_id = @employee_id,
  last_name = @last_name,
  first_name = @first_name,
  title = @title,
  reports_to = NULLIF(@reports_to, ''),
  levels = @levels,
  birthdate = STR_TO_DATE(REPLACE(@birthdate, '- 0:00', ''), '%Y-%m-%d'),
  hire_date = STR_TO_DATE(REPLACE(@hire_date, '- 0:00', ''), '%Y-%m-%d'),
  address = @address,
  city = @city,
  state = @state,
  country = @country,
  postal_code = @postal_code,
  phone = @phone,
  fax = @fax,
  email = @email;

SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM employee;
SELECT COUNT(*) FROM employee;

----------------------------------------------------------------------------------------------------------------------------

-- Table 9: customer
CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    company TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    postal_code TEXT,
    phone TEXT,
    fax TEXT,
    email TEXT,
    support_rep_id INTEGER,
    FOREIGN KEY (support_rep_id) REFERENCES employee(employee_id)
);

-- INSERT VALUES
LOAD DATA INFILE "C:/customer.csv"
INTO TABLE customer
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM customer;
SELECT COUNT(*) FROM customer;
---------------------------------------------------------------------------------------------------------------------------

-- Table 10: invoice
CREATE TABLE invoice (
    invoice_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    invoice_date TEXT,
    billing_address TEXT,
    billing_city TEXT,
    billing_state TEXT,
    billing_country TEXT,
    billing_postal_code TEXT,
    total REAL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- INSERT VALUES
LOAD DATA INFILE "C:/invoice.csv"
INTO TABLE invoice
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM invoice;
SELECT COUNT(*) FROM invoice;

------------------------------------------------------------------------------------------------------------------------

-- Table 11: invoice_line
CREATE TABLE invoice_line (
    invoice_line_id INTEGER PRIMARY KEY,
    invoice_id INTEGER,
    track_id INTEGER,
    unit_price REAL,
    quantity INTEGER,
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
    FOREIGN KEY (track_id) REFERENCES track(track_id)
);

-- INSERT VALUES
LOAD DATA INFILE "C:/invoice_line.csv"
INTO TABLE invoice_line
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM invoice_line;
SELECT COUNT(*) FROM invoice_line;
----------------------------------------------------------------------------------------------------------------------

--  EASY LEVEL  --

-- 1. Who is the senior most employee based on job title?
SELECT first_name, last_name, title
FROM employee
ORDER BY title DESC
LIMIT 1;

-- 2. Which countries have the most Invoices?
SELECT billing_country, COUNT(*) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;

-- 3. What are top 3 values of total invoice?
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

-- 4. Which city has the best customers (highest total spending)
SELECT billing_city, SUM(total) AS total_revenue
FROM invoice
GROUP BY billing_city
ORDER BY total_revenue DESC
LIMIT 1;

-- 5. Best customer (most money spent)
SELECT customer.customer_id, first_name, last_name, SUM(total) AS total_spent
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, first_name, last_name
ORDER BY total_spent DESC
LIMIT 1;

--------------------------------------------------------------------------------------------------------------------------

--  MODERATE LEVEL  --

-- 1. Email, first name, last name, and Genre of all Rock music listeners
SELECT DISTINCT customer.email, customer.first_name, customer.last_name, genre.name AS genre
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
ORDER BY customer.email;

-- 2. Top 10 artists with most Rock tracks
SELECT artist.name AS artist_name, COUNT(track.track_id) AS rock_track_count
FROM track
JOIN genre ON track.genre_id = genre.genre_id
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY rock_track_count DESC
LIMIT 10;


-- 3. Tracks longer than average duration
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
    SELECT AVG(milliseconds) FROM track
)
ORDER BY milliseconds DESC;

--------------------------------------------------------------------------------------------------------------------

--  ADVANCED LEVEL  --

-- 1. Total spent by each customer on each artist
SELECT customer.first_name, customer.last_name, artist.name AS artist_name, SUM(invoice_line.unit_price * invoice_line.quantity) AS total_spent
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
GROUP BY customer.customer_id, artist.artist_id
ORDER BY total_spent DESC;

-- 2. Most popular genre in each country
WITH genre_purchase AS (
    SELECT customer.country, genre.name AS genre_name, COUNT(invoice_line.invoice_line_id) AS purchases
    FROM customer
    JOIN invoice ON customer.customer_id = invoice.customer_id
    JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
    JOIN track ON invoice_line.track_id = track.track_id
    JOIN genre ON track.genre_id = genre.genre_id
    GROUP BY customer.country, genre.name
),
ranked_genres AS (
    SELECT *,
           RANK() OVER (PARTITION BY country ORDER BY purchases DESC) AS rank_in_country
    FROM genre_purchase
)
SELECT country, genre_name, purchases
FROM ranked_genres
WHERE rank_in_country = 1;

-- 3. Top-spending customer(s) per country
WITH customer_spending AS (
    SELECT customer.customer_id, customer.first_name, customer.last_name, customer.country,
           SUM(invoice.total) AS total_spent
    FROM customer
    JOIN invoice ON customer.customer_id = invoice.customer_id
    GROUP BY customer.customer_id, customer.first_name, customer.last_name, customer.country
),
ranked_customers AS (
    SELECT *,
           RANK() OVER (PARTITION BY country ORDER BY total_spent DESC) AS rank_in_country
    FROM customer_spending
)
SELECT country, first_name, last_name, total_spent
FROM ranked_customers
WHERE rank_in_country = 1;





