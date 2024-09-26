def factorial(n)
  # anything to the power of 0 is 1
  if n == 0
    return 1
  else
    return n * factorial(n - 1)
  end
end

def main
  # if the argument is above/below one, prints this error message
  if ARGV.length != 1
    puts "Incorrect argument - need a single argument with a value of 0 or more."
    return
  end

  n = ARGV[0].to_i
  # prints if the output is less than one
  if n < 0
    puts "Incorrect argument - need a single argument with a value of 0 or more."
    return
  end
  puts factorial(n)
end

main