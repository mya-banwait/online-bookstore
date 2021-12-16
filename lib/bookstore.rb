# This is the executable file that gets called from the command line then takes user input and controls flow
#!/usr/bin/ruby

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

        books = @db.search_books(column, search_term)
        puts "\n-- RESULTS --"
        book_num = display_books(books)

        if book_num < 1 || book_num > books.length
          puts "--> Invalid book number"
        else
          display_book(books[book_num-1])
          add_to_cart(books[book_num-1])
        end
      end


    when 3
      puts "checkout cart"
    when 4
      puts "track"
    when 5
      puts "Going home"
    else
      puts "Invalid entry"
    end

    # This brings the customer back to the customer menu unless they specifically asked to go back to the homepage
    choice = 0 unless choice == 5 
  end
end

# Interface 2: For owners/admin of the store
def owner_interface
  # First need to check their credentials
  print "\nEnter username: "
  username = gets.chomp
  print "\nEnter password: "
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
      when 1
        puts "add book"
      when 2
        puts "rm book"
      when 3
        puts "reports"
      when 4
        puts "create acct"
      when 5
        puts "Going home"
      else
        puts "Invalid entry"
      end
    end
  
  # Return to homepage if the username/password combo does not exist in the database  
  else
    puts "\n--> Error: Invalid credentials, returning to homepage."
  end
end

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

def display_book(book)
  puts "Title: #{book[3]}"
  puts "ISBN: #{book[0]}"
  puts "Author: #{book[4]}"
  puts "Genre: #{book[5]}"
  puts "Price: $#{book[6]}"
end

def add_to_cart(book)
  print "\nEnter 1 to add to cart, anything else to exit: "
  input = gets.chomp.to_i
  
  if input == 1
    @cart << book
    puts "\nAdded to cart 🛒"
  end
end

# Create instance variable of the database which is used to call all query methods
@db = Database.new

# Create cart instance variable to store/persist items in a customer's cart for the whole program run
@cart = []

# Call our main method "bookstore" to start the command-line input flow
enter_bookstore