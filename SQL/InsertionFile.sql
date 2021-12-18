-- relationsInsertFile.sql
-- This file has the SQL code that insert/seeds database tables with fake information for testing/experimenting purposes
-- On my local postgres system, I have inserted all of this into my bookstore database using pgAdmin

-- Before insertion, clear all tables
delete from customer;
delete from owner;
delete from store_order;
delete from publisher;
delete from book;
delete from order_book;

-- Insert customers
insert into customer (name, address, email, password) values ('Peter Bray', '90 Front St., Port Hope, ON L1A 2A3', 'peterbray@gmail.com', '6HyZzF');
insert into customer (name, address, email, password) values ('Esther Powell', '40 Talbot Lane, Burnaby, BC V3N 4S9', 'estherpowell@hotmail.com', 'xUM5XY');
insert into customer (name, address, email, password) values ('Erik Byrd', '1 Sage St., St. Andrews, NB E5B 1X3', 'erikbyrd@gmail.com', 'yZh5sn');
insert into customer (name, address, email, password) values ('Hassan Solomon', '533 New Ave., Windsor, ON N8P 4L9', 'hassansolomon@rogers.com', '8bUZhu');
insert into customer (name, address, email, password) values ('Shayna Delgado', '82 Vermont St., Chatham, QC J8G 7H2', 'shaynadelgado@gmail.com', 'ugu2Kh');
insert into customer (name, address, email, password) values ('Chad Lucas', '652 W. Rockland St., Doaktown, NB E9C 2E9', 'chadlucas@gmail.com', 'Hu3UVS');
insert into customer (name, address, email, password) values ('Baron Gardner', '554 Bridgeton Street, La Baie, QC G7B 8E9', 'barongardner@rogers.com', '8dWNCX');
insert into customer (name, address, email, password) values ('Elaine Galvan', '13 Sunset Street, Beauharnois, QC J6N 0G8', 'elaingalvan@gmail.com', 'X5XCrC');
insert into customer (name, address, email, password) values ('Georgia Fields', '73 Highland Drive, Petitcodiac, NB E4Z 9K4', 'georgiafields@hotmail.com', 'Fc5st8');
insert into customer (name, address, email, password) values ('Stephany Cline', '98 Academy St., Huron, ON N0G 8R1', 'stephanylane@gmail.com', 'Dd8F8p');
insert into customer (name, address, email, password) values ('Francis Austin', '7 Blue Spring Ave., Bayfield, NB E4M 7J8', 'francisaustin@gmail.com', 'Wpu7FC');
insert into customer (name, address, email, password) values ('Nikhil Pearson', '9146 Randall Mill Street, Quesnel, BC V2J 1B2', 'nikhilpearson@rogers.com', 'q4X5Ef');

-- Insert orders
insert into store_order (customer_id, total, status, date) values (2, 45.50, 'Delivered', '20210618 10:34:09 AM');
insert into store_order (customer_id, total, status, date) values (5, 16.24, 'At Warehouse', '20211010 11:24:04 AM');
insert into store_order (customer_id, total, status, date) values (11, 33.18, 'Delivered', '20210701 09:11:19 PM');
insert into store_order (customer_id, total, status, date) values (1, 72.27, 'Processing', '20211104 08:06:58 AM');
insert into store_order (customer_id, total, status, date) values (7, 18.50, 'Delivered', '20200512 04:12:42 PM');

-- Insert publishers
insert into publisher (name, address, email, bank_account) values ('Community Publishing Group', '23 Santa Clara St., Olds, AB T4H 6Y8', 'anne@comunitypub.com', '003_101843');
insert into publisher (name, address, email, bank_account) values ('Springfield Publishing', '9974 South Ryan Rd., Innisfil, ON L9S 9Y9', 'manage@springfield.com', '006_9928374');
insert into publisher (name, address, email, bank_account) values ('David Inselman Publishing', '7850 Baker Court, Drayton Valley, AB T7A 6P1', 'office@davidinselman.com', '003_803421');
insert into publisher (name, address, email, bank_account) values ('Spirit Publishing', '45 E. Locust Street, Simcoe, ON N3Y 5S1', 'john@spiritpub.com', '004_647891112');

-- Insert owners
insert into owner (username, password) values ('catherine_gibson', 'm9zJH5aG');
insert into owner (username, password) values ('joe_samson', 'VAv3Q9HA');
insert into owner (username, password) values ('kelly_lucas', 'qwVS8AUE');
insert into owner (username, password) values ('jenna_pollard', 'Y4df5DWv');
insert into owner (username, password) values ('rodrigo_baird', 'z8tnCjYY');

-- Insert books
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-8-9933-9590-7', 1, 2, 'Professional Return', 'Harmony Montgomery', 'Suspense', 16.99, 25, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-1-1422-0121-0', 4, 3, 'The Fallen Sky', 'Jonathan Owen', 'Fantasy', 12.99, 30, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-0-6911-1326-5', 2, 5, 'The Abyss Soul', 'Jonathan Owen', 'Fantasy', 20.99, 30, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-5-2306-6391-1', 4, 2, 'Time of Thought', 'Jaxson Stevens', 'Fantasy', 14.99, 18, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-9-5921-2175-1', 1, 3, 'Successful Management', 'Raiden Livingston', 'Non-fiction', 16.99, 20, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-0-2780-2140-2', 3, 4, 'First Snow', 'Yareli Hatfield', 'Children', 10.99, 25, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-4-4325-4104-1', 3, 2, 'Husband of Ashes', 'Logan Yoder', 'Suspense', 22.99, 26, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-7-4807-0234-1', 2, 1, 'The Magnificent Ships', 'Conor Stephens', 'Children', 9.99, 28, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-2-9464-3067-7', 2, 1, 'Bride of Years', 'Tiffany Kline', 'Romance', 17.99, 25, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-4-3192-7078-1', 4, 5, 'The Waves of the Courage', 'Kamryn Franco', 'Romance', 10.99, 15, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-7-3049-9106-7', 3, 3, 'Complete History of Baseball', 'Myles Curry', 'Non-fiction', 20.99, 30, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-4-7043-9500-6', 4, 4, 'The Lonely Rose', 'Tiffany Kline', 'Romance', 12.99, 20, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-3-6728-9163-3', 3, 2, 'Wizards of Stars', 'Kolton Bradley', 'Fantasy', 15.99, 28, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-5-3450-4476-6', 1, 1, 'Space and Things', 'Maribel Davies', 'Non-fiction', 11.99, 25, 3);
insert into book (ISBN, publisher_id, owner_id, title, author, genre, price, royalty, stock) values ('978-6-3838-2289-7', 2, 1, 'The Darkest Shadow', 'Harmony Montgomery', 'Suspense', 18.99, 30, 3);

-- Insert attachements of books to orders
insert into order_book (order_number, ISBN) values (1, '978-2-9464-3067-7');
insert into order_book (order_number, ISBN) values (1, '978-4-7043-9500-6');
insert into order_book (order_number, ISBN) values (2, '978-6-3838-2289-7');
insert into order_book (order_number, ISBN) values (3, '978-5-2306-6391-1');
insert into order_book (order_number, ISBN) values (4, '978-1-1422-0121-0');
insert into order_book (order_number, ISBN) values (4, '978-4-3192-7078-1');
insert into order_book (order_number, ISBN) values (4, '978-8-9933-9590-7');
insert into order_book (order_number, ISBN) values (5, '978-4-7043-9500-6');
