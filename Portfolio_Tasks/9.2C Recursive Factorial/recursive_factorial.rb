# frozen_string_literal: true

def factorial(num)
  # anything to the power of 0 is 1
  # cleans up the if else loop
  return 1 if num.zero?

  num * factorial(num - 1)
end

def main
  # if the argument is above/below one, prints this error message
  if ARGV.length != 1
    puts 'Incorrect argument - need a single argument with a value of 0 or more.'
    return
  end

  # converts the argument from ARGV and converts to integer for factorial(n) function
  num = ARGV[0].to_i
  # prints if the output is less than one
  # same as if n<0
  if num.negative?
    puts 'Incorrect argument - need a single argument with a value of 0 or more.'
    return
  end
  puts factorial(num)
end

main
