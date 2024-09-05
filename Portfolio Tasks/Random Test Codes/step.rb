# frozen_string_literal: true

# Use byebug to move through this program to see what happens step-by-step

# This will print a message based on the name the user entered
def print_name(name)
  if (name == "Blinky")
    puts("You entered Blinky - surely that is not your name?")
  else
    puts("Your name is " + name)
  end
end

# This will ask the user to enter a name and then call the print_name() procedure
def main()
  print("Enter your name: ")
  name = gets().chomp()
  print_name(name)
end

main()