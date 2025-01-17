Problem: A table stores birthdates as strings in the format 'YYYY-MM-DD'. You need to calculate the age of customers.
Solution: Cast the birthdate column to a date type and then use date functions to calculate the age.

QUERY: SELECT  customer_id, customer_name, CAST(birthdate AS DATE) AS birthdate_casted, age(CAST(birthdate AS DATE)) AS age FROM customers;
 customer_id | customer_name | birthdate_casted |           age            
-------------+---------------+------------------+--------------------------
           1 | Abhinav       | 2004-01-19       | 20 years 11 mons 29 days
           2 | Priyanshu     | 2003-07-07       | 21 years 6 mons 10 days
           3 | Varun         | 2000-06-09       | 24 years 7 mons 8 days
(3 rows)

QUERY SELECT customer_id,   customer_name,   birthdate,  EXTRACT(YEAR FROM AGE(CAST(birthdate AS DATE))) AS age_years  FROM customers;
 customer_id | customer_name | birthdate  | age_years 
-------------+---------------+------------+-----------
           1 | Abhinav       | 2004-01-19 |        20
           2 | Priyanshu     | 2003-07-07 |        21
           3 | Varun         | 2000-06-09 |        24
(3 rows)


Problem: A column stores a boolean value as 'Y' or 'N'. You need to perform logical operations on this column.
Solution: Cast the 'Y' and 'N' values to boolean (TRUE/FALSE) using CASE expressions or custom functions.

QUERY-SELECT   user_id,  preference, CASE  WHEN preference = 'Y' THEN TRUE  WHEN preference = 'N' THEN FALSE  END AS preference_boolean FROM user_preferences;

 user_id | preference | preference_boolean 
---------+------------+--------------------
       1 | Y          | t
       2 | N          | f
       3 | Y          | t
       4 | N          | f
(4 rows)

