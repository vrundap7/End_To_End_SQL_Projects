--  CASE STUDY --------------------------------------------------------

CREATE DATABASE DAC;
USE DAC;

-- Book Table
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_title VARCHAR(100),
    author VARCHAR(100),
    publisher VARCHAR(100),
    price DECIMAL(8,2)
);

-- Insert into book
INSERT INTO book (book_title, author, publisher, price) VALUES
('Database Systems', 'Elmasri', 'Pearson', 750.00),
('Operating Systems', 'Silberschatz', 'McGraw-Hill', 899.00),
('Python Programming', 'Guido Rossum', 'O\'Reilly', 499.00);

-- Member Table
CREATE TABLE member (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100),
    join_date DATE,
    membership_type VARCHAR(50)
);

-- Insert into member
INSERT INTO member (member_name, join_date, membership_type) VALUES
('Amit Shah', '2023-01-15', 'Gold'),
('Sneha Patel', '2023-03-22', 'Silver');

-- Issue Table
CREATE TABLE issue (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- Insert into issue
INSERT INTO issue (book_id, member_id, issue_date, return_date) VALUES
(1, 1, '2023-05-01', '2023-05-10'),
(2, 2, '2023-05-03', '2023-05-13'),
(3, 1, '2023-06-01', NULL);  -- Not returned yet

-- Q1. List all books
SELECT * FROM book;

-- Q2. List all members
SELECT * FROM member;

-- Q3. Show all issued books with member names
SELECT issue.issue_id, book.book_title, member.member_name, issue.issue_date, issue.return_date
FROM issue
JOIN book ON issue.book_id = book.book_id
JOIN member ON issue.member_id = member.member_id;

-- Q4. Show books not yet returned
SELECT issue.issue_id, book.book_title, member.member_name
FROM issue
JOIN book ON issue.book_id = book.book_id
JOIN member ON issue.member_id = member.member_id
WHERE issue.return_date IS NULL;

-- Q5. Show total books issued by each member
SELECT member.member_name, COUNT(issue.issue_id) AS total_books_issued
FROM member
JOIN issue ON member.member_id = issue.member_id
GROUP BY member.member_name;
