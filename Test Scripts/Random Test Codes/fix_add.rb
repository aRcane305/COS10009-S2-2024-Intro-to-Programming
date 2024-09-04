def main()
  # Fix the code below to get rid of the error message:
  c = "This is a string"
  print("Enter first number to add: ")
  # convert the text to an integer - more on this in the next slide
  a = gets().to_i() 
  print("Enter second number to add: ")
  b = gets().to_i()
  print("The sum of the numbers is: ")
  sum = a + b
  print(sum,"\n")

end

main()