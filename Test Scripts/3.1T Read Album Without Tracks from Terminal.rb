require './input_functions'

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

Genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
  attr_accessor :title, :artist, :genre
end

# This function Reads in and returns a single album from the given file, with all its tracks.
# ...for now however, take input from the terminal to enter just the album information.
# Complete the missing lines of code and change the functionality so that the hardcoded 
# values are not used.

def read_album()

  # You could use get_integer_range below to get a genre.
  # You only the need validation if reading from the terminal
  # (i.e when using a file later, you can assume the data in
  # the file is correct)

  # insert lines here - use read_integer_in_range to get a genre
  album_title = read_string("Enter title")
  album_artist = "someone"
  album_genre = Genre::POP
  album = Album.new()
  album.title = album_title
  album.artist = album_artist
  album.genre = album_genre
  return album
end

# Takes a single album and prints it to the terminal 
# complete the missing lines:

def print_album(album)
  puts('Album information is: ')
	# insert lines here
	puts('Genre is ' + album.genre.to_s)
  puts Genre_names[album.genre] # we will cover this in Week 6!
end

# Reads in an Album then prints it to the terminal

def main()
	album = read_album()
	print_album(album)
end

main()
