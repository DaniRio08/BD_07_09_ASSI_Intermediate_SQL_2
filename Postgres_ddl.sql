CREATE DATABASE borja_moll;
\c borja_moll;

--Dominio
CREATE DOMAIN email_borjamoll AS VARCHAR(255)
NOT NULL
CHECK (VALUE ~* '^[A-Za-z0-9._%+-]+@cifpfbmoll\.eu$');

-- Ver los dominios que hay en la base de datos
-- SELECT domain_name, data_type 
-- FROM information_schema.domains 
-- WHERE domain_catalog = 'borja_moll';

--Tabla students
CREATE TABLE IF NOT EXISTS students
(student_id SERIAL NOT NULL,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email email_borjamoll,
birthdate DATE NOT NULL CHECK(birthdate < now()),
age INTEGER,
photo BYTEA,
PRIMARY KEY(student_id));
--we couldn't manage to create a function to automatically generate the age in postgres

--Tabla departments
CREATE TABLE IF NOT EXISTS departments
(dept_name VARCHAR(50) NOT NULL,
classroom VARCHAR(25) UNIQUE,
budget DECIMAL(12,2),
PRIMARY KEY(dept_name));

--Tabla teachers
CREATE TABLE IF NOT EXISTS teachers
(teacher_id INT NOT NULL,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email email_borjamoll,
department VARCHAR(50) DEFAULT 'Programación',
PRIMARY KEY(teacher_id),
foreign key (department) references departments (dept_name)
on delete set default);

--Tabla courses
CREATE TABLE IF NOT EXISTS courses (
course_id INT NOT NULL,
course_name VARCHAR(50) NOT NULL,
begin_date DATE NOT NULL,
course_duration INTERVAL,
entry_time TIME NOT NULL,
exit_time TIME NOT NULL CHECK(entry_time < exit_time),
PRIMARY KEY(course_id));

--Tabla takes
CREATE TABLE IF NOT EXISTS takes
(student_id INT NOT NULL,
course_id INT NOT NULL,
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
(teacher_id INT NOT NULL,
course_id INT NOT NULL,
PRIMARY KEY(teacher_id, course_id),
FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
on delete cascade
on update cascade,
FOREIGN KEY (course_id) REFERENCES courses (course_id)
on delete cascade
on update cascade);