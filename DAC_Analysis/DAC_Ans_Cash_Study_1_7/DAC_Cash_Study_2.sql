
--  CASE STUDY --------------------------------------------------------

CREATE DATABASE DAC;
USE DAC;

-- STUDENT TABLE
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100),
    roll_no VARCHAR(20),
    course VARCHAR(50),
    semester INT
);

INSERT INTO students (student_name, roll_no, course, semester) VALUES
('Rahul Sharma', 'BSC202301', 'BSc CS', 3),
('Anjali Mehta', 'BSC202302', 'BSc CS', 3),
('Ravi Desai', 'BCOM202310', 'BCom', 4);

-- EXAM TABLE
CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_name VARCHAR(100),
    marks_obtained INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO exams (student_id, subject_name, marks_obtained) VALUES
(1, 'Data Structures', 78),
(1, 'Operating Systems', 88),
(2, 'Data Structures', 85),
(3, 'Accounting', 67);

-- 1. List all students
SELECT students.student_id, students.student_name, students.roll_no, 
       students.course, students.semester
FROM students;

-- 2. Show all exam results with student names
SELECT 
    students.student_name, 
    exams.subject_name, 
    exams.marks_obtained
FROM exams
JOIN students ON exams.student_id = students.student_id;

-- 3. Find total marks scored by each student
SELECT 
    students.student_name, 
    SUM(exams.marks_obtained) AS total_marks
FROM students
JOIN exams ON students.student_id = exams.student_id
GROUP BY students.student_id, students.student_name;

-- 4. Show subject-wise average marks
SELECT 
    exams.subject_name, 
    AVG(exams.marks_obtained) AS average_marks
FROM exams
GROUP BY exams.subject_name;

-- 5. Show students who scored above 80 in any subject
SELECT 
    students.student_name, 
    exams.subject_name, 
    exams.marks_obtained
FROM exams
JOIN students ON exams.student_id = students.student_id
WHERE exams.marks_obtained > 80;


