Q1: How do you create a view in PostgreSQL?

Query: CREATE VIEW employee_salary_view AS
SELECT employee_id, name, salary
FROM employees
WHERE salary > 50000;

CREATE VIEW
                List of relations
 Schema |         Name         | Type |  Owner   
--------+----------------------+------+----------
 public | employee_salary_view | view | postgres
(1 row)


Q2: What are the benefits of using views?
--Theory: Simplification of Complex Queries: Views allow you to encapsulate complex queries and provide a simplified interface to users, making it easier to interact with the data.
--        Abstraction: Views provide an abstraction layer over the underlying tables, so users can work with predefined data structures rather than needing to understand complex joins and subqueries.
--        Data Security: Views can expose only specific columns or rows of data, improving security by restricting access to sensitive information.
--        Reusability: Once defined, views can be reused in multiple queries without needing to rewrite the logic each time.


Q3: How can you update data through a view?

Query: UPDATE employee_salary_view
advance_query-# SET salary = 60000
advance_query-# WHERE employee_id = 1;

UPDATE 1
 employee_id | name |  salary  
-------------+------+----------
           2 | B    | 60000.00
           3 | C    | 55000.00
           4 | D    | 70000.00
           5 | E    | 65000.00
           1 | A    | 60000.00
(5 rows)


Q4: What are the limitations of using views?
--Theory: Performance Overhead: Views can sometimes introduce performance overhead, especially when they are based on complex queries or large datasets. Each time the view is accessed, the underlying query is executed.
--        Non-Updatable Views: Views based on joins, aggregates, or other complex operations may not allow direct updates, making them less flexible in some cases.


Q5: How can you use views to improve data security?

--Theory: Restricting Data Access: You can create views that expose only a subset of the data (e.g., only certain columns or rows) to users, preventing them from accessing sensitive or irrelevant information.
--        Hiding Sensitive Data: You can hide sensitive columns like passwords or personal information in the underlying tables by not including them in the view.

Query: CREATE VIEW employee_info AS
SELECT employee_id, name
FROM employees;

CREATE VIEW
            List of relations
 Schema |     Name      | Type |  Owner   
--------+---------------+------+----------
 public | employee_info | view | postgres
(1 row)


Q6: How can you use views to simplify complex queries?

Query: CREATE VIEW employee_details_view AS
advance_query-# SELECT e.employee_id, e.name, d.department_name, e.salary
advance_query-# FROM employees e
advance_query-# JOIN departments d ON e.department_id = d.department_id;

CREATE VIEW

Query: SELECT * FROM employee_details_view WHERE salary > 50000;

 employee_id | name | department_name |  salary  
-------------+------+-----------------+----------
           2 | B    | Sales           | 60000.00
           3 | C    | Sales           | 55000.00
           4 | D    | IT              | 70000.00
           5 | E    | Finance         | 65000.00
           1 | A    | HR              | 60000.00
(5 rows)


Q7: How do you drop a view in PostgreSQL?

Query: DROP VIEW employee_salary_view;

DROP VIEW


Q8: Can a view be based on another view?

Query: CREATE VIEW department_salary_view AS
SELECT department_name, AVG(salary) AS average_salary
FROM employee_details_view
GROUP BY department_name;

CREATE VIEW


Q9: What are some common use cases for views?

--Theory: Data Aggregation: Views can be used to pre-aggregate data (e.g., calculating sums, averages, or counts) for reporting purposes.
--        Data Abstraction: Views can abstract the complexity of database schema and logic, presenting users with a simpler interface to interact with.
--        Data Filtering: Views can be used to filter data for specific use cases (e.g., showing only active customers or employees).


Q10: How can you use views to implement data virtualization?

--Theory: Data virtualization refers to the technique of providing a simplified view of data from multiple sources without physically moving or replicating the data.