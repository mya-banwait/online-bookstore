-- QUERIES used in application
-- All of these can be found in the database.rb file as well

-- Sales Per Genre report
-- Note that the date string was replaced with a specific date in the code based on the current date/time, a random placeholder is shown 
select sum(price), genre
from book
join order_book
on book.isbn = order_book.isbn
where (select date from store_order where store_order.order_number = order_book.order_number) > '2020-03-22 12:00:00 AM'
group by genre;

-- Sales Per Author report
-- Same note as above about the hardcoded date applies here
select sum(price), author
from book
join order_book
on book.isbn = order_book.isbn
where (select date from store_order where store_order.order_number = order_book.order_number) > '2020-03-22 12:00:00 AM'
group by author;

-- Sales vs Expenditures report
-- Sales:
select sum(price)
from book
join order_book
on book.isbn = order_book.isbn;
-- Expenditures:
select round(sum((royalty/100)*price), 2)
from book
join order_book
on book.isbn = order_book.isbn;


-- Get current highest/most recent order_number created
select order_number from store_order
order by order_number desc
limit 1;

-- Get list of all books
select * from book;

-- Get list of books using search feature
-- Note that column is replaced with the attribute they're searching on and value is the value they entered
select * from book where column = value;

-- Find if there is a customer with a matching email and password
-- Note that email and password are replaced with the actual values the user entered
select * from customer where email = email and password = password;

-- Create new customer in database
-- name, address, email, password are specific user-entered values
insert into customer (name, address, email, password) values (name, address, email, password);

-- Find customer_id by email, email is replaced with actual email address value
select customer_id from customer where email = email;

-- Create new order
-- c_id is a customer_id, sql_d is a date in proper SQL format
insert into store_order (customer\_id, total, status, date) values (c_id, total, 'Processing', sql_d);

-- Gets most recent/highest order_number from the order table
select order_number from store_order order by order_number desc limit 1;

-- Get status of an order where order_num is a specific value
select status from store_order where order_number = order_num;

-- Decremenet stock of a book given its ISBN where isbn is a variable holding an actual isbn number
update book set stock = stock - 1 where ISBN = isbn;

-- Get publisher of book where isbn is a variable holding an actual isbn number
select * from publisher where publisher_id = (select publisher_id from book where ISBN = isbn);

-- Get name and bank account number of publisher where publisher_id is a variable
select name, bank_account from publisher where publisher_id = publisher_id;

-- Check if there is a store owner with the matching username and password where username and password are user-entered values
select * from owner where username = username and password = password;

-- Create new owner in the database
insert into owner (username, password) values (username, password);

-- Create new book in database
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values (isbn, pub_id, own_id, title, author, genre, price, royalty, stock);

-- Remove book from database based on an isbn value
delete from book where ISBN = isbn

