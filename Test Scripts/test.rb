# Given the seat number for the customer returns the price for that customer's meal
def get_total_for_customer(x)
  puts("Enter price of entre for customer #{x}: ")
  entre_price = gets.to_i
  puts("Enter price of main for customer #{x}: ")
  main_price = gets.to_i
  puts("Enter price of dessert for customer #{x}: ")
  dessert_price = gets.to_i

  main_price + entre_price + dessert_price
end

# calculates the total price for the meals at a table:
def calculate_total_for_table_of_four
  first_customer_price = get_total_for_customer(1)
  second_customer_price = get_total_for_customer(2)
  third_customer_price = get_total_for_customer(3)
  fourth_customer_price = get_total_for_customer(4)

  first_customer_price + second_customer_price + third_customer_price + fourth_customer_price
end

def main
  # calculate and print the total for a table of four
  puts 'Calculating the total for the table of 4: '
  puts 'The total for the table is: ' + calculate_total_for_table_of_four.to_s
end

main
