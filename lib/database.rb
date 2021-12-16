#!/usr/bin/ruby

require 'pg'

class Database

    # The following block of code uses the Ruby PG (postgres) to connect to the local bookstore database that I created in postgres
    # It connects to it using the authentication/credentials that I setup for my system
    # The begin keyword matches with the rescue/ensure keywords at the end of the file which are responsible for error handling and closing the PG connection
    begin
    def initialize()
      @con = PG.connect :dbname => 'bookstore', :user => 'postgres', 
          :password => 'rsjm#5123'

      user = @con.user
      db_name = @con.db
      pswd = @con.pass

      # puts "User: #{user}"
      # puts "Database name: #{db_name}"
      # puts "Password: #{pswd}" 
    end


  # --- QUERY METHODS ---

  # --- CUSTOMER INTERFACE METHODS ---
  # Return list of all books in database
  def get_books
    res = @con.exec('select * from book')
    return res.values
  end

  # Return matching book if possible based on specific search criteria
  def search_books(column, value)
    res = @con.exec("select * from book where #{column} = \'#{value}\'")
    return res.values
  end
  
  # --- OWNER INTERFACE METHODS ---
  # Check if the provided username and password match any entry in the owner table
  def owner_login(username, password)
    res = @con.exec("select * from owner where username = \'#{username}\' and password = \'#{password}\'")
    if res.ntuples > 0
      return true
    else
      return false
    end
  end


      
      
  rescue PG::Error => e
      puts e.message 
      
  ensure
      @con.close if @con
  end


end