1-Insert three new employees into the "employees" table

ANSWER-> 
INSERT 0 3


2-Retrieve all employee records from the "employees" table.

ANSWER->

 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
         101 | Varun      | Thakur    |  50000
         102 | Rahul      | Sharma    |  60000
         103 | sehaj      | Gill      |  55000
(3 rows)


3-Retrieve only the first and last names of all employees.

ANSWER->

first_name | last_name 
------------+-----------
 Varun      | Thakur
 Rahul      | Sharma
 sehaj      | Gill
(3 rows)




4-Update the salary of an employee with a specific employee_id.

ANSWER->
UPDATE 2


 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
         102 | Rahul      | Sharma    |  70000
(1 rows)

5-Delete the record of an employee with a specific employee_id.

ANSWER->

DELETE 2
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
         101 | Varun      | Thakur    |  50000
         103 | sehaj      | Gill      |  55000
(2 rows)

6-Retrieve all employees whose salary is greater than a certain amount.

ANSWER->

 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
         103 | sehaj      | Gill      |  55000


7-Insert five new products into the "products" table.

ANSWER->

INSERT 0 5
 product_id | product_name | price  
------------+--------------+--------
        201 | Laptop       | 800.00
        202 | Mouse        |  25.00
        203 | Keyboard     |  45.00
        204 | Monitor      | 200.00
        205 | Printer      | 150.00
(5 rows)

8-Update the price of a specific product.

ANSWER->

UPDATE 1
 product_id | product_name | price  
------------+--------------+--------
        201 | Laptop       | 800.00
        202 | Mouse        |  25.00
        203 | Keyboard     |  45.00
        205 | Printer      | 150.00
        204 | Monitor      | 220.00
(5 rows)

9-Retrieve all products with a price between a certain range.

ANSWER->


 product_id | product_name | price  
------------+--------------+--------
        205 | Printer      | 150.00
        204 | Monitor      | 220.00
(2 rows)

10-Delete all products with a price below a certain threshold.

ANSWER->

DELETE 2
 product_id | product_name | price  
------------+--------------+--------
        201 | Laptop       | 800.00
        205 | Printer      | 150.00
        204 | Monitor      | 220.00
(3 rows)

