-- DDL.sql
-- This file has the SQL code that creates all database tables
-- On my local postgres system, I have created these tables for the bookstore database by copying all these lines into pgAdmin

-- Create table that stores registered customers and their data
create table customer
	(customer_id		serial,
	 name		varchar(30),
	 address		varchar(100),
   email    varchar(319),
	 password   varchar(15),
	 primary key (customer_id)
	);

-- Create table that stores order information -- this table is called 'store_order' instead of 'order' due to the SQL keyword
create table store_order
	(order_number   serial, 
	 customer_id		int, 
	 total    numeric(19,2),
   status   varchar(30),
   date   DATE,
	 primary key (order_number),
   foreign key (customer_id) references customer
	);

-- Create table that stores publishers and their data
create table publisher
	(publisher_id		serial, 
	 name			varchar(30), 
	 address		varchar(100),
	 email		varchar(319),
   bank_account   varchar(20),
	 primary key (publisher_id)
	);

-- Create table that stores storeowners/admin and their adata
create table owner
	(owner_id		serial,
   username   varchar(20),
   password   varchar(15),
	 primary key (owner_id)
	);

-- Create table that stores books and their data
create table book
	(ISBN			varchar(17), 
	 publisher_id			int, 
	 owner_id		int, 
	 title		varchar(50),
   author   varchar(30),
   genre    varchar(20),
	 price		numeric(19,2),
	 royalty		numeric(19,4),
	 stock		int,
	 primary key (ISBN),
	 foreign key (publisher_id) references publisher,
   foreign key (owner_id) references owner
	);

-- Create table that stores information on which books are part of which orders
create table order_book
	(order_number			serial,
	 ISBN			varchar(17),
	 primary key (order_number, ISBN),
	 foreign key (ISBN) references book,
	 foreign key (order_number) references store_order
	);
