#!/usr/bin/ruby

require 'pg'
require 'date'

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

  # Check if the provided username and password match any entry in the customer table
  def customer_login(email, password)
    res = @con.exec("select * from customer where email = \'#{email}\' and password = \'#{password}\'")
    if res.ntuples > 0
      return true
    else
      return false
    end
  end

  # Create new customer in database
  def create_customer(name, email, address, password)
    res = @con.exec("insert into customer \(name, address, email, password\) values \(\'#{name}\', \'#{address}\', \'#{email}\', \'#{password}\'\)")
    return res.result_status
  end

  # Create new order in database
  def create_order(email, total)
    # Find customer_id for the given email
    res = @con.exec("select customer_id from customer where email = \'#{email}\'")
    return false if res.ntuples == 0
    c_id = res.values[0][0].to_i

    # Formats the current date/time in the desired SQL format
    d = Date.today
    sql_d = d.strftime("%Y-%m-%d")

    # Order creation query
    res = @con.exec("insert into store_order \(customer\_id, total, status, date\) values \(#{c_id}, \'#{total}\', 'Processing', \'#{sql_d}\'\)")
    if res.result_status
      res = @con.exec("select order\_number from store\_order order by order\_number desc limit 1")
      return res.values[0]
    else
      return false
    end
  end

  # Returns the status of the order with the given order number
  def get_order_status(order_num)
    res = @con.exec("select status from store_order where order_number = #{order_num}")
    print "\nStatus: "
    puts res.values[0]
  end

  # Decrease stock of the book (this is where the trigger function may be triggered if needed)
  def sell_book(isbn)
    res = @con.exec("update book set stock = stock - 1 where ISBN = \'#{isbn}\'")
    return res.result_status
  end

  # Return publisher of book
  def get_publisher(isbn)
    res = @con.exec("select * from publisher where publisher\_id = \(select publisher\_id from book where ISBN = \'#{isbn}\'\)")
    return res.values[0]
  end

  # Pay publisher to their bank account
  def pay_publisher(publisher_id, amount)
    publisher_id = publisher_id.to_i
    res = @con.exec("select name, bank\_account from publisher where publisher\_id = #{publisher_id}")
    puts "\nTransferred $#{amount} to: "
    puts res.values
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

  def create_owner(username, password)
    res = @con.exec("insert into owner \(username, password\) values \(\'#{username}\', \'#{password}\'\)")
    return res.result_status
  end

  def add_book(isbn, pub_id, own_id, title, author, genre, price, royalty, stock)
    res = @con.exec("insert into book \(ISBN, publisher\_id, owner\_id, title, author, genre, price, royalty, stock\) values \(\'#{isbn}\', #{pub_id}, #{own_id}, \'#{title}\', \'#{author}\', \'#{genre}\', #{price}, #{royalty}, #{stock}\)")
    return res.result_status
  end

  def remove_book(isbn)
    res = @con.exec("delete from book where ISBN = \'#{isbn}\'")
    return res.result_status
  end

  def sales_per_genre_report(period)
    if period == 1
      # 1 month ago
      d = Date.today - 30
      sql_d = d.strftime("%Y-%m-%d")
    else
      # 1 year ago
      d = Date.today - 365
      sql_d = d.strftime("%Y-%m-%d")
    end
    puts sql_d
    res = @con.exec(
      "select sum\(price\), genre from book join order\_book on book.isbn = order\_book.isbn
      where \(select date from store\_order where store\_order.order\_number = order\_book.order\_number\) > \'#{sql_d}\'
      group by genre"
    )

    puts "\nSALES PER GENRE\n---------------"
    # puts res.values
    res.values.map do |row|
      puts "#{row[1]} = $#{row[0]}"
    end
  end

  def sales_per_author_report(period)
    if period == 1
      # 1 month ago
      d = Date.today - 30
      sql_d = d.strftime("%Y%m%d %H:%M:%S %p")
    else
      # 1 year ago
      d = Date.today - 365
      sql_d = d.strftime("%Y%m%d %H:%M:%S %p")
    end

    res = @con.exec(
      "select sum\(price\), author from book join order\_book on book.isbn = order\_book.isbn
      where \(select date from store\_order where store\_order.order\_number = order\_book.order\_number\) > \'#{sql_d}\'
      group by author"
    )

    puts "\nSALES PER AUTHOR\n---------------"
    res.values.map do |row|
      puts "#{row[1]} = $#{row[0]}"
    end
  end

  def sales_vs_exp_report(period)
    res = @con.exec("select sum \(price\) from book join order\_book on book.isbn = order\_book.isbn")
    print "Sales: $"
    puts res.values[0]
    res = @con.exec("select round \(sum\(\(royalty/100\) * price\), 2\) from book join order\_book on book.isbn = order\_book.isbn")
    print "Expenditures: $"
    puts res.values[0]
  end
      
      
  rescue PG::Error => e
      puts e.message 
      
  ensure
      @con.close if @con
  end


end