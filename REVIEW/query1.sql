QUEST1 ->* DDL (Data Definition Language):
   * Create the following tables:
     * Books with columns: book_id, title, author, publication_year, genre.
     * Members with columns: member_id, name, address, contact_number.
     * Borrowings with columns: borrowing_id, book_id, member_id, borrow_date, due_date, returned_date.

     query CREATE TABLE Books (book_id serial primary key, title varchar, author var
char , publication_year integer ,genre varchar);

Table "public.books"
      Column      |          Type          | Collation | Nullable |                Default                 
------------------+------------------------+-----------+----------+----------------------------------------
 book_id          | integer                |           | not null | nextval('books_book_id_seq'::regclass)
 title            | character varying(100) |           |          | 
 publication_year | integer                |           |          | 
 genre            | character varying(100) |           |          | 
 author           | character varying(100) |           |          | 
Indexes:
    "books_pkey" PRIMARY KEY, btree (book_id)
Referenced by:
    TABLE "borrowings" CONSTRAINT "borrowings_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(book_id)

Query CREATE TABLE Members (member_id serial primary key, name varchar, address
 varchar , contact integer);

                                           Table "public.members"
     Column     |          Type          | Collation | Nullable |                  Default                   
----------------+------------------------+-----------+----------+--------------------------------------------
 member_id      | integer                |           | not null | nextval('members_member_id_seq'::regclass)
 name           | character varying(100) |           |          | 
 addess         | character varying(100) |           |          | 
 contact_number | character varying(10)  |           |          | 
Indexes:
    "members_pkey" PRIMARY KEY, btree (member_id)
Referenced by:
    TABLE "borrowings" CONSTRAINT "borrowings_member_id_fkey" FOREIGN KEY (member_id) REFERENCES members(member_id)

query CREATE TABLE Borrowings (borrowing_id serial primary key , book_id int references books(book_id), member_id int references members(member_id), borrow_date DATE , due_date DATE, reuturned_date DATE);



                                     Table "public.borrowings"
    Column     |  Type   | Collation | Nullable |                     Default                      
---------------+---------+-----------+----------+--------------------------------------------------
 borrowing_id  | integer |           | not null | nextval('borrowings_borrowing_id_seq'::regclass)
 book_id       | integer |           |          | 
 member_id     | integer |           |          | 
 borrow_date   | date    |           |          | 
 due_date      | date    |           |          | 
 returned_date | date    |           |          | 
Indexes:
    "borrowings_pkey" PRIMARY KEY, btree (borrowing_id)
Foreign-key constraints:
    "borrowings_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(book_id)
    "borrowings_member_id_fkey" FOREIGN KEY (member_id) REFERENCES members(member_id)

QUEST2-> * DML (Data Manipulation Language):
   * Insert sample data into each table (at least 5 records per table)

query INSERT INTO books (title, author, publication_year , genre) VALUES ('book
1', 'author1', 2020, 'genre1'), ('book2', 'author2' , 2021 , 'genre2'), ('book3', 'auh
tor3', 2022, 'genre3'), ('book4', 'author4', 2023, 'genre4'), ('book5', 'author1', 2024, 'genre5');
 INSERT 0 5

 book_id | title  | publication_year | genre  | author  
---------+--------+------------------+--------+---------
       1 | title1 |             2000 | genre1 | author1
       2 | title2 |             2002 | genre2 | author2
       3 | title3 |             2003 | genre3 | author3
       4 | title4 |             2004 | genre4 | author4
       5 | title5 |             2005 | genre5 | author5
(5 rows)

query INSERT INTO members (name, addresss , contact) VALUES ('Varun','Nangal',7
707908940), ('Vishal', 'Varanasi', 8299772709), ('Abhinav', 'kurukshetra' ,8549678960)
, ('Ayush', 'Saharanpur', 7854912345), ('Priyanshu', 'Housefed',7707954321);

 INSERT 0 5
 member_id | name      |  addess     | contact
-----------+-----------+-------------+------------
         1 | Varun     | Nangal      | 7707908940
         2 | Vishal    | Varanasi    | 8299772709
         3 | Abhinav   | kurukshetra | 8549678960
         4 | Ayush     | Saharanpur  | 7854912345
         5 | Priyanshu | Housefed    | 7707954321
(5 rows)

query INSERT INTO borrowings (book_id,member_id,borrow_date,due_date,returned_date) VALUES(1,1,'2025-01-11','2025-01-21','2025-01-20'),(1,1,'2025-02-12','2025-01-21','2025-02-22'),(3,3,'2025-03-13','2025-03-22','2025-03-23'),(4,4,'2025-04-14','2025-04-23','2025-04-24'),(5,5,'2025-05-15','2025-05-24','2025-05-25');
 INSERT 0 5
 borrowing_id | book_id | member_id | borrow_date |  due_date  | returned_date 
--------------+---------+-----------+-------------+------------+---------------
            1 |       1 |         1 | 2025-01-11  | 2025-01-21 | 2025-01-20
            2 |       1 |         1 | 2025-02-12  | 2025-01-21 | 2025-02-22
            3 |       3 |         3 | 2025-03-13  | 2025-03-22 | 2025-03-23
            4 |       4 |         4 | 2025-04-14  | 2025-04-23 | 2025-04-24
            5 |       5 |         5 | 2025-05-15  | 2025-05-24 | 2025-05-25
(5 rows)

QUEST3-> * DQL (Data Query Language):
   * Write queries to:
     * Retrieve all books by a specific author.
     * Find members who have borrowed a particular book.
     * Display books that are currently overdue.
     * Calculate the total number of books borrowed by each member.


QUERY

 book_id | title  | publication_year | genre  | author  
---------+--------+------------------+--------+---------
       5 | title5 |             2005 | genre5 | author5
(1 row) name  


-------
 name4
(1 row) title 

-------
(0 rows)

 name  | total_books_borrowed 
-------+----------------------
 name3 |                    1
 name4 |                    1
 name5 |                    1
 name1 |                    2
(4 rows)