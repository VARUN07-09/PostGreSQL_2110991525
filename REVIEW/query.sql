CREATE DATABASE
QUERY1 ->DDL (Data Definition Language):
   * Create the following tables:
     * Books with columns: book_id, title, author, publication_year, genre.
     * Members with columns: member_id, name, address, contact_number.
     * Borrowings with columns: borrowing_id, book_id, member_id, borrow_date, due_date, returned_date.4
     
CREATE TABLE
         List of relations
 Schema | Name  | Type  |  Owner   
--------+-------+-------+----------
 public | books | table | postgres
(1 row)

CREATE TABLE
          List of relations
 Schema |  Name   | Type  |  Owner   
--------+---------+-------+----------
 public | books   | table | postgres
 public | members | table | postgres
(2 rows)

DROP TABLE
DROP TABLE
CREATE TABLE
         List of relations
 Schema | Name  | Type  |  Owner   
--------+-------+-------+----------
 public | books | table | postgres
(1 row)

CREATE TABLE
          List of relations
 Schema |  Name   | Type  |  Owner   
--------+---------+-------+----------
 public | books   | table | postgres
 public | members | table | postgres
(2 rows)

CREATE TABLE
           List of relations
 Schema |    Name    | Type  |  Owner   
--------+------------+-------+----------
 public | books      | table | postgres
 public | borrowings | table | postgres
 public | members    | table | postgres
(3 rows)

                                         Table "public.books"
      Column      |       Type        | Collation | Nullable |                Default                 
------------------+-------------------+-----------+----------+----------------------------------------
 book_id          | integer           |           | not null | nextval('books_book_id_seq'::regclass)
 title            | character varying |           |          | 
 author           | character varying |           |          | 
 publication_year | integer           |           |          | 
 genre            | character varying |           |          | 
Indexes:
    "books_ pkey" PRIMARY KEY, btree (book_id)
Referenced by:
    TABLE "borrowings" CONSTRAINT "borrowings_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(book_id)

                                      Table "public.members"
  Column   |       Type        | Collation | Nullable |                  Default                   
-----------+-------------------+-----------+----------+--------------------------------------------
 member_id | integer           |           | not null | nextval('members_member_id_seq'::regclass)
 name      | character varying |           |          | 
 address   | character varying |           |          | 
 contact   | integer           |           |          | 
Indexes:
    "members_pkey" PRIMARY KEY, btree (member_id)
Referenced by:
    TABLE "borrowings" CONSTRAINT "borrowings_member_id_fkey" FOREIGN KEY (member_id) REFERENCES members(member_id)

                                     Table "public.borrowings"
     Column     |  Type   | Collation | Nullable |                     Default                      
----------------+---------+-----------+----------+--------------------------------------------------
 borrowing_id   | integer |           | not null | nextval('borrowings_borrowing_id_seq'::regclass)
 book_id        | integer |           |          | 
 member_id      | integer |           |          | 
 borrow_date    | date    |           |          | 
 due_date       | date    |           |          | 
 reuturned_date | date    |           |          | 
Indexes:
    "borrowings_pkey" PRIMARY KEY, btree (borrowing_id)
Foreign-key constraints:
    "borrowings_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(book_id)
    "borrowings_member_id_fkey" FOREIGN KEY (member_id) REFERENCES members(member_id)

INSERT 0 5
                                         Table "public.books"
      Column      |       Type        | Collation | Nullable |                Default                 
------------------+-------------------+-----------+----------+----------------------------------------
 book_id          | integer           |           | not null | nextval('books_book_id_seq'::regclass)
 title            | character varying |           |          | 
 author           | character varying |           |          | 
 publication_year | integer           |           |          | 
 genre            | character varying |           |          | 
Indexes:
    "books_pkey" PRIMARY KEY, btree (book_id)
Referenced by:
    TABLE "borrowings" CONSTRAINT "borrowings_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(book_id)

 book_id | title | author  | publication_year | genre  
---------+-------+---------+------------------+--------
       1 | book1 | author1 |             2020 | genre1
       2 | book2 | author2 |             2021 | genre2
       3 | book3 | auhtor3 |             2022 | genre3
       4 | book4 | author4 |             2023 | genre4
       5 | book5 | author1 |             2024 | genre5
(5 rows)

ALTER TABLE
INSERT 0 5
 member_id |   name    |   address   |  contact   
-----------+-----------+-------------+------------
         1 | Varun     | Nangal      | 7707908940
         2 | Vishal    | Varanasi    | 8299772709
         3 | Abhinav   | kurukshetra | 8549678960
         4 | Ayush     | Saharanpur  | 7854912345
         5 | Priyanshu | Housefed    | 7707954321
(5 rows)

