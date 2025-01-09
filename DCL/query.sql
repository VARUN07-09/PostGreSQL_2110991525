1-Grant the SELECT privilege on the "employees" table to a specific user.
ANSWER->
        QUERY->GRANT SELECT ON TABLE employees TO manager;

GRANT
                             List of roles
 Role name |                         Attributes                         
-----------+------------------------------------------------------------
 manager   | 
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS

CREATE ROLE
CREATE ROLE
CREATE ROLE
GRANT ROLE
                              List of roles
 Role name  |                         Attributes                         
------------+------------------------------------------------------------
 developers | Cannot login
 hr         | 
 manager    | 
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS
 sde        | 

CREATE ROLE
GRANT ROLE

2-Grant the INSERT privilege on the "employees" table to a group of users.

ANSWER->
        QUERY->GRANT INSERT ON TABLE staff TO GROUP developers;

GRANT
                              List of roles
 Role name  |                         Attributes                         
------------+------------------------------------------------------------
 developers | Cannot login
 hr         | 
 manager    | 
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS
 sde        | 
 sde2       | 

3-Revoke the UPDATE privilege on the "employees" table from a specific user.

ANSWER->
        QUERY->REVOKE UPDATE ON TABLE employees FROM manager;

REVOKE
            List of relations
 Schema |    Name     | Type  |  Owner   
--------+-------------+-------+----------
 public | departments | table | postgres
 public | employees   | table | postgres
 public | products    | table | postgres
(3 rows)

4-Grant all privileges on the "products" table to a specific role.

ANSWER->
        QUERY->GRANT ALL PRIVILEGES ON TABLE products TO manager;

GRANT

5-Revoke the DELETE privilege on the "products" table from all users.

ANSWER->
        QUERY-> REVOKE DELETE ON TABLE products FROM PUBLIC;

REVOKE

6-Grant the SELECT and INSERT privileges on the "departments" table to a specific user.

ANSWER->
        QUERY->GRANT SELECT, INSERT ON TABLE departments TO sde;

GRANT

7-Revoke all privileges on the "departments" table from a specific role.

ANSWER->
        QUERY->REVOKE ALL PRIVILEGES ON TABLE departments FROM manager;

REVOKE

8-Grant the USAGE privilege on a specific schema to a user.

ANSWER->
        QUERY-> CREATE SCHEMA alltables;
                ALTER TABLE products SET SCHEMA alltables;
                ALTER TABLE departments SET SCHEMA alltables;
                ALTER TABLE employees SET SCHEMA alltables;
                GRANT USAGE ON SCHEMA alltables TO hr;

CREATE SCHEMA
ALTER TABLE
ALTER TABLE
ALTER TABLE
GRANT
                              List of roles
 Role name  |                         Attributes                         
------------+------------------------------------------------------------
 developers | Cannot login
 hr         | 
 manager    | 
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS
 sde        | 
 sde2       | 

9-Revoke the USAGE privilege on a specific schema from a group of users.
ANSWER->
        QUERY->REVOKE USAGE ON SCHEMA alltables FROM GROUP developers;

REVOKE

10-Grant the CONNECT privilege to a new user.
ANSWER->
        QUERY->GRANT CONNECT ON DATABASE company TO hr;
GRANT
                              List of roles
 Role name  |                         Attributes                         
------------+------------------------------------------------------------
 developers | Cannot login
 hr         | 
 manager    | 
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS
 sde        | 
 sde2       | 
