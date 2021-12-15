# This is the executable file that gets called from the command line then takes user input and controls flow
#!/usr/bin/ruby

def bookstore
  #  This input determines which of the two user interfaces to enter
  choice = 0
  while choice != 1 && choice != 2
    puts "\nWelcome to Look Inna Book!\n\nEnter your choice:\n(1) Browse Books\n(2) Admin Login"
    choice = gets.chomp.to_i
  end
  
  case choice
  when 1
    browse_books
  else
    owner_admin
  end
end

def browse_books
  puts "browse"
end

def owner_admin
  puts "admin"
end

# Call our main method "bookstore" to start the user experience
bookstore