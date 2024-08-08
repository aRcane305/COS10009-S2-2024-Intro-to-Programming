# calling the file input_functions.rb
require './input_functions'

# returns the title, first name and last name of the recipient as one line
def read_name
  title = read_string('Please enter your title: (Mr, Mrs, Ms, Miss, Dr)')
  first_name = read_string('Please enter your first name:')
  last_name = read_string('Please enter your last name:')
  full_name = (title + ' ' + first_name + ' ' + last_name)
	return(full_name)
end

# returns the address of the recipient formatted as a string over multiple lines to include:
# the street number and the street name
# the suburb and postcode
def read_address
  house_number = read_string('Please enter the house or unit number:')
  street_name = read_string('Please enter the street name:')
  suburb = read_string('Please enter the suburb:')
  post_code = read_integer_in_range('Please enter a postcode (0000 - 9999)', 0, 9999)
  full_address = (house_number + ' ' + street_name + "\n" + suburb + ' ' + post_code.to_s)
	return(full_address)
end

# returns a formatted string which includes the title, first name, last name and
# street address (number, street, suburb and postcode) of the recipient
def read_label
  receiver_name = read_name
  receiver_address = read_address
  full_label = (receiver_name + "\n" + receiver_address + "\n")
	return(full_label)
end

# returns a single formatted string with the subject line (preceded by "RE:")
# then a blank line before the message
def read_message
  subject = read_string('Please enter your message subject line:')
  content = read_string('Please enter your message content:')
  full_message = ('RE: ' + subject + "\n\n" + content)
	return(full_message)
end

# takes two parameters of type string  - one with the letter label
#  the other with the subject and message, Prints both to console.
def send_message_to_address(label, message)
  puts(label)
  puts(message)
end

# reads the label and the message from the terminal before printing both formatted
def main
  label = read_label
  message = read_message
  send_message_to_address(label, message)
end

# calls the function main
main
