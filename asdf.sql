CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY, -- Уникальный идентификатор студента
    full_name VARCHAR(255) NOT NULL, -- Полное имя студента
    email VARCHAR(255) UNIQUE NOT NULL, -- Электронная почта студента (должна быть уникальной)
    start_year INT -- Год поступления студента
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY, -- Уникальный идентификатор курса
    course_name VARCHAR(255) NOT NULL, -- Название курса
    credits INT CHECK (credits > 0) -- Количество зачетных единиц курса (должно быть больше 0)
);

CREATE TABLE Enrollments (
    student_id INT REFERENCES Students(student_id) ON DELETE CASCADE, -- Ссылка на ID студента (внешний ключ)
    course_id INT REFERENCES Courses(course_id) ON DELETE CASCADE, -- Ссылка на ID курса (внешний ключ)
    grade CHAR(1), -- Оценка студента за курс (например, 'A', 'B', 'C')
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO Students VALUES (DEFAULT, 'Алексея Смирнова', 'al_sm@example.com', 2021);
INSERT INTO Students VALUES (DEFAULT, 'Елену Кузнецову', 'el_kuz@example.com', 2022);
INSERT INTO Students VALUES (DEFAULT, 'Дмитрия Новикова', 'dm_nov@example.com', 2021);
INSERT INTO Students VALUES (DEFAULT, 'Ольга Морозова', 'ol_mor@example.com', 2023);

SELECT * from Students;

SELECT * from courses;

DELETE FROM Students
WHERE email = 'ivan@example.com';

INSERT INTO Courses (course_name, credits) VALUES
('Введение в программирование', 5),
('Базы данных', 4),
('Веб-технологии', 4);

INSERT INTO enrollments(student_id, course_id, grade) VALUES
(2, 2, 'A'),
(4, 2, 'A'),
(5, 1, NULL),
(5, 2, NULL),
(5, 3, NULL);


UPDATE Students
SET email = 'elena.kuznetsova@newmail.com'
WHERE full_name = 'Елену Кузнецову';

UPDATE enrollments
SET grade='A'
WHERE course_id=1 and student_id=5;

DELETE FROM students
WHERE email = 'ol_mor@example.com';
