question1->Schema:
    	Students:
        StudentID (Primary Key, INT)
        FirstName (VARCHAR(50))
        LastName (VARCHAR(50))
        EnrollmentDate (DATE)
        Email (VARCHAR(100), UNIQUE)
        Courses:
        CourseID (Primary Key, INT)
        CourseName (VARCHAR(100))
        Credits (INT)
        Enrollments:
        EnrollmentID (Primary Key, INT)
        StudentID (Foreign Key, INT)
        CourseID (Foreign Key, INT)
        Grade (DECIMAL(3, 2))

QUERY-> CREATE TABLE Students (Student_Id INT PRIMARY KEY, first_name VARCHAR(30), last_name VARCHAR(50),enrollment_date DATE, email VARCHAR(100) UNIQUE);

QUERY-> CREATE TABLE COURSES (Course_id INT PRIMARY KEY,course_name VARCHAR(100),credits INT NOT NULL);

QUERY->CREATE TABLE Enrollment(Enrollment_id INT PRIMARY KEY, Student_Id INT NOT NULL, Course_id INT NOT NULL, Grade DECIMAL(3,2), FOREIGN KEY (Student_Id) REFERENCES Students(Student_Id),  FOREIGN KEY (Course_id) REFERENCES COURSES (Cou
rse_id));


CREATE DATABASE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE

Question2->Stored Procedure:
    Create a stored procedure named EnrollStudent that:
    Takes inputs: StudentID, CourseID, and an optional Grade.
    Checks if the student is already enrolled in the course using a subquery.
    If not enrolled, inserts a new record into the Enrollments table.
    If enrolled, updates the Grade if a new value is provided.

QUERY->CREATE OR REPLACE PROCEDURE EnrollStudent(IN StudentID INT, IN CourseID INT, IN Grade DECIMAL(3, 2) DEFAULT NULL) LANGUAGE plpgsql AS $$ BEGIN IF EXISTS (SELECT 1 FROM Enrollments WHERE student_id = StudentID AND course_id = CourseID) THEN IF Grade IS NOT NULL THEN UPDATE Enrollments SET grade = Grade WHERE student_id = StudentID AND course_id = CourseID; END IF; ELSE INSERT INTO Enrollments (student_id, course_id, grade) VALUES (StudentID, CourseID, Grade); END IF; END; $$;

CREATE PROCEDURE
            List of relations
 Schema |     Name     | Type  |  Owner   
--------+--------------+-------+----------
 public | course_stats | table | postgres
 public | courses      | table | postgres
 public | enrollment   | table | postgres
 public | students     | table | postgres
(4 rows)

Question3->Trigger:
    Create a trigger named UpdateStudentCount that:
    Automatically updates a table CourseStatistics whenever a new student is enrolled or removed from a course.
    CourseStatistics table schema:
    CourseID (Primary Key, INT)
    StudentCount (INT, default 0)

QUERY->CREATE OR REPLACE FUNCTION UpdateStudentCountFunction() RETURNS TRIGGER LANGUAGE plpgsql AS $$ BEGIN INSERT INTO Course_stats (Course_id, Stu_cnt) VALUES (NEW.Course_id, 1) ON CONFLICT (Course_id) DO UPDATE SET Stu_cnt = Course_stats.Stu_cnt + 1; RETURN NULL; END; $$;

QUERY-> CREATE TRIGGER UpdateStudentCount AFTER INSERT ON Enrollment FOR EACH ROW EXECUTE FUNCTION UpdateStudentCountFunction();

CREATE FUNCTION
CREATE TRIGGER

Question4->Subquery:
    Write a query to fetch students who:
    Have enrolled in more than 3 courses.
    Have an average grade of 8.0 or higher across all their courses

QUERY-> SELECT s.Student_Id, s.first_name, s.last_name FROM Students s WHERE s.Student_Id IN (SELECT e.Student_Id FROM Enrollment e GROUP BY e.Student_Id HAVING COUNT(e.Course_id) > 3);

INSERT 0 9
 student_id | first_name | last_name 
------------+------------+-----------
          1 | Abhinav    | Lather
(1 row)

QUERY->SELECT s.Student_Id, s.first_name, s.last_name FROM Students s WHERE s.Student_Id IN (SELECT e.Student_Id FROM Enrollment e GROUP BY e.Student_Id HAVING AVG(e.Grade) >= 8.0);

 student_id | first_name | last_name 
------------+------------+-----------
          1 | Abhinav    | Lather
          2 | Priyanshu  | Singh
(2 rows)

QUESTION5->Indexing:
    Optimize the performance of the database by:
    Adding an index to improve the performance of queries on Enrollments that filter by StudentID and CourseID.

QUERY->CREATE INDEX idx_enrollments_student_course ON Enrollment (Student_Id, Course_id);

QUERY->SELECT * FROM Enrollment WHERE Student_Id = 1 AND Course_Id = 101;

CREATE INDEX
 enrollment_id | student_id | course_id | grade 
---------------+------------+-----------+-------
             1 |          1 |       101 |  8.50
(1 row)

