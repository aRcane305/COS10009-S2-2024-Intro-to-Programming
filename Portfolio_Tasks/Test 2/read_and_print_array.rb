
def read_array()
  lines = []
  print "How many lines are you entering? "
  count = gets.chomp.to_i
  index = 0
  while index < count
    print "Enter text: "
    line = gets.chomp
    lines[index] = line
    index += 1
  end
  lines
end

def print_array(lines)
  puts "Printing lines:"
  index = 0
  times = lines.length
  while index < times
    puts(index.to_s + " "+ lines[index])
    index += 1
    end
end

def main()
   lines = read_array
   print_array(lines)
end

main()
