
def write_data_to_file(file_name)
  data = ["5", "Fred", "Sam", "Jill", "Jenny", "Zorro"]
  a_file = File.new(file_name, "w")
  index = 0
  while index < data.length
    a_file.puts(data[index])
    index += 1
  end
  a_file.close()
end

def read_data_from_file(file_name)
  a_file = File.new(file_name, "r")
  count = a_file.gets.to_i()
  index = 0
  while index < count
    puts a_file.gets
    index += 1
  end
  a_file.close()
end

def main
  write_data_to_file("mydata.txt")
  read_data_from_file("mydata.txt")
end

main if __FILE__ == $0