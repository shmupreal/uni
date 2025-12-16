-- практика 10. приведение к 1нф и 2нф

-- задание 1: 1нф
-- нарушение: team_members хранит список значений в одной ячейке (неатомарно), это нарушает 1нф
-- исправление: выносим участников в отдельную таблицу (по одной записи на участника)

DROP TABLE IF EXISTS Project_Members;
DROP TABLE IF EXISTS Projects;

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255)
);

CREATE TABLE Project_Members (
    project_id INT NOT NULL,
    member_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (project_id, member_name),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- задание 2: 2нф
-- функциональные зависимости:
-- client_id -> client_name, client_email
-- equipment_id -> equipment_name
-- (client_id, equipment_id) -> rental_date
-- нарушение: client_name/email и equipment_name зависят от части составного ключа, значит нарушена 2нф
-- исправление: разделяем на справочники и таблицу фактов аренды

DROP TABLE IF EXISTS Equipment_Rentals;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Clients;

CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(255),
    client_email VARCHAR(255)
);

CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(255)
);

CREATE TABLE Equipment_Rentals (
    client_id INT NOT NULL,
    equipment_id INT NOT NULL,
    rental_date DATE,
    PRIMARY KEY (client_id, equipment_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

-- задание 3: комплексная нормализация (1нф + 2нф)
-- нарушение 1нф: assignments_and_grades хранит json/структуру в одном поле (неатомарно)
-- приведение к 1нф: переносим каждое задание в отдельную строку (assignment_name, grade)

DROP TABLE IF EXISTS StudentGrades_1NF;

CREATE TABLE StudentGrades_1NF (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    student_name VARCHAR(255),
    course_professor VARCHAR(255),
    assignment_name VARCHAR(255) NOT NULL,
    grade INT,
    PRIMARY KEY (student_id, course_id, assignment_name)
);

-- анализ 2нф для структуры 1нф:
-- student_id -> student_name
-- course_id -> course_professor
-- нарушение 2нф: неключевые атрибуты зависят от части составного ключа
-- исправление: выделяем Students, Courses и таблицу Grades

DROP TABLE IF EXISTS Grades;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_professor VARCHAR(255)
);

CREATE TABLE Grades (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    assignment_name VARCHAR(255) NOT NULL,
    grade INT,
    PRIMARY KEY (student_id, course_id, assignment_name),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
