--This is just an example of how to introduce data in PostgresSQL

--Insertar valores en students
insert into students(first_name, last_name, email, birthdate, age) values 
('Daniel', 'Río', 'drioarizti@cifpfbmoll.eu', '2001-09-29', 21),
('Raúl', 'Velásquez', 'rvelasquezvega@cifpfbmoll.eu', '1999-06-09', 23),
('Juan', 'Pérez', 'jperez@cifpfbmoll.eu', '1995-10-12', 27);

--Insertar valores en departments
insert into departments values
('Programación', 'A-133', 15000),
('Bases de datos', 'A-121', 10000),
('Sis.Informáticos', 'A-101', 7500);

--Insertar valores en teachers
insert into teachers values
(323, 'Máximo', 'Fernández', 'mfernandez@cifpfbmoll.eu', 'Programación'),
(545, 'Jaume', 'Barceló', 'jbarcelo@cifpfbmoll.eu', 'Bases de datos'),
(127, 'Marc', 'Costa', 'mcostam@cifpfbmoll.eu', 'Sis.Informáticos');

--Insertar valores en courses
insert into courses(course_id, course_name, begin_date, entry_time, exit_time) values 
(123, '1ºDAW evening', '2023-09-23', '15:30:00', '21:15:00'),
(124, '1ºDAW morning', '2023-09-23', '08:00:00', '15:00:00');

INSERT INTO courses(course_id, course_name, begin_date, course_duration, entry_time, exit_time) values
(123, '1ºDAW evening', '2023-09-23', '9 month', '15:30:00', '21:15:00');

--Insertar valores en takes
insert into takes values
(1, 123, 84),
(2, 123, 75.4),
(3, 124, 45);

--Insertar valores en teaches
insert into teaches values
(323, 123),
(545, 123),
(127, 123);