
--  CASE STUDY --------------------------------------------------------

CREATE DATABASE DAC;
USE DAC;

--  TABLE 1: MATERIAL
CREATE TABLE material (
    material_id INT PRIMARY KEY AUTO_INCREMENT,
    material_name VARCHAR(100)
);

INSERT INTO material (material_name) VALUES
('Brick'), ('Bitumen'), ('Sand');

-- TABLE 2: TEST
CREATE TABLE test (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    material_id INT,
    test_name VARCHAR(100),
    test_rate DECIMAL(10,2),
    FOREIGN KEY (material_id) REFERENCES material(material_id)
);

INSERT INTO test (material_id, test_name, test_rate) VALUES
(1, 'Crushing Strength', 245.00),
(1, 'Efflorescence', 185.00),
(1, 'Water Absorption', 300.00),
(2, 'Ductility', 140.00),
(2, 'Extraction', 275.00),
(2, 'Flash and fire point', 260.00),
(2, 'Penetration', 255.00),
(2, 'Viscosity', 245.00),
(3, 'Bulkage of sand', 125.00),
(3, 'Fineness Modulus', 125.00),
(3, 'Moisture Content', 200.00),
(3, 'Specific Gravity', 125.00);

-- TABLE 3: JOB
CREATE TABLE job (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    received_date DATE,
    office_name VARCHAR(100),
    letter_number VARCHAR(50),
    reference_letter_date DATE
);

INSERT INTO job (received_date, office_name, letter_number, reference_letter_date) VALUES
('2024-06-01', 'PWD Mumbai', 'PWD-123', '2024-05-30'),
('2024-06-05', 'PWD Pune', 'PWD-456', '2024-06-02');

-- TABLE 4: JOB_TEST
CREATE TABLE job_test (
    job_id INT,
    test_id INT,
    PRIMARY KEY (job_id, test_id),
    FOREIGN KEY (job_id) REFERENCES job(job_id),
    FOREIGN KEY (test_id) REFERENCES test(test_id)
);

INSERT INTO job_test (job_id, test_id) VALUES
(1, 1), -- Brick: Crushing Strength
(1, 2), -- Brick: Efflorescence
(2, 4), -- Bitumen: Penetration
(2, 5); -- Bitumen: Viscosity

-- TABLE 5: RECEIPT
CREATE TABLE receipt (
    receipt_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    received_from VARCHAR(100),
    amount DECIMAL(10,2),
    paid_by VARCHAR(50),
    mode_of_payment VARCHAR(20),
    FOREIGN KEY (job_id) REFERENCES job(job_id)
);

INSERT INTO receipt (job_id, received_from, amount, paid_by, mode_of_payment) VALUES
(1, 'PWD Mumbai', 430.00, 'Engineer Patil', 'cash'),
(2, 'PWD Pune', 500.00, 'Engineer Desai', 'cheque');


-- Q1: Retrieve details based on office name
SELECT * 
FROM job
WHERE office_name = 'PWD Mumbai';

-- Q2: Retrieve details based on job number
SELECT job.job_id, job.received_date, job.office_name, job.letter_number, job.reference_letter_date,
       test.test_name, test.test_rate
FROM job
JOIN job_test ON job.job_id = job_test.job_id
JOIN test ON job_test.test_id = test.test_id
WHERE job.job_id = 1;

-- Q3: Retrieve details based on receipt number
SELECT * 
FROM receipt
WHERE receipt_id = 1;


