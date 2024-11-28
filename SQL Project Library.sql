create database library;
use library;

CREATE TABLE books(
book_id INT PRIMARY KEY,
title VARCHAR(150) NOT NULL, 
author VARCHAR(150) NOT NULL,
genre VARCHAR(100) DEFAULT NULL,
publication_year INT,
available BOOLEAN );
desc books;

CREATE TABLE members(
member_id INT PRIMARY KEY,
first_name VARCHAR(25),
email VARCHAR(100) NOT NULL,
phone VARCHAR(20) DEFAULT NULL);
desc members;

CREATE TABLE transactions(
transaction_id INT PRIMARY KEY,
book_id INT,
member_id INT,
transaction_date DATE NOT NULL,
return_date DATE,
status VARCHAR(20),
FOREIGN KEY (book_id) REFERENCES books (book_id),
FOREIGN KEY (member_id) REFERENCES members (member_id)
); 
desc transactions;

INSERT INTO books
VALUES(1, 'Half Girlfriend' , 'Chetan Bhagat' , 'Romance' , 2000 , true),
(2, 'The monk who sold his ferrari' , 'Robin Sharma' , 'Non fiction' , 2010 , false),
(3, 'Revolution 2020' , 'Chetan Bhagat' , NULL , 2019 , false),
(4, 'A Bend in the River' , 'Naipaul' , 'Non fiction' , 1999 , true),
(5, 'A Bunch of Old Letter' , 'Jawaharlal Nehru' , NULL , 2006 , true),
(6, 'Indian Philosophy' , 'Dr. S. Radhakrishnan' , 'History' , 1898 , false);

select * from books;

INSERT INTO members
VALUES(10 , 'Steven' , 'steven.king@sqltutorial.org' , '123-456-7890'),
(11, 'Lex' , 'lex.de haan@sqltutorial.org' , NULL),
(12, 'Daniel' , 'daniel.faviet@sqltutorial.org' , '987-654-3210'),
(13, 'Ismael' , 'ismael.sciarra@sqltutorial.org' , '678-910-123');

select * from members;

INSERT INTO transactions
VALUES(100, 1, 12, '2023-01-15' , '2023-02-15' , 'returned'),
(101, 6, 10, '2022-10-05' , '2022-11-05' , 'returned'),
(102, 3, 13, '2023-01-15' , NULL , 'borrowed'),
(103, 3, 10, '2020-06-24' , '2020-07-23' , 'returned'),
(104, 4, 11, '2023-01-15' , NULL , 'borrowed');

select * from transactions;

/*Calculate the total number of books in library*/
select count(book_id)
from books

/*Find available books*/
select * from books
having available = true;
 
 /*Find books published after 2009*/
select * from books
where publication_year >'2009';

/*Count the number of transactions for each member*/
select first_name, count(transaction_id)
from members
left join transactions
on members.member_id = transactions.member_id
group by members.member_id;

/* Find the book title starting with letter T*/
select * from books
where title like 'T%%';

/*Find the books written by Chetan Bhagat*/
select * from books
where author like 'Chetan Bhagat';

/*Find the number of books in each genre*/
select genre, count(title)
from books 
group by genre

/*Calculate the total number of books borrowed*/
select count(title)
from transactions
left join books
on transactions.book_id = books.book_id
where status = 'borrowed';

/*Retrieve books borrowed but not yet returned*/
select title, status
from books 
left join transactions
on books.book_id = transactions.book_id
where status ='borrowed'

/*Retrieve books with their current availability status*/
select title as book_title,
CASE 
WHEN available THEN 'available'
ELSE 'borrowed'
END AS availability_status
from books;

/*Find the most borrowed book*/ 
select title , count(books.book_id) as most_borrowed
from books
left join transactions 
on books.book_id = transactions.book_id
group by title
order by count(books.book_id) desc
limit 1

/*Retrieve transactions with books and member details*/
select * from transactions
left join books
on transactions.book_id = books.book_id
left join members
on members.member_id = transactions.member_id 
