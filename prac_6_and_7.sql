-- тут начинается 6 практика

DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    start_year INT
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT CHECK (credits > 0)
);

CREATE TABLE Enrollments (
    student_id INT REFERENCES Students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES Courses(course_id) ON DELETE CASCADE,
    grade CHAR(1),
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO Students (full_name, email, start_year) VALUES
('Алексей Смирнов', 'aleksey.smirnov@mail.com', 2021),
('Елена Кузнецова', 'elena.kuznetsova@mail.com', 2022),
('Дмитрий Новиков', 'dmitriy.novikov@mail.com', 2021),
('Ольга Морозова', 'olga.morozova@mail.com', 2023);

INSERT INTO Courses (course_name, credits) VALUES
('Введение в программирование', 5),
('Базы данных', 4),
('Веб-технологии', 4);

INSERT INTO Enrollments (student_id, course_id, grade)
SELECT s.student_id, c.course_id, 'A'
FROM Students s, Courses c
WHERE s.full_name = 'Алексей Смирнов' AND c.course_name = 'Базы данных';

INSERT INTO Enrollments (student_id, course_id, grade)
SELECT s.student_id, c.course_id, 'B'
FROM Students s, Courses c
WHERE s.full_name = 'Елена Кузнецова' AND c.course_name = 'Базы данных';

INSERT INTO Enrollments (student_id, course_id, grade)
SELECT s.student_id, c.course_id, 'A'
FROM Students s, Courses c
WHERE s.full_name = 'Елена Кузнецова' AND c.course_name = 'Веб-технологии';

INSERT INTO Enrollments (student_id, course_id)
SELECT s.student_id, c.course_id
FROM Students s, Courses c
WHERE s.full_name = 'Дмитрий Новиков';

UPDATE Students
SET email = 'elena.kuznetsova@newmail.com'
WHERE full_name = 'Елена Кузнецова';

UPDATE Enrollments e
SET grade = 'A'
FROM Students s, Courses c
WHERE e.student_id = s.student_id
  AND e.course_id = c.course_id
  AND s.full_name = 'Дмитрий Новиков'
  AND c.course_name = 'Введение в программирование';

DELETE FROM Students
WHERE full_name = 'Ольга Морозова';

-- тут начинается 7 практика

SELECT * FROM Students;

SELECT course_name, credits FROM Courses;

SELECT * FROM Students WHERE start_year = 2021;

SELECT * FROM Courses WHERE credits > 4;

SELECT * FROM Students WHERE email = 'elena.kuznetsova@newmail.com';

SELECT * FROM Students WHERE full_name LIKE 'Дмитрий%';

SELECT * FROM Enrollments WHERE grade IS NULL;

SELECT * FROM Courses ORDER BY course_name ASC;

SELECT * FROM Students ORDER BY start_year ASC, full_name ASC;

SELECT * FROM Students ORDER BY start_year DESC, full_name ASC LIMIT 2;
