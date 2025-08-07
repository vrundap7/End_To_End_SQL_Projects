
--  CASE STUDY --------------------------------------------------------

CREATE DATABASE DAC;
USE DAC;


-- STEP 1: CREATE TABLES

-- Patient Table
CREATE TABLE patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    admission_date DATE
);

-- Doctor Table
CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100)
);

-- Appointment Table
CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    diagnosis VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

-- 🔹 STEP 2: INSERT SAMPLE VALUES

-- Insert into patient
INSERT INTO patient (patient_name, gender, age, admission_date) VALUES
('Raj Verma', 'Male', 35, '2024-06-10'),
('Neha Singh', 'Female', 29, '2024-06-12'),
('Amit Shah', 'Male', 42, '2024-07-01');

-- Insert into doctor 
INSERT INTO doctor (doctor_name, specialization) VALUES
('Dr. Arora', 'Cardiology'),
('Dr. Mehta', 'Neurology'),
('Dr. Patel', 'General Physician');

-- Insert into appointment
INSERT INTO appointment (patient_id, doctor_id, appointment_date, diagnosis) VALUES
(1, 1, '2024-06-11', 'High Blood Pressure'),
(2, 3, '2024-06-13', 'Fever'),
(3, 2, '2024-07-02', 'Migraine');

-- ✅ STEP 3: FIRST 5 QUESTIONS

-- 🔸 Q1. List all patients
SELECT * FROM patient;

-- 🔸 Q2. List all doctors
SELECT * FROM doctor;

-- 🔸 Q3. Show all appointments with patient and doctor names
SELECT appointment.appointment_id, patient.patient_name, doctor.doctor_name, appointment.appointment_date, appointment.diagnosis
FROM appointment
JOIN patient ON appointment.patient_id = patient.patient_id
JOIN doctor ON appointment.doctor_id = doctor.doctor_id;

-- 🔸 Q4. Show all appointments for "Dr. Mehta"
SELECT appointment.appointment_id, patient.patient_name, appointment.appointment_date, appointment.diagnosis
FROM appointment
JOIN patient ON appointment.patient_id = patient.patient_id
JOIN doctor ON appointment.doctor_id = doctor.doctor_id
WHERE doctor.doctor_name = 'Dr. Mehta';

-- 🔸 Q5. Show patients admitted after '2024-06-11'
SELECT patient_name, admission_date
FROM patient
WHERE admission_date > '2024-06-11';
