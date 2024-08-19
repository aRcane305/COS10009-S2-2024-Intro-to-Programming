# writes the number of lines then each line as a string.

def write_data_to_file(file_name)
  file_name.puts('5')
  file_name.puts('Fred')
  file_name.puts('Sam')
  file_name.puts('Jill')
  file_name.puts('Jenny')
  file_name.puts('Zorro')
end

# reads in each line.
# Do the following in WEEK 5
# you need to change the following code
# so that it uses a loop which repeats
# acccording to the number of lines in the File
# which is given in the first line of the File
def read_data_from_file(file_name)
 count = file_name.gets.to_i()
 puts count.to_s()
 puts file_name.gets()
 puts file_name.gets()
 puts file_name.gets()
 puts file_name.gets()
 puts file_name.gets()
end

def open_file_for_writing(file_name)
  file_name = File.new("mydata.txt", "w") # open for writing
  write_data_to_file(file_name)
  file_name.close()
end

def open_file_for_reading(file_name)
  file_name = File.new("mydata.txt", "r") # open for reading
  read_data_from_file(file_name)
  file_name.close()
end
# Do the following in WEEK 4
# writes data to a file then reads it in and prints
# each line as it reads.
# you should improve the modular decomposition of the
# following by moving as many lines of code
# out of main as possible.
def main()
  open_file_for_writing(file_name)
end


main