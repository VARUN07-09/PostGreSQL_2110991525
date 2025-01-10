QUESTION 1-> Design a database for an e-commerce store.
             Identify the primary key for the customers table.
             Define the foreign key relationship between orders and customers.


Query-> TABLE Customers (CustomerID SERIAL PRIMARY KEY, FirstName VARCHAR(50) NOT NULL, LastName VARCHAR(50) NOT NULL, Email VARCHAR(100) UNIQUE NOT NULL, Phone VARCHAR(15), Address TEXT);
CREATE DATABASE
CREATE TABLE
           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | customers | table | postgres
(1 row)

                                          Table "public.customers"
   Column   |          Type          | Collation | Nullable |                    Default                    
------------+------------------------+-----------+----------+-----------------------------------------------
 customerid | integer                |           | not null | nextval('customers_customerid_seq'::regclass)
 firstname  | character varying(50)  |           | not null | 
 lastname   | character varying(50)  |           | not null | 
 email      | character varying(100) |           | not null | 
 phone      | character varying(15)  |           |          | 
 address    | text                   |           |          | 
Indexes:
    "customers_pkey" PRIMARY KEY, btree (customerid)
    "customers_email_key" UNIQUE CONSTRAINT, btree (email)
Referenced by:
    TABLE "orders" CONSTRAINT "fk_customer" FOREIGN KEY (customerid) REFERENCES customers(customerid) ON DELETE CASCADE
    

CREATE TABLE
           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | customers | table | postgres
 public | orders    | table | postgres
(2 rows)



                                           Table "public.orders"
   Column    |            Type             | Collation | Nullable |                 Default                 
-------------+-----------------------------+-----------+----------+-----------------------------------------
 orderid     | integer                     |           | not null | nextval('orders_orderid_seq'::regclass)
 orderdate   | timestamp without time zone |           | not null | CURRENT_TIMESTAMP
 customerid  | integer                     |           | not null | 
 totalamount | numeric(10,2)               |           | not null | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (orderid)
Foreign-key constraints:
    "fk_customer" FOREIGN KEY (customerid) REFERENCES customers(customerid) ON DELETE CASCADE

