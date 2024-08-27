require './input_functions.rb'

def main_menu ()
  finished = false
  begin
    puts "Main Menu:"
    puts "1 Read in Albums"
    puts "2 Display Albums"
    puts "3 Selecct an Album to play"
    puts "5 Exit the application"
    choice = read_integer_in_range("Please enter your choice:", 1, 5)
    case choice
    when 1
      read_in_albums()
    when 2
      display_albums()
    when 3
      select_albums()
    when 5
      finished = true
    else
      puts "Please select again"
    end
  end until finished
end

def read_in_albums()
  #stub
  # store it in albums.txt
end
def display_albums()
  finished = false
  begin
    puts "Display Albums Menu:"
    puts "1 Display all Albums"
    puts "2 Display Albums by Genre"
    puts "3 Return to Main Menu"
    choice = read_integer_in_range("Please enter your choice:", 1, 3)
    case choice
    when 1
      display_all_albums()
    when 2
      display_albums_by_genre()
    when 3
      finished = true
    end
  end until finished
end

def display_all_albums()
  read_string("You selected Display All Albums. Press enter to continue")
end

def display_albums_by_genre()
  read_string("You selected Display Albums By Genre. Press enter to continue")
end

def main()
  main_menu()
end

main()