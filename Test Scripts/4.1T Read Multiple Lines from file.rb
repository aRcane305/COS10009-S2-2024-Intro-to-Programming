# writes the number of lines then each line as a string.

def write_data_to_file(a_file)
  data = ['5', 'Fred', 'Sam', 'Jill', 'Jenny', 'Zorro']
  data.each { |line| a_file.puts(line) }
end

# reads in each line.
# Do the following in WEEK 5
# you need to change the following code
# so that it uses a loop which repeats
# acccording to the number of lines in the File
# which is given in the first line of the File
def read_data_from_file(a_file)
  count = a_file.gets.to_i()
  puts count.to_s()
  puts a_file.gets()
  puts a_file.gets()
  puts a_file.gets()
  puts a_file.gets()
  puts a_file.gets()
end

def open_data_for_writing(a_file)
  a_file = File.new("mydata.txt", "w") # open for writing
  write_data_to_file(a_file)
  a_file.close()
end
# Do the following in WEEK 4
# writes data to a file then reads it in and prints
# each line as it reads.
# you should improve the modular decomposition of the
# following by moving as many lines of code
# out of main as possible.
def main
  open_data_for_writing(a_file)

  a_file = File.new("mydata.txt", "r") # open for reading
  read_data_from_file(a_file)
  a_file.close()
end

main