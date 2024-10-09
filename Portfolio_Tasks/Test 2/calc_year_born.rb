require 'date'
YEAR = Date.today.year

def main()
  print "Enter your age: "
  user_age = gets.chomp.to_i

  user_birth_year = YEAR - user_age

  puts ("You were born in " + user_birth_year.to_s)
end

main