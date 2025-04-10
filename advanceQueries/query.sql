-- Data Source: The dataset used was downloaded from Kaggle (https://www.kaggle.com).
-- Filename: Student_Mental_Stress_and_Coping_Mechanisms.csv
-- Description: The CSV file contains various student mental health attributes including stress levels, coping mechanisms, and lifestyle factors.
-- The data was imported into the PostgreSQL database (student_stress_db) for analysis.

CREATE DATABASE

CREATE TABLE

COPY 760

--1->Create a trigger that logs students with "High" mental stress into a separate table named high_stress_log.

--Queries->
CREATE TABLE high_stress_log ("Student ID" TEXT, "Mental Stress Level" TEXT, logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE OR REPLACE FUNCTION log_high_stress() RETURNS TRIGGER AS $$ BEGIN IF NEW."Mental Stress Level" = 'High' THEN INSERT INTO high_stress_log("Student ID", "Mental Stress Level") VALUES (NEW."Student ID", NEW."Mental Stress Level"); END IF; RETURN NEW; END; $$ LANGUAGE plpgsql;

CREATE TRIGGER trg_high_stress_log AFTER INSERT ON student_stress FOR EACH ROW EXECUTE FUNCTION log_high_stress();

--output->

CREATE TABLE

CREATE FUNCTION

CREATE TRIGGER

--2->Create a procedure that classifies students based on GPA into Excellent, Good, Average, and Poor. Store this in a new column GPA_Category.

--Queries->

ALTER TABLE student_stress ADD COLUMN GPA_Category TEXT;
CREATE OR REPLACE PROCEDURE categorize_gpa() LANGUAGE plpgsql AS $$ BEGIN UPDATE student_stress SET GPA_Category = CASE WHEN "Academic Performance (GPA)" >= 9 THEN 'Excellent' WHEN "Academic Performance (GPA)" >= 7 THEN 'Good' WHEN "Academic Performance (GPA)" >= 5 THEN 'Average' ELSE 'Poor' END; END; $$;
CALL categorize_gpa();

--Output->

ALTER TABLE

CREATE PROCEDURE
CALL

--3->Use a transaction to update students’ stress level to 'Low' if they have over 5 hours of physical exercise per week — only if GPA is not null.

--Query->

DO $$ BEGIN IF EXISTS (SELECT 1 FROM student_stress WHERE "Academic Performance (GPA)" IS NULL) THEN RAISE NOTICE 'Missing GPA, rollback'; ROLLBACK; ELSE UPDATE student_stress SET "Mental Stress Level" = 'Low' WHERE "Physical Exercise (Hours per week)" > 5; COMMIT; END IF; END $$;

--Output->

DO
ROLLBACK

--4->Write a query to find students who spend more than 5 hours daily on social media and have high stress.

--Query->

SELECT "Student ID", "Social Media Usage (Hours per day)", "Mental Stress Level" FROM student_stress WHERE CAST("Social Media Usage (Hours per day)" AS FLOAT) > 5 AND "Mental Stress Level" ~ '^[0-9]+$' AND CAST("Mental Stress Level" AS INTEGER) >= 7;

--Output->

 Student ID  | Social Media Usage (Hours per day) | Mental Stress Level 
-------------+------------------------------------+---------------------
 664-76-5622 |                                  6 | 7
 282-69-0356 |                                  6 | 10
 403-92-9632 |                                  8 | 8
 629-52-7023 |                                  7 | 7
 786-72-6825 |                                  8 | 10
 156-59-9054 |                                  8 | 8
 311-25-5374 |                                  7 | 10
 311-01-4979 |                                  7 | 9
 358-27-6734 |                                  6 | 8
 686-76-8831 |                                  8 | 9
 469-83-1014 |                                  8 | 9
 235-80-3727 |                                  6 | 10
 754-33-1593 |                                  7 | 9
 315-14-3308 |                                  8 | 8
 585-40-0453 |                                  6 | 9
 891-94-6731 |                                  6 | 8
 792-17-2824 |                                  7 | 10
 725-20-8354 |                                  7 | 7
 764-31-6447 |                                  6 | 9
 685-28-8610 |                                  7 | 8
 102-53-4424 |                                  8 | 8
 419-54-4414 |                                  7 | 9
 669-90-1482 |                                  7 | 10
 440-16-4165 |                                  6 | 7
 506-21-6440 |                                  7 | 7
 711-96-0039 |                                  7 | 9
 568-72-9492 |                                  7 | 9
 221-70-4223 |                                  8 | 9
 690-93-7394 |                                  7 | 7
 487-69-5401 |                                  8 | 7
 228-62-9891 |                                  7 | 8
 438-76-7174 |                                  8 | 10
 437-86-5614 |                                  7 | 8
 393-27-3064 |                                  6 | 9
 221-29-3352 |                                  7 | 7
 795-37-4782 |                                  7 | 9
 531-35-5421 |                                  6 | 10
 325-94-1580 |                                  8 | 7
 888-49-6708 |                                  7 | 10
 864-73-0913 |                                  7 | 10
 637-82-3471 |                                  8 | 7
 134-38-2267 |                                  8 | 9
 662-06-0085 |                                  8 | 8
 461-28-4962 |                                  7 | 7
 561-26-2299 |                                  8 | 7
 569-85-6676 |                                  6 | 10
 263-28-9222 |                                  8 | 8
 483-79-6469 |                                  7 | 7
 197-16-6156 |                                  8 | 9
 257-59-3889 |                                  7 | 9
 505-09-0766 |                                  8 | 7
 599-97-8174 |                                  6 | 8
 107-84-6181 |                                  7 | 8
 846-80-2635 |                                  7 | 10
 809-78-0926 |                                  6 | 8
 241-88-9615 |                                  6 | 7
 541-90-1529 |                                  6 | 9
 192-96-8313 |                                  8 | 10
 556-41-4631 |                                  7 | 10
 181-96-3279 |                                  7 | 10
 544-98-6919 |                                  6 | 8
(61 rows)

--5->Create a user read_analyst with read-only access to the database

--Query->

CREATE ROLE read_analyst LOGIN PASSWORD 'secure123'; GRANT CONNECT ON DATABASE student_stress_db TO read_analyst; GRANT USAGE ON SCHEMA public TO read_analyst; GRANT SELECT ON student_stress TO read_analyst;

--Output-->

CREATE ROLE
GRANT
GRANT

--6->Revoke INSERT, UPDATE, DELETE privileges from the role read_analyst.

--Query-->

REVOKE INSERT, UPDATE, DELETE ON student_stress FROM read_analyst;

--Output->

REVOKE

--7->Group the students by gender and mental stress level, and get the count in each group.

--Query->

SELECT Gender, "Mental Stress Level", COUNT(*) AS count FROM student_stress GROUP BY Gender, "Mental Stress Level" ORDER BY Gender;

--Output-->

   gender    | Mental Stress Level | count 
-------------+---------------------+-------
 Agender     | 4                   |     1
 Agender     | 9                   |     1
 Agender     | 6                   |     1
 Agender     | 10                  |     1
 Agender     | 8                   |     2
 Agender     | 5                   |     1
 Agender     | Low                 |     7
 Bigender    | 6                   |     1
 Bigender    | 9                   |     2
 Bigender    | 4                   |     1
 Bigender    | Low                 |    10
 Bigender    | 1                   |     1
 Bigender    | 8                   |     1
 Female      | 6                   |    15
 Female      | 2                   |    33
 Female      | 4                   |    16
 Female      | 10                  |    21
 Female      | 5                   |    18
 Female      | 9                   |    23
 Female      | 7                   |    21
 Female      | 3                   |    17
 Female      | 1                   |    13
 Female      | Low                 |   144
 Female      | 8                   |    15
 Genderfluid | 5                   |     1
 Genderfluid | 2                   |     1
 Genderfluid | 1                   |     1
 Genderfluid | 4                   |     1
 Genderfluid | 8                   |     1
 Genderfluid | Low                 |     7
 Genderqueer | 3                   |     1
 Genderqueer | 5                   |     2
 Genderqueer | 9                   |     1
 Genderqueer | 1                   |     1
 Genderqueer | Low                 |     2
 Male        | 10                  |    24
 Male        | 9                   |    13
 Male        | 6                   |    19
 Male        | 8                   |    27
 Male        | 4                   |    23
 Male        | Low                 |   158
 Male        | 3                   |    18
 Male        | 1                   |    21
 Male        | 2                   |    14
 Male        | 7                   |    17
 Male        | 5                   |    19
 Non-binary  | 1                   |     2
 Non-binary  | 6                   |     1
 Non-binary  | 7                   |     2
 Non-binary  | 10                  |     1
 Non-binary  | Low                 |     3
 Non-binary  | 4                   |     1
 Polygender  | 3                   |     3
 Polygender  | Low                 |     4
 Polygender  | 6                   |     1
 Polygender  | 2                   |     2
 Polygender  | 10                  |     1
 Polygender  | 8                   |     1
(58 rows)

--8->List students who haven't attended counseling and either have high mental stress or poor diet quality.

--Query->

SELECT "Student ID", "Mental Stress Level", "Diet Quality" FROM student_stress WHERE "Counseling Attendance" = 'No' AND ("Mental Stress Level" ~ '^[0-9]+$' AND CAST("Mental Stress Level" AS INTEGER) >= 7 OR "Diet Quality" ~ '^[0-9]+$' AND CAST("Diet Quality" AS INTEGER) <= 2);

--Output->

 Student ID  | Mental Stress Level | Diet Quality 
-------------+---------------------+--------------
 802-17-3671 | 9                   | 1
 365-77-2496 | 1                   | 1
 740-27-0902 | 10                  | 5
 193-03-0467 | 4                   | 1
 249-06-6401 | 9                   | 1
 161-68-2043 | 9                   | 2
 375-79-2097 | 1                   | 1
 270-48-3167 | 10                  | 4
 832-04-3592 | 10                  | 4
 230-07-5794 | 9                   | 2
 505-69-0221 | 2                   | 2
 204-29-1694 | 4                   | 2
 403-92-9632 | 8                   | 4
 209-32-8628 | 8                   | 3
 367-56-4708 | 3                   | 2
 747-47-2831 | 5                   | 2
 553-73-9451 | 7                   | 5
 620-60-6101 | 6                   | 1
 629-52-7023 | 7                   | 4
 400-21-6724 | 10                  | 1
 479-91-6861 | 2                   | 2
 512-53-1330 | 9                   | 3
 581-07-0225 | 7                   | 4
 768-78-3237 | 10                  | 2
 567-20-0671 | 2                   | 1
 115-05-2082 | 6                   | 2
 311-25-5374 | 10                  | 3
 311-01-4979 | 9                   | 3
 857-78-9982 | 4                   | 2
 361-01-5382 | 8                   | 2
 143-64-7699 | 8                   | 3
 358-27-6734 | 8                   | 5
 686-76-8831 | 9                   | 3
 469-83-1014 | 9                   | 4
 779-26-7175 | 7                   | 4
 235-80-3727 | 10                  | 1
 505-67-4877 | 10                  | 5
 449-71-1303 | 3                   | 2
 538-54-0209 | 9                   | 2
 192-13-3343 | 9                   | 2
 891-94-6731 | 8                   | 3
 307-28-5129 | 10                  | 1
 663-29-0123 | 9                   | 4
 764-31-6447 | 9                   | 5
 725-31-2595 | 9                   | 5
 685-28-8610 | 8                   | 2
 821-31-0994 | 9                   | 3
 412-84-5105 | 7                   | 3
 419-54-4414 | 9                   | 4
 808-35-0942 | 7                   | 5
 275-55-2472 | 2                   | 1
 284-72-1833 | 6                   | 2
 669-90-1482 | 10                  | 1
 181-12-1436 | 8                   | 2
 787-23-6149 | 2                   | 2
 445-01-9008 | 10                  | 4
 412-61-2951 | 7                   | 3
 861-23-4943 | 2                   | 2
 820-39-6059 | 5                   | 2
 294-22-0217 | 10                  | 2
 620-14-3348 | 8                   | 4
 140-30-3552 | 2                   | 2
 620-66-8893 | 6                   | 1
 367-45-6616 | 5                   | 1
 526-42-6686 | 10                  | 5
 711-96-0039 | 9                   | 4
 890-06-6056 | 10                  | 2
 365-22-3619 | 8                   | 1
 221-70-4223 | 9                   | 1
 487-69-5401 | 7                   | 1
 701-16-4276 | 8                   | 3
 615-79-8440 | 2                   | 2
 118-06-0554 | 1                   | 2
 778-29-7908 | 7                   | 2
 288-35-3562 | 1                   | 2
 320-25-0987 | 6                   | 1
 145-37-1963 | 10                  | 5
 393-27-3064 | 9                   | 3
 221-29-3352 | 7                   | 5
 656-32-4795 | 1                   | 1
 615-50-9853 | 8                   | 1
 806-02-8150 | 6                   | 1
 795-37-4782 | 9                   | 1
 531-35-5421 | 10                  | 2
 378-69-3253 | 3                   | 1
 738-49-0188 | 2                   | 2
 752-96-2019 | 9                   | 4
 530-09-1717 | 7                   | 5
 477-22-8639 | 9                   | 1
 335-88-9255 | 8                   | 3
 202-17-3500 | 8                   | 3
 305-74-1381 | 8                   | 5
 851-42-5437 | 5                   | 1
 382-54-7314 | 9                   | 5
 593-90-7730 | 10                  | 4
 762-39-4942 | 10                  | 2
 312-59-9234 | 9                   | 1
 864-73-0913 | 10                  | 5
 251-46-4115 | 4                   | 2
 110-77-5199 | 6                   | 2
 337-38-5119 | 7                   | 4
 637-82-3471 | 7                   | 3
 134-38-2267 | 9                   | 3
 662-06-0085 | 8                   | 4
 145-29-0147 | 8                   | 3
 807-08-9130 | 6                   | 2
 682-85-4744 | 10                  | 4
 508-21-9829 | 8                   | 5
 851-45-3801 | 4                   | 1
 426-06-7163 | 8                   | 5
 336-64-6627 | 5                   | 1
 569-85-6676 | 10                  | 5
 880-57-0413 | 10                  | 2
 779-50-6123 | 9                   | 3
 846-50-6000 | 8                   | 1
 741-94-3934 | 1                   | 1
 263-28-9222 | 8                   | 5
 823-55-1413 | 5                   | 1
 636-25-9534 | 7                   | 1
 268-54-3043 | 10                  | 2
 891-03-5267 | 8                   | 3
 536-05-0705 | 9                   | 2
 537-13-6762 | 10                  | 1
 599-97-8174 | 8                   | 3
 789-11-8047 | 3                   | 1
 876-38-2404 | 10                  | 1
 421-78-2279 | 5                   | 1
 835-54-9143 | 7                   | 3
 544-61-7082 | 10                  | 5
 459-73-3957 | 10                  | 3
 809-78-0926 | 8                   | 1
 473-59-3766 | 3                   | 1
 627-88-9175 | 7                   | 3
 123-20-9401 | 6                   | 1
 893-18-6851 | 2                   | 2
 489-81-9800 | 5                   | 2
 541-90-1529 | 9                   | 1
 447-25-1797 | 8                   | 5
 730-09-1563 | 9                   | 4
 181-96-3279 | 10                  | 4
 143-10-3794 | 4                   | 2
 384-12-1816 | 9                   | 2
 544-98-6919 | 8                   | 4
 658-67-3956 | Low                 | 1
 438-56-6737 | Low                 | 2
 861-60-5151 | Low                 | 2
 594-28-4204 | Low                 | 2
 292-85-0963 | Low                 | 2
 742-17-8756 | Low                 | 1
 850-13-5324 | Low                 | 1
 481-45-3887 | Low                 | 2
 667-21-2334 | Low                 | 1
 730-87-4838 | Low                 | 2
 332-05-7324 | Low                 | 1
 500-75-5507 | Low                 | 2
 735-88-4515 | Low                 | 2
 819-14-2694 | Low                 | 1
 605-97-7460 | Low                 | 1
 747-92-3547 | Low                 | 1
 357-60-6383 | Low                 | 2
 380-01-5180 | Low                 | 1
 891-44-0532 | Low                 | 2
 489-83-9210 | Low                 | 2
 513-29-6152 | Low                 | 2
 814-81-7401 | Low                 | 1
 746-44-5218 | Low                 | 1
 731-27-1490 | Low                 | 2
 504-41-0664 | Low                 | 1
 291-38-6668 | Low                 | 1
 896-76-6435 | Low                 | 2
 590-51-5779 | Low                 | 2
 478-75-3530 | Low                 | 2
 540-08-7969 | Low                 | 2
 139-17-3617 | Low                 | 2
 565-92-5987 | Low                 | 1
 865-88-4728 | Low                 | 1
 536-46-2617 | Low                 | 1
 234-47-0088 | Low                 | 2
 343-91-1894 | Low                 | 2
 122-25-1925 | Low                 | 1
 699-31-2060 | Low                 | 1
 727-06-5275 | Low                 | 1
 271-48-3454 | Low                 | 1
 892-74-2771 | Low                 | 1
 254-42-8904 | Low                 | 1
 479-46-7256 | Low                 | 1
 668-31-1758 | Low                 | 1
 389-50-2944 | Low                 | 2
 237-08-5949 | Low                 | 2
 800-14-7482 | Low                 | 1
 198-16-6530 | Low                 | 1
 780-34-7404 | Low                 | 1
 270-63-4953 | Low                 | 1
 551-07-0629 | Low                 | 2
 710-66-1494 | Low                 | 1
 400-92-3567 | Low                 | 2
 659-59-5137 | Low                 | 2
 454-52-5179 | Low                 | 2
 593-17-5747 | Low                 | 2
 677-75-1654 | Low                 | 2
 453-60-8989 | Low                 | 1
 259-06-7837 | Low                 | 1
 782-86-8699 | Low                 | 1
 366-66-5774 | Low                 | 1
 581-76-0875 | Low                 | 2
 252-34-4732 | Low                 | 2
 221-66-5389 | Low                 | 1
 716-33-7124 | Low                 | 2
 600-81-2221 | Low                 | 2
 655-26-0644 | Low                 | 1
 591-08-8279 | Low                 | 1
 516-25-2354 | Low                 | 1
 821-11-9235 | Low                 | 1
 259-58-1974 | Low                 | 2
 336-14-7577 | Low                 | 1
 615-46-9937 | Low                 | 1
 889-99-6609 | Low                 | 1
 266-11-0157 | Low                 | 2
 897-18-9984 | Low                 | 2
 345-50-9214 | Low                 | 1
 129-32-7813 | Low                 | 2
(221 rows)

--9->Identify students with cognitive distortions and a family history of mental health issues.

--Query->

SELECT "Student ID", "Cognitive Distortions", "Family Mental Health History" FROM student_stress WHERE "Family Mental Health History" = 'Yes' AND "Cognitive Distortions" ~ '^[0-9]+$' AND CAST("Cognitive Distortions" AS INTEGER) >= 3;

--Output-->

 Student ID  | Cognitive Distortions | Family Mental Health History 
-------------+-----------------------+------------------------------
 386-91-7629 | 3                     | Yes
 803-83-7625 | 4                     | Yes
 879-05-6220 | 4                     | Yes
 355-95-4355 | 4                     | Yes
 375-79-2097 | 5                     | Yes
 148-22-9008 | 3                     | Yes
 631-14-1769 | 3                     | Yes
 230-07-5794 | 3                     | Yes
 505-69-0221 | 5                     | Yes
 204-29-1694 | 4                     | Yes
 403-92-9632 | 5                     | Yes
 866-68-4346 | 5                     | Yes
 178-03-0028 | 5                     | Yes
 800-36-7705 | 4                     | Yes
 474-66-6263 | 5                     | Yes
 652-50-6948 | 5                     | Yes
 767-02-0514 | 5                     | Yes
 755-25-6365 | 4                     | Yes
 347-81-9759 | 3                     | Yes
 629-52-7023 | 4                     | Yes
 400-21-6724 | 4                     | Yes
 479-91-6861 | 5                     | Yes
 638-52-2815 | 3                     | Yes
 581-07-0225 | 5                     | Yes
 567-20-0671 | 4                     | Yes
 115-05-2082 | 5                     | Yes
 648-32-3365 | 5                     | Yes
 311-25-5374 | 5                     | Yes
 505-67-4877 | 4                     | Yes
 315-14-3308 | 3                     | Yes
 572-36-3852 | 3                     | Yes
 585-40-0453 | 5                     | Yes
 430-98-7843 | 5                     | Yes
 792-17-2824 | 4                     | Yes
 307-28-5129 | 4                     | Yes
 667-64-2830 | 4                     | Yes
 381-57-2885 | 4                     | Yes
 764-31-6447 | 3                     | Yes
 694-39-2032 | 5                     | Yes
 402-01-4786 | 3                     | Yes
 808-35-0942 | 5                     | Yes
 196-48-5751 | 3                     | Yes
 275-55-2472 | 4                     | Yes
 822-73-2624 | 4                     | Yes
 785-05-2183 | 5                     | Yes
 332-97-6557 | 4                     | Yes
 669-90-1482 | 4                     | Yes
 787-23-6149 | 4                     | Yes
 861-23-4943 | 5                     | Yes
 294-22-0217 | 3                     | Yes
 620-14-3348 | 5                     | Yes
 620-66-8893 | 5                     | Yes
 264-63-9878 | 4                     | Yes
 526-42-6686 | 4                     | Yes
 409-15-5570 | 3                     | Yes
 711-96-0039 | 4                     | Yes
 191-76-1176 | 5                     | Yes
 774-41-4155 | 3                     | Yes
 140-37-3029 | 4                     | Yes
 690-93-7394 | 3                     | Yes
 481-51-4441 | 4                     | Yes
 148-57-6730 | 5                     | Yes
 145-37-1963 | 3                     | Yes
 393-27-3064 | 4                     | Yes
 320-56-4479 | 4                     | Yes
 781-40-2585 | 3                     | Yes
 443-31-3477 | 4                     | Yes
 707-05-8481 | 4                     | Yes
 325-94-1580 | 3                     | Yes
 530-09-1717 | 4                     | Yes
 335-88-9255 | 3                     | Yes
 890-19-8390 | 3                     | Yes
 110-72-8540 | 3                     | Yes
 579-55-4938 | 5                     | Yes
 354-85-7597 | 5                     | Yes
 593-90-7730 | 3                     | Yes
 858-67-4388 | 5                     | Yes
 744-22-9388 | 4                     | Yes
 312-59-9234 | 3                     | Yes
 864-73-0913 | 5                     | Yes
 637-82-3471 | 5                     | Yes
 753-28-7167 | 4                     | Yes
 804-74-5321 | 3                     | Yes
 815-87-5163 | 5                     | Yes
 602-70-7449 | 4                     | Yes
 851-45-3801 | 4                     | Yes
 426-06-7163 | 3                     | Yes
 569-85-6676 | 5                     | Yes
 223-73-6426 | 5                     | Yes
 846-50-6000 | 5                     | Yes
 741-94-3934 | 5                     | Yes
 318-20-1854 | 4                     | Yes
 163-45-2420 | 5                     | Yes
 863-56-3929 | 5                     | Yes
 823-55-1413 | 4                     | Yes
 393-27-9582 | 5                     | Yes
 327-70-4852 | 4                     | Yes
 503-21-1367 | 5                     | Yes
 724-01-5785 | 4                     | Yes
 670-07-5476 | 3                     | Yes
 521-64-9078 | 5                     | Yes
 891-03-5267 | 4                     | Yes
 536-05-0705 | 4                     | Yes
 376-97-9137 | 4                     | Yes
 121-67-9770 | 5                     | Yes
 173-70-3512 | 5                     | Yes
 526-47-2573 | 3                     | Yes
 599-97-8174 | 4                     | Yes
 875-11-7909 | 5                     | Yes
 499-56-4811 | 4                     | Yes
 218-29-6698 | 3                     | Yes
 273-09-0415 | 3                     | Yes
 220-11-3284 | 4                     | Yes
 679-31-5831 | 4                     | Yes
 544-61-7082 | 4                     | Yes
 809-78-0926 | 5                     | Yes
 326-62-8795 | 4                     | Yes
 577-96-2463 | 3                     | Yes
 808-66-1685 | 5                     | Yes
 241-88-9615 | 3                     | Yes
 384-45-8190 | 5                     | Yes
 123-20-9401 | 4                     | Yes
 192-96-8313 | 4                     | Yes
 709-69-0922 | 4                     | Yes
 569-33-7852 | 3                     | Yes
 714-33-5373 | 4                     | Yes
 504-53-5581 | 5                     | Yes
 861-60-5151 | 5                     | Yes
 115-75-7195 | 3                     | Yes
 594-28-4204 | 4                     | Yes
 295-62-4300 | 4                     | Yes
 292-85-0963 | 3                     | Yes
 532-53-7106 | 5                     | Yes
 117-12-6960 | 4                     | Yes
 687-83-4719 | 3                     | Yes
 252-89-3971 | 3                     | Yes
 811-27-2129 | 5                     | Yes
 429-54-5963 | 3                     | Yes
 124-45-0187 | 4                     | Yes
 730-87-4838 | 3                     | Yes
 500-75-5507 | 3                     | Yes
 432-35-6566 | 4                     | Yes
 819-14-2694 | 5                     | Yes
 605-97-7460 | 4                     | Yes
 747-92-3547 | 5                     | Yes
 489-83-9210 | 3                     | Yes
 415-38-9662 | 3                     | Yes
 200-18-7013 | 3                     | Yes
 208-12-7999 | 3                     | Yes
 621-13-0774 | 4                     | Yes
 746-44-5218 | 3                     | Yes
 216-93-6804 | 5                     | Yes
 562-13-2617 | 3                     | Yes
 792-33-0211 | 4                     | Yes
 463-46-8616 | 4                     | Yes
 472-36-1084 | 5                     | Yes
 198-24-0404 | 4                     | Yes
 231-51-2392 | 4                     | Yes
 504-41-0664 | 5                     | Yes
 897-73-6775 | 4                     | Yes
 291-38-6668 | 5                     | Yes
 210-48-6696 | 5                     | Yes
 146-61-2919 | 5                     | Yes
 621-24-8028 | 4                     | Yes
 586-87-3316 | 5                     | Yes
 390-91-0103 | 4                     | Yes
 586-34-3444 | 3                     | Yes
 540-08-7969 | 3                     | Yes
 758-45-8170 | 3                     | Yes
 207-60-0958 | 4                     | Yes
 450-60-6395 | 5                     | Yes
 221-35-2318 | 5                     | Yes
 122-25-1925 | 3                     | Yes
 699-31-2060 | 4                     | Yes
 740-09-9764 | 5                     | Yes
 176-78-6541 | 3                     | Yes
 804-52-3208 | 3                     | Yes
 788-73-1307 | 4                     | Yes
 545-56-1934 | 5                     | Yes
 523-31-2613 | 5                     | Yes
 799-05-5204 | 3                     | Yes
 208-48-5788 | 5                     | Yes
 437-37-2214 | 5                     | Yes
 450-92-7163 | 3                     | Yes
 479-46-7256 | 3                     | Yes
 894-23-4350 | 5                     | Yes
 783-83-0580 | 5                     | Yes
 513-74-3727 | 3                     | Yes
 668-31-1758 | 5                     | Yes
 556-62-7808 | 5                     | Yes
 753-61-1198 | 4                     | Yes
 311-80-2077 | 5                     | Yes
 444-95-5357 | 5                     | Yes
 551-07-0629 | 5                     | Yes
 659-59-5137 | 3                     | Yes
 650-55-0326 | 5                     | Yes
 199-36-3330 | 5                     | Yes
 219-08-7978 | 4                     | Yes
 817-75-9957 | 3                     | Yes
 648-04-5327 | 3                     | Yes
 259-06-7837 | 5                     | Yes
 745-80-5323 | 3                     | Yes
 339-64-6463 | 3                     | Yes
 578-73-5589 | 5                     | Yes
 716-33-7124 | 4                     | Yes
 577-02-7831 | 3                     | Yes
 231-60-6613 | 3                     | Yes
 600-81-2221 | 5                     | Yes
 451-63-4332 | 3                     | Yes
 313-21-0463 | 3                     | Yes
 821-11-9235 | 5                     | Yes
 331-90-0090 | 3                     | Yes
 748-61-0034 | 4                     | Yes
 169-44-3996 | 4                     | Yes
 255-13-7524 | 5                     | Yes
 735-88-1756 | 4                     | Yes
 389-61-8098 | 3                     | Yes
 702-91-2228 | 4                     | Yes
 552-17-5578 | 4                     | Yes
 830-78-6799 | 5                     | Yes
 442-22-8487 | 4                     | Yes
 139-21-3471 | 3                     | Yes
 889-99-6609 | 4                     | Yes
 629-88-8786 | 4                     | Yes
 745-98-9303 | 3                     | Yes
 129-32-7813 | 4                     | Yes
 521-41-0961 | 5                     | Yes
 826-89-7993 | 3                     | Yes
 681-15-6754 | 4                     | Yes
(229 rows)

--10->Create a trigger that sets a flag CRITICAL if peer pressure, relationship stress, and financial stress are all high.

--Query-->

ALTER TABLE student_stress ADD COLUMN Stress_Flag TEXT;
CREATE OR REPLACE FUNCTION flag_critical_stress() RETURNS TRIGGER AS $$ BEGIN IF NEW."Peer Pressure" = 'High' AND NEW."Relationship Stress" = 'High' AND NEW."Financial Stress" = 'High' THEN NEW.Stress_Flag := 'CRITICAL'; END IF; RETURN NEW; END; $$ LANGUAGE plpgsql;
CREATE TRIGGER trg_flag_stress BEFORE INSERT OR UPDATE ON student_stress FOR EACH ROW EXECUTE FUNCTION flag_critical_stress();

--Output->

ALTER TABLE
CREATE FUNCTION
CREATE TRIGGER