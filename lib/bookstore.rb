# This is the executable file that gets called from the command line then takes user input, controls flow, and communicates with the database file
#!/usr/bin/ruby

# This pulls in database.rb as a dependency
require_relative 'database'

def enter_bookstore
  #  This input determines which of the two user interfaces to enter
  choice = 0
  while choice < 1 || choice > 3
    puts "\nWelcome to Look Inna Book! 📚\n\n(1) I'm a customer\n(2) I'm a storeowner\n(3) Quit"
    print "\nEnter a number: "
    choice = gets.chomp.to_i

    case choice
    when 1
      customer_interface
      choice = 0
    when 2
      owner_interface
      choice = 0
    when 3
      puts "\nQuitting Application 👋"
      return
    else
      puts "Invalid entry"
    end
  end
end

# Interface 1: For customers of the store
def customer_interface
  choice = 0
  while choice < 1 || choice > 5
    puts "\n(1) Browse list of all books\n(2) Search for books by criteria\n(3) Checkout cart\n(4) Track order status\n(5) Return to homepage"
    print "\nEnter a number: "
    choice = gets.chomp.to_i

    case choice
    # Browse all books in store with no filters/search criteria
    when 1
      books = @db.get_books
      book_num = display_books(books)

      if book_num < 1 || book_num > books.length
        puts "--> Invalid book number"
      else
        display_book(books[book_num-1])
        add_to_cart(books[book_num-1])
      end


    # Search for books using specific ISBN/title/author/genre
    when 2
      puts "(1) By title\n(2) By ISBN\n(3) By author\n(4) By genre"
      print "\nEnter number for how you would like to search: "
      search_type = gets.chomp.to_i

      if search_type < 1 || search_type > 4
        puts "--> Invalid selection"
      else
        print "\nEnter search term: "
        search_term = gets.chomp

        case search_type
        # Title
        when 1
          column = "title"
        # ISBN
        when 2
          column = "ISBN"
        # Author
        when 3
          column = "author"
        # Genre
        else
          column = "genre"
        end

        # Search results
        books = @db.search_books(column, search_term)
        puts "\n-- RESULTS --"
        book_num = display_books(books)

        if book_num < 1 || book_num > books.length
          puts "--> Invalid book number"
        else
          # Display info of the one specific book and allow them to add it to the cart
          display_book(books[book_num-1])
          add_to_cart(books[book_num-1])
        end
      end


    # Checkout the current cart
    when 3
      # Display the cart
      puts "\nYour cart:\n----------"
      @cart.map do |book|
        puts "#{book[3]}, $#{book[6]}"
      end
      
      # Make the customer login or register
      puts "\n(1) Login\n(2) Register"
      print "\nEnter number: "
      login_type = gets.chomp.to_i
      
      # Login as existing customer
      if login_type == 1
        print "\nEmail: "
        email = gets.chomp
        print "Password: "
        password = gets.chomp
        if @db.customer_login(email, password)
          puts "\nLogged in! ✅"
          process_checkout(email)

        else
          puts "--> Email or password not correct"
        end

      # Create customer in database
      elsif login_type == 2
        print "\nFull Name: "
        name = gets.chomp
        print "Email Address: "
        email = gets.chomp
        print "Home Address: "
        address = gets.chomp
        print "Account Password: "
        password = gets.chomp

        if @db.create_customer(name, email, address, password)
          puts "\nRegistered and logged in! ✅"
          process_checkout(email)

        else
          put "--> Error: Unable to register"
        end
        
      else
        puts "--> Invalid selection"
      end

    # Track order using order number
    when 4
      print "\nEnter your order number: "
      order_num = gets.chomp.to_i
      @db.get_order_status(order_num)

    when 5
      puts "\nReturning to homepage"

    else
      puts "\nInvalid entry"
    end

    # Bring the customer back to the customer menu unless they specifically asked to go back to the homepage
    choice = 0 unless choice == 5 
  end
end

# ------------------------------------------
# Interface 2: For owners/admin of the store
def owner_interface
  # First need to check their credentials
  print "\nEnter username: "
  username = gets.chomp
  print "Enter password: "
  password = gets.chomp

  # Use database to see if the username/password are valid
  if @db.owner_login(username, password)
    puts "\n--> Logged in as #{username}"
    choice = 0
    while choice < 1 || choice > 5
      puts "\n(1) Add book to store\n(2) Remove book from store\n(3) View reports\n(4) Create new storeowner account\n(5) Return to homepage"
      print "\nEnter a number: "
      choice = gets.chomp.to_i

      case choice
      # Add new book to the database
      when 1
        print "\nISBN: "
        isbn = gets.chomp
        print "Publisher ID: "
        pub_id = gets.chomp.to_i
        print "Owner ID: "
        own_id = gets.chomp.to_i
        print "Title: "
        title = gets.chomp
        print "Author: "
        author = gets.chomp
        print "Genre: "
        genre = gets.chomp
        print "Price: "
        price = gets.chomp.to_f
        print "Royalty % to Publisher: "
        royalty = gets.chomp.to_f
        print "Initial Stock: "
        stock = gets.chomp.to_i

        if @db.add_book(isbn, pub_id, own_id, title, author, genre, price, royalty, stock)
          puts "\nBook added to store! ✅"
        else
          puts "\n--> Error: Unable to add book to store"
        end

      # Remove existing book from the database
      when 2
        print "Enter ISBN of book to remove: "
        isbn = gets.chomp

        if @db.remove_book(isbn)
          puts "\nBook removed from store! ✅"
        else
          puts "\n--> Error: Unable to add book to store"
        end

      # View sales reports
      when 3
        puts "(1) Sales per genre\n(2) Sales per author\n(3) Sales vs expenditures"
        print "\nEnter number for report to view: "
        report_num = gets.chomp.to_i
        puts "(1) Last month\n(2) Last year"
        print "\nEnter number for time period to view: "
        period = gets.chomp.to_i

        if (report_num > 0 && report_num < 4 && period > 0 && period < 3)
          case report_num
          when 1
            @db.sales_per_genre_report(period)
          when 2
            @db.sales_per_author_report(period)
          else
            @db.sales_vs_exp_report(period)
          end
        else
          puts "\n--> Error: Invalid input"
        end

      # Create new store owner account
      when 4
        print "Enter username for new account: "
        new_username = gets.chomp
        print "Enter password for new account: "
        new_password = gets.chomp

        if @db.create_owner(new_username, new_password)
          puts "\nNew owner account created! ✅"
        else
          puts "\n--> Error: Unable to create account"
        end

      when 5
        puts "\nReturning to homepage"
        
      else
        puts "\nInvalid entry"
      end

      # Bring the owner back to the owner menu unless they specifically asked to go back to the homepage
      choice = 0 unless choice == 5
    end
  
  # Return to homepage if the username/password combo does not exist in the database  
  else
    puts "\n--> Error: Invalid credentials, returning to homepage."
  end
end

# Displays an array of books in a numbered list with their titles
def display_books(books)
  i = 0
  books.map do |book|
    i += 1
    puts "(#{i}) #{book[3]}"
  end

  print "\nEnter book number to view, anything else to exit: "
  book_num = gets.chomp.to_i
  return book_num
end

# Displays all information about a book
def display_book(book)
  puts "Title: #{book[3]}"
  puts "ISBN: #{book[0]}"
  puts "Author: #{book[4]}"
  puts "Genre: #{book[5]}"
  puts "Price: $#{book[6]}"
end

# Pushes the provided book onto our cart array
def add_to_cart(book)
  print "\nEnter 1 to add to cart, anything else to exit: "
  input = gets.chomp.to_i
  
  if input == 1
    @cart << book
    puts "\nAdded to cart 🛒"
  end
end

# Given the customer's email, process a checkout of the shopping cart
def process_checkout(email)
  # Display total
  total = get_cart_total
  puts "\nTotal = $#{total}"

  # Get shipping and billing info specific to their order
  print "\nEnter shipping address: "
  address = gets.chomp

  print "Enter card number for payment: "
  card = gets.chomp

  # Create new order in the database
  order_num = @db.create_order(email, total)
  if order_num
    # Display the order number to the customer
    puts "\nOrder Placed! ✅"
    print "Order # for tracking: "
    puts order_num

    # Decrement the book's stock (this triggers restock if needed) and pay publisher their royalty
    empty_cart

  else
    puts "\n--> Error: Could not place order. Please try again."
  end
end

# Sums and returns the total cost of the shopping cart
def get_cart_total
  total = 0
  @cart.map { |book| total = total + book[6].to_f}
  return total
end

# Calls db to decrease stock of each book sold and empties cart array
# Pay publisher their royalty for each book
def empty_cart
  @cart.map do |book|
    @db.sell_book(book[0])
    pub = @db.get_publisher(book[0])
    amount = book[6].to_f * (book[7].to_f / 100)
    amount = amount.round(2)
    @db.pay_publisher(pub[0], amount)
  end
  @cart = []
end

# Create instance variable of the database which is used to call all query methods
@db = Database.new

# Create cart instance variable to store/persist items in a customer's cart for the whole program run
@cart = []

# Call our main method "bookstore" to start the command-line input flow
enter_bookstore