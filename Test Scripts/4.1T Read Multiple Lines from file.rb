def open_file_for_writing(file_name)
  File.open(file_name, "w")
end

def open_file_for_reading(file_name)
  File.open(file_name, "r")
end

def write_data_to_file(file_name)
  data = ['5', 'Fred', 'Sam', 'Jill', 'Jenny', 'Zorro']
  File.open(file_name, "w") do |file|
    data.each { |line| file.puts(line) }
  end
end

def read_data_from_file(file_name)
  File.open(file_name, "r") do |file|
    count = file.gets.to_i
    i = 0
    while i < count
      puts file.gets
      i += 1
    end
  end
end

def main
  write_data_to_file("mydata.txt")
  read_data_from_file("mydata.txt")
end

main if __FILE__ == $0