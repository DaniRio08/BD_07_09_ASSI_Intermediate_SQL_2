CREATE DATABASE borja_moll;
USE borja_moll;

--Tabla students
CREATE TABLE IF NOT EXISTS students
(student_id INT AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@cifpfbmoll\\.eu$'),
birthdate DATE NOT NULL,
age INT AS (YEAR(CURDATE()) - YEAR(birthdate) - (RIGHT(CURDATE(),5) < RIGHT(birthdate,5))),
photo BLOB,
PRIMARY KEY(student_id));

--Tabla departments
CREATE TABLE IF NOT EXISTS departments
(dept_name VARCHAR(50),
classroom VARCHAR(25) UNIQUE,
budget DECIMAL(12,2),
PRIMARY KEY(dept_name));

--Tabla teachers
CREATE TABLE IF NOT EXISTS teachers
(teacher_id INT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@cifpfbmoll\\.eu$'),
department VARCHAR(50),
PRIMARY KEY(teacher_id),
FOREIGN KEY (department) REFERENCES departments (dept_name)
on delete set NULL);

--Tabla cursos
CREATE TABLE IF NOT EXISTS courses 
(course_id INT,
course_name VARCHAR(50) NOT NULL,
begin_date DATE NOT NULL,
end_date DATE AS (DATE_ADD(begin_date, INTERVAL 9 MONTH)) STORED,
entry_time TIME NOT NULL,
exit_time TIME NOT NULL CHECK(entry_time < exit_time),
PRIMARY KEY(course_id));

--Tabla takes
CREATE TABLE IF NOT EXISTS takes
(student_id INT,
course_id INT,
average_grade DECIMAL(5,2) NOT NULL CHECK (average_grade >= 0 AND average_grade <= 100),
PRIMARY KEY(student_id, course_id),
FOREIGN KEY (student_id) REFERENCES students (student_id)
on delete cascade
on update cascade,
FOREIGN KEY (course_id) REFERENCES courses (course_id)
on delete cascade
on update cascade);

--Table teaches
CREATE TABLE IF NOT EXISTS teaches
(teacher_id INT,
course_id INT,
PRIMARY KEY(teacher_id, course_id),
FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
on delete cascade
on update cascade,
FOREIGN KEY (course_id) REFERENCES courses (course_id)
on delete cascade
on update cascade);