Create DATABASE SCHOOL;
USE SCHOOL;
CREATE TABLE Students1 (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    EnrollmentDate DATE
);

CREATE TABLE Courses1 (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(255) NOT NULL,
    Description TEXT,
    Credits INT NOT NULL
);

CREATE TABLE Enrollments1(
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students1(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses1(CourseID)
);
-- Insert data into Students
INSERT INTO Students1 (FirstName, LastName, DateOfBirth, Email, Phone, EnrollmentDate) VALUES
('John', 'Doe', '2000-01-15', 'john.doe@example.com', '123-456-7890', '2023-01-15'),
('Jane', 'Smith', '1999-02-20', 'jane.smith@example.com', '098-765-4321', '2023-02-20'),
('Alice', 'Johnson', '2001-03-05', 'alice.johnson@example.com', '555-123-4567', '2023-03-05'),
('Bob', 'Williams', '2002-04-10', 'bob.williams@example.com', '555-987-6543', '2023-04-10'),
('Charlie', 'Brown', '2003-05-25', 'charlie.brown@example.com', '555-321-4321', '2023-05-25');

-- Insert data into Courses
INSERT INTO Courses1 (CourseName, Description, Credits) VALUES
('Mathematics', 'Study of numbers, quantities, and shapes.', 3),
('Physics', 'Study of matter and energy.', 4),
('Chemistry', 'Study of substances and their interactions.', 3),
('Biology', 'Study of living organisms.', 4),
('Computer Science', 'Study of computers and computational systems.', 3);

-- Insert data into Enrollments
INSERT INTO Enrollments1 (StudentID, CourseID, Grade) VALUES
(1, 1, 'A'),
(2, 2, 'B'),
(3, 3, 'C'),
(4, 4, 'A'),
(5, 5, 'B'),
(1, 2, 'B'),
(2, 3, 'C'),
(3, 4, 'A'),
(4, 5, 'B'),
(5, 1, 'A');
-- Update a student's email
UPDATE Students1
SET Email = 'john.new@example.com'
WHERE StudentID = 1;

-- Update a course's credits
UPDATE Courses1
SET Credits = 5
WHERE CourseID = 4;
-- Delete a student
DELETE FROM Students1
WHERE StudentID = 5;

-- Delete a course
DELETE FROM Courses1
WHERE CourseID = 3;
-- Retrieve all students
SELECT * FROM Students1;

-- Retrieve all courses
SELECT * FROM Courses1;

-- Retrieve all enrollments
SELECT * FROM Enrollments1;

-- Retrieve all courses a student is enrolled in
SELECT Students1.FirstName, Students1.LastName, Courses1.CourseName, Enrollments1.Grade
FROM Enrollments1
JOIN Students1 ON Enrollments1.StudentID = Students1.StudentID
JOIN Courses1 ON Enrollments1.CourseID = Courses1.CourseID
WHERE Students1.StudentID = 1;

-- Retrieve all students enrolled in a specific course
SELECT Courses1.CourseName, Students1.FirstName, Students1.LastName, Enrollments1.Grade
FROM Enrollments1
JOIN Students1 ON Enrollments1.StudentID = Students1.StudentID
JOIN Courses1 ON Enrollments1.CourseID = Courses1.CourseID
WHERE Courses1.CourseID = 2;

-- Retrieve the average grade for each course
SELECT Courses1.CourseName, AVG(CASE 
    WHEN Enrollments1.Grade = 'A' THEN 4
    WHEN Enrollments1.Grade = 'B' THEN 3
    WHEN Enrollments1.Grade = 'C' THEN 2
    WHEN Enrollments1.Grade = 'D' THEN 1
    ELSE 0
END) AS AverageGrade
FROM Enrollments1
JOIN Courses1 ON Enrollments1.CourseID = Courses1.CourseID
GROUP BY Courses1.CourseName;

