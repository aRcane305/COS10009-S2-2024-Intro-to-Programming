# frozen_string_literal: true

class MyRecord
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    # fixed typing error
    @age = age
  end
end

# Sort from largest to smallest age depending on direction
def compare(a, b, direction)
  result = a > b

  return result if direction

  !result
end

# sort list according to direction
def sort(arr, direction)
  item_count = arr.length
  # Now let's use bubble sort. Swap pairs iteratively as we loop through the
  # array from the beginning of the array to the second-to-last value
  for i in (0..item_count - 2)
    # From arr[i + 1] to the end of the array
    for j in ((i + 1)..item_count - 1)
      # If the first value is greater than the second value, swap them
      if (compare(arr[i].age, arr[j].age, direction))
        temp = arr[j]
        arr[j] = arr[i]
        arr[i] = temp
      end
    end
  end
  arr
end

# Read the data from the file and print out each line
def read(aFile)
  people = []
  # Defensive programming:
  count = aFile.gets
  puts("first line: #{count}")
  # fixed to call the correct function
  if is_numeric?(count)
    count = count.to_i
  else
    count = 0
    puts 'Error: first line of file is not a number'
  end

  index = 0
  # count should be larger than index
  while count > index
    name = aFile.gets
    age = aFile.gets.to_i
    record = MyRecord.new(name, age)
    people << record
    puts "Line read: #{name}"
    index += 1
  end
  people
end

def print_array(list)
  puts("Printing list: number of elements: #{list.length}")
  i = 0
  while i < list.length
    puts("Name: #{list[i].name} Age: #{list[i].age}")
    i += 1
  end
end

# Write data to a file then read it in and print it out
def main
  file_name = File.join(__dir__, 'data.txt')
  aFile = File.open(file_name, 'r') # open for writing
  people = read(aFile)
  aFile.close

  sorted_people = sort(people, true)

  print_array(sorted_people)
end

# returns true if a string contains only digits
def is_numeric?(obj)
  return false if /[^0-9]/.match(obj).nil?

  true
end

main
