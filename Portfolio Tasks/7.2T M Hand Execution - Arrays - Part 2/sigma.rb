# Define the function
def contains_value?(data, target_value)
  index = 0
  while index < data.length
    return true if data[index] == target_value
    index += 1
  end
  false
end

# Define an array
data = ["2", "3", "-4", "6", "7"]

# Define a target value
target_value = "3"

# Call the function and print the result
puts contains_value?(data, target_value)