Ques :-> Create an alias for the full name of a customer by concatenating their first and last names.

Query: SELECT * FROM customersss;
Output:
 customer_id | first_name | last_name 
-------------+------------+-----------
           1 | Varun      | Thakur
           2 | Abhinav    | Lather
           3 | Ayush      | Nagar
(3 rows)

Main Query: SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM customersss;
Output:
  full_name  
-------------
 Varun Thakur
 Abhinav Lather
 Ayush Nagar
(3 rows)
