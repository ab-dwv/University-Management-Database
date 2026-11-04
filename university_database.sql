-- University Database Assignment (MySQL 8.0+)
-- Run this file as a whole in MySQL Workbench.

CREATE DATABASE IF NOT EXISTS university;
USE university;

-- Remove only the assignment tables so the script can be run again.
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS teaches;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS department;

-- Q1-Q2: Create the six tables, keys, and relationships.
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    building VARCHAR(100) NOT NULL,
    budget DECIMAL(12,2) NOT NULL,
    CONSTRAINT chk_department_name CHECK (dept_name <> ''),
    CONSTRAINT chk_department_budget CHECK (budget >= 0)
);

CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    designation VARCHAR(60) NOT NULL,
    experience INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    dept_id INT NOT NULL,
    CONSTRAINT chk_teacher_name CHECK (name <> ''),
    CONSTRAINT chk_teacher_experience CHECK (experience >= 0),
    CONSTRAINT chk_teacher_salary CHECK (salary >= 0),
    CONSTRAINT fk_teacher_department
        FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(60) NOT NULL,
    admission_year YEAR NOT NULL,
    cgpa DECIMAL(3,2) NOT NULL,
    dept_id INT NOT NULL,
    CONSTRAINT chk_student_name CHECK (name <> ''),
    CONSTRAINT chk_student_cgpa CHECK (cgpa BETWEEN 6.00 AND 10.00),
    CONSTRAINT fk_student_department
        FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_title VARCHAR(120) NOT NULL,
    credits TINYINT NOT NULL,
    dept_id INT NOT NULL,
    CONSTRAINT chk_course_title CHECK (course_title <> ''),
    CONSTRAINT chk_course_credits CHECK (credits > 0),
    CONSTRAINT fk_course_department
        FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE teaches (
    teacher_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (teacher_id, course_id),
    CONSTRAINT fk_teaches_teacher
        FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id),
    CONSTRAINT fk_teaches_course
        FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE enrollment (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    marks DECIMAL(5,2) NOT NULL,
    attendance DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT chk_enrollment_marks CHECK (marks BETWEEN 0 AND 100),
    CONSTRAINT chk_enrollment_attendance CHECK (attendance BETWEEN 0 AND 100),
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id) REFERENCES course(course_id)
);

-- Data insertion: parent tables are inserted before child tables.
INSERT INTO department (dept_id, dept_name, building, budget) VALUES
    (1, 'Computer Science', 'Innovation Block', 850000.00),
    (2, 'Electronics and Communication', 'Technology Block', 720000.00),
    (3, 'Mechanical Engineering', 'Workshop Block', 650000.00),
    (4, 'Civil Engineering', 'Design Block', 600000.00),
    (5, 'Mathematics', 'Science Block', 450000.00),
    (6, 'Humanities', 'Liberal Arts Block', 300000.00);

INSERT INTO teacher (teacher_id, name, designation, experience, salary, dept_id) VALUES
    (101, 'Dr. Aditi Sharma', 'Professor', 14, 95000.00, 1),
    (102, 'Ms. Neha Verma', 'Assistant Professor', 6, 62000.00, 1),
    (103, 'Mr. Vivek Kumar', 'Associate Professor', 10, 78000.00, 2),
    (104, 'Dr. Arjun Mehta', 'Professor', 12, 92000.00, 2),
    (105, 'Dr. Shreya Iyer', 'Assistant Professor', 9, 70000.00, 3),
    (106, 'Ms. Kavya Nair', 'Lecturer', 4, 48000.00, 3),
    (107, 'Mr. Rahul Bose', 'Lecturer', 5, 50000.00, 6);

INSERT INTO student (student_id, name, city, admission_year, cgpa, dept_id) VALUES
    (1001, 'Aarav Gupta', 'Ghaziabad', 2022, 8.70, 1),
    (1002, 'Ananya Singh', 'Ghaziabad', 2023, 9.00, 1),
    (1003, 'Rohan Patel', 'Ghaziabad', 2024, 7.80, 2),
    (1004, 'Priya Kapoor', 'Delhi', 2022, 8.40, 2),
    (1005, 'Kabir Malhotra', 'Noida', 2023, 7.60, 1),
    (1006, 'Sneha Rao', 'Noida', 2024, 8.80, 3),
    (1007, 'Arjun Das', 'Delhi', 2022, 7.20, 1),
    (1008, 'Meera Joshi', 'Faridabad', 2023, 8.10, 2),
    (1009, 'Ishaan Roy', 'Delhi', 2024, 6.90, 4),
    (1010, 'Diya Chawla', 'Noida', 2024, 9.30, 1);

INSERT INTO course (course_id, course_title, credits, dept_id) VALUES
    (201, 'Database Management Systems', 4, 1),
    (202, 'Data Structures and Algorithms', 4, 1),
    (203, 'Artificial Intelligence', 3, 1),
    (301, 'Digital Signal Processing', 4, 2),
    (302, 'Internet of Things', 3, 2),
    (401, 'Thermodynamics', 4, 3),
    (501, 'Structural Analysis', 4, 4),
    (601, 'Linear Algebra', 3, 5);

INSERT INTO teaches (teacher_id, course_id) VALUES
    (101, 201),
    (101, 202),
    (102, 203),
    (103, 301),
    (104, 302),
    (105, 401);

INSERT INTO enrollment (student_id, course_id, marks, attendance) VALUES
    (1001, 201, 85.00, 90.00),
    (1001, 202, 78.00, 82.00),
    (1002, 201, 92.00, 95.00),
    (1002, 203, 88.00, 76.00),
    (1003, 301, 74.00, 71.00),
    (1003, 302, 81.00, 85.00),
    (1004, 301, 86.00, 88.00),
    (1005, 202, 79.00, 80.00),
    (1006, 401, 91.00, 92.00),
    (1007, 201, 68.00, 70.00),
    (1008, 302, 83.00, 78.00),
    (1009, 501, 76.00, 75.00);

-- Q1: Display all the details of every student.
SELECT *
FROM student;

-- Q2: Display the name and city of students living in Ghaziabad.
SELECT name, city
FROM student
WHERE city = 'Ghaziabad';

-- Q3: Teachers with more than 8 years of experience.
SELECT name, designation, experience
FROM teacher
WHERE experience > 8;

-- Q4: Students whose CGPA is from 7.5 to 9.0, inclusive.
SELECT name, cgpa
FROM student
WHERE cgpa BETWEEN 7.50 AND 9.00;

-- Q5: Delhi or Noida students with CGPA above 8.
SELECT name, city, cgpa
FROM student
WHERE city IN ('Delhi', 'Noida') AND cgpa > 8.00;

-- Q6: Teachers whose names start with Dr., highest salary first.
SELECT name, salary
FROM teacher
WHERE name LIKE 'Dr.%'
ORDER BY salary DESC;

-- Q7: Student count and CGPA statistics.
SELECT COUNT(*) AS total_students,
       MAX(cgpa) AS highest_cgpa,
       MIN(cgpa) AS lowest_cgpa,
       AVG(cgpa) AS average_cgpa
FROM student;

-- Q8: Student count in each city.
SELECT city, COUNT(*) AS student_count
FROM student
GROUP BY city;

-- Q9: Average CGPA for each admission year.
SELECT admission_year, AVG(cgpa) AS average_cgpa
FROM student
GROUP BY admission_year;

-- Q10: Teacher count and salary statistics for each teacher department.
SELECT dept_id,
       COUNT(*) AS teacher_count,
       MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary,
       AVG(salary) AS average_salary
FROM teacher
GROUP BY dept_id;

-- Q11: Enrollment count and average marks for each enrolled course.
SELECT course_id,
       COUNT(*) AS enrolled_students,
       AVG(marks) AS average_marks
FROM enrollment
GROUP BY course_id;

-- Q12: Cities with at least three students.
SELECT city, COUNT(*) AS student_count
FROM student
GROUP BY city
HAVING COUNT(*) >= 3;

-- Q13: Admission years whose average CGPA is greater than 8.
SELECT admission_year, AVG(cgpa) AS average_cgpa
FROM student
GROUP BY admission_year
HAVING AVG(cgpa) > 8.00;

-- Q14: Departments whose teachers earn more than 150000 in total.
SELECT dept_id, SUM(salary) AS total_salary
FROM teacher
GROUP BY dept_id
HAVING SUM(salary) > 150000;

-- Q15: High-attendance course groups with average marks above 75.
SELECT course_id,
       COUNT(*) AS student_count,
       AVG(marks) AS average_marks
FROM enrollment
WHERE attendance >= 75.00
GROUP BY course_id
HAVING AVG(marks) > 75.00;

-- Q16: Each student with their department name.
SELECT s.name AS student_name, d.dept_name
FROM student AS s
INNER JOIN department AS d ON s.dept_id = d.dept_id;

-- Q17: Each teacher with every course they teach.
SELECT t.name AS teacher_name, c.course_title
FROM teacher AS t
INNER JOIN teaches AS tc ON t.teacher_id = tc.teacher_id
INNER JOIN course AS c ON tc.course_id = c.course_id;

-- Q18: Students scoring 80 or above, with course title and marks.
SELECT s.name AS student_name, c.course_title, e.marks
FROM enrollment AS e
INNER JOIN student AS s ON e.student_id = s.student_id
INNER JOIN course AS c ON e.course_id = c.course_id
WHERE e.marks >= 80.00;

-- Q19: Each department with its number of students.
SELECT d.dept_name, COUNT(s.student_id) AS student_count
FROM department AS d
INNER JOIN student AS s ON d.dept_id = s.dept_id
GROUP BY d.dept_id, d.dept_name;

-- Q20: Every department, including departments with no teachers.
SELECT d.dept_name, COUNT(t.teacher_id) AS teacher_count
FROM department AS d
LEFT JOIN teacher AS t ON d.dept_id = t.dept_id
GROUP BY d.dept_id, d.dept_name;

-- Q21: Students who are not enrolled in any course.
SELECT s.student_id, s.name
FROM student AS s
LEFT JOIN enrollment AS e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- Q22: Every department, including departments with no students.
SELECT d.dept_name, s.name AS student_name
FROM student AS s
RIGHT JOIN department AS d ON s.dept_id = d.dept_id;

-- Q23: Every course, including courses with no enrolled student.
SELECT c.course_title, e.student_id
FROM enrollment AS e
RIGHT JOIN course AS c ON e.course_id = c.course_id;

-- Q24: FULL OUTER JOIN workaround: teachers and courses in the same department.
-- MySQL has no FULL OUTER JOIN, so LEFT JOIN and RIGHT JOIN results are combined with UNION.
SELECT t.name AS teacher_name, c.course_title, d.dept_name
FROM teacher AS t
LEFT JOIN course AS c ON t.dept_id = c.dept_id
LEFT JOIN department AS d ON COALESCE(t.dept_id, c.dept_id) = d.dept_id
UNION
SELECT t.name AS teacher_name, c.course_title, d.dept_name
FROM teacher AS t
RIGHT JOIN course AS c ON t.dept_id = c.dept_id
LEFT JOIN department AS d ON COALESCE(t.dept_id, c.dept_id) = d.dept_id;

-- Q25: FULL OUTER JOIN workaround: teachers and students in the same department.
SELECT t.name AS teacher_name, s.name AS student_name, d.dept_name
FROM teacher AS t
LEFT JOIN student AS s ON t.dept_id = s.dept_id
LEFT JOIN department AS d ON COALESCE(t.dept_id, s.dept_id) = d.dept_id
UNION
SELECT t.name AS teacher_name, s.name AS student_name, d.dept_name
FROM teacher AS t
RIGHT JOIN student AS s ON t.dept_id = s.dept_id
LEFT JOIN department AS d ON COALESCE(t.dept_id, s.dept_id) = d.dept_id;
