CREATE TABLE
                                          Table "public.books"
     Column      |          Type          | Collation | Nullable |                Default                
-----------------+------------------------+-----------+----------+---------------------------------------
 bookid          | integer                |           | not null | nextval('books_bookid_seq'::regclass)
 title           | character varying(200) |           | not null | 
 author          | character varying(100) |           |          | 
 publishedyear   | integer                |           |          | 
 copiesavailable | integer                |           |          | 0
Indexes:
    "books_pkey" PRIMARY KEY, btree (bookid)

                                          Table "public.borrowers"
   Column   |          Type          | Collation | Nullable |                    Default                    
------------+------------------------+-----------+----------+-----------------------------------------------
 borrowerid | integer                |           | not null | nextval('borrowers_borrowerid_seq'::regclass)
 name       | character varying(100) |           | not null | 
 email      | character varying(100) |           | not null | 
 phone      | character varying(15)  |           |          | 
Indexes:
    "borrowers_pkey" PRIMARY KEY, btree (borrowerid)
    "borrowers_email_key" UNIQUE CONSTRAINT, btree (email)

CREATE TABLE
                                     Table "public.borrowedbooks"
    Column     |  Type   | Collation | Nullable |                       Default                        
---------------+---------+-----------+----------+------------------------------------------------------
 transactionid | integer |           | not null | nextval('borrowedbooks_transactionid_seq'::regclass)
 borrowerid    | integer |           | not null | 
 bookid        | integer |           | not null | 
 borrowdate    | date    |           | not null | CURRENT_DATE
 returndate    | date    |           |          | 
Indexes:
    "borrowedbooks_pkey" PRIMARY KEY, btree (transactionid)
Foreign-key constraints:
    "fk_book" FOREIGN KEY (bookid) REFERENCES books(bookid) ON DELETE CASCADE
    "fk_borrower" FOREIGN KEY (borrowerid) REFERENCES borrowers(borrowerid) ON DELETE CASCADE

