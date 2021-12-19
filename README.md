# Online Bookstore Application (Look Inna Book)

COMP 3005 Fall 2021 Final Project<br>
Ahmed El-Roby<br>
 --> Note: The project report contains the diagram of the application's workflow as well as all screenshots of the application's interfaces/features. This README contains compilation/running instructions and a description of the project's technical architecture.

## Dependencies

* [Ruby](https://www.ruby-lang.org/en/).  Written with version [2.7.0](https://www.ruby-lang.org/en/news/2019/12/25/ruby-2-7-0-released/) - *[docs](https://docs.ruby-lang.org/en/2.7.0/)*.

The base of this repository was generated as an empty Ruby project using https://github.com/deciduously/ruby-template and by following project setup steps on https://dev.to/deciduously/setting-up-a-fresh-ruby-project-56o4.

This project makes use of the following Ruby gem which interfaces PostgreSQL: https://github.com/ged/ruby-pg
Since the project uses PostgreSQL, it currently only works locally by connecting to your local PG with personal credentials, then creating my bookstore database using an application such as pgAdmin. All SQL files are provided in the SQL folder of this application to assist with that.

## Usage

Clone this repository on your local environment
Install dependencies: `gem install bundler && bundle install` <br>
Run `rake` to run the program.

Note: As explained above, the database needs to be created locally. You also need to switch the PG credentials on line 12 of `database.rb` for values that work for your system.

## Project Overview

This is a command-line application that represents an online bookstore. It has a separate interface for store customers and storeowners to allow users to either browse the store and place orders or act as admin to manage the store. <br>

Application features include:
<ul>
  <li>Browse collection of books</li>
  <li>Search for books by title, author, ISBN, genre</li>
  <li>View information about specific books and add them to a shopping cart</li>
  <li>Checkout your cart to place an order</li>
  <li>Track where your order currently is</li>
  <li>Login and register as a customer</li>
  <li>Login and create new accounts as a storeowner</li>
  <li>Add and remove books from the store (admin)</li>
  <li>View sales reports (admin)</li>
  <li>Automatic actions such as paying publishers royalty for their book sales, restocking books when stock falls under threshold</li>
</ul>
  
## Project Architecture

The project is made in Ruby and uses PG SQL. 

File Structure:

online-bookstore<br>
 ┣ .github<br>
 ┃ ┗ workflows<br>
 ┃ ┃ ┗ ruby.yml<br>
 ┣ SQL<br>
 ┃ ┣ DDL.sql<br>
 ┃ ┣ InsertionFile.sql<br>
 ┃ ┣ Queries.sql<br>
 ┃ ┗ Triggers.sql<br>
 ┣ lib<br>
 ┃ ┣ bookstore.rb<br>
 ┃ ┗ database.rb<br>
 ┣ test<br>
 ┣ usr<br>
 ┃ ┗ bin<br>
 ┃ ┃ ┗ ruby<br>
 ┃ ┃ ┃ ┣ lib_version.rb<br>
 ┃ ┃ ┃ ┗ password_authentication.rb<br>
 ┣ .gitignore<br>
 ┣ Gemfile<br>
 ┣ Gemfile.lock<br>
 ┣ LICENSE<br>
 ┣ README.md<br>
 ┗ Rakefile<br>
 
 Many of the above files are just to get the Ruby project running. The Rakefile has instructions that allow the command `rake` to compile and run the program. The `Gemfile` has the Ruby gems that are installed as dependencies when you run `gem install`, for example the PG gem is listed there. 
 
 Almost all the code written for the application is in `bookstore.rb` and `database.rb`. `bookstore.rb` is where all the command-line logic is and general flow of the store. This file interacts with `database.rb` which is the behind-the-scenes logic that executes database queries and returns information back to `bookstore.rb`.
 
 The SQL folder contains queries to create the database tables (`DDL.sql`), insertions to start the tables off with some fake data (`InsertionFile.sql`), and a list of all queries and triggers used (`Queries.sql`, `Triggers.sql`).
 
