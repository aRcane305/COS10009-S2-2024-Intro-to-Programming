# frozen_string_literal: true

require_relative 'input_functions'
# class and module files
require_relative 'track'
require_relative 'album'
require_relative 'genre'

# points the functions towards the file directory
# opens the file for reading
def read_in_albums
  # read in the album information from chosen file
  file_path = find_album_information
  album_file = File.new(file_path, 'r')
  load_albums(album_file)
end

def find_album_information
  # prompts user for the file name
  album_information = read_string('Please enter the name of the file: ')
  # check if the file exists in directory
  # downcase allows for case insensitivity
  file_path = File.join(__dir__, "#{album_information.downcase}.txt")
  if File.exist?(file_path)
    # debug
    puts 'Success! Reading file...'
    File.read(file_path)
  else
    puts "File not found: #{album_information}.txt , please try again."
  end
  file_path
end

# load a single track from the album file
def load_track(album_file)
  # debug
  puts 'Loading track...'
  track_name = album_file.gets
  track_location = album_file.gets
  track_duration = album_file.gets
  Track.new(track_name, track_location, track_duration)
end

# loads an array of tracks from the album file
def load_tracks(album_file)
  # debug
  puts 'Loading tracks...'
  # using @ makes it an instance variable, so it can be used in other functions
  @tracks = []
  count = album_file.gets.to_i
  # debug
  puts "Debug: count = #{count}"
  index = 0
  while index < count
    track = load_track(album_file)
    @tracks[index] = track
    index += 1
  end
  # debug
  puts "Debug: #{@tracks.inspect}"
  @tracks
end

# load an album from the album file
def load_album(album_file)
  # debug
  puts 'Loading album...'
  album_artist = album_file.gets
  album_name = album_file.gets
  album_duration = album_file.gets
  album_genre = album_file.gets.to_i
  album_tracks = load_tracks(album_file)
  # stores the variables in the class
  Album.new(album_artist, album_name, album_duration, album_genre, album_tracks)
end

# load an array of albums from the album file
def load_albums(album_file)
  # debug
  puts 'loading albums...'
  @albums = []
  count = album_file.gets.to_i
  index = 0
  while index < count
    album = load_album(album_file)
    @albums[index] = album
    index += 1
  end
  puts "\n"
  @albums
end

# display albums menu selector
def display_albums
  # debug to check albums array
  # this will happen if the user forgets to read in files and jumps to option 2
  if @albums.nil? || @albums.empty?
    puts 'No albums loaded. Please load albums and try again.'
    return
  end

  finished = false
  until finished
    puts 'Display albums menu:'
    puts '1. Display all albums.'
    puts '2. Display albums by genre.'
    puts '3. Return to main menu.'
    choice = read_integer_in_range('Please enter your choice:', 1, 3)
    case choice
    when 1
      display_all_albums
    when 2
      display_albums_by_genre
    when 3
      finished = true
    end
  end
end

# display all albums
def display_all_albums
  puts 'All albums:'
  index = 0
  while index < @albums.length
    album = @albums[index]
    # strip is needed, as items in the array are read in using gets,
    # there are \n after each gets and so ,Name would be printed in a new line
    # strip chomps down after the input
    # using gets.chomp in the loading phase is also an option
    puts "Album #{index + 1} - Artist: #{album.album_artist.strip}, Name: #{album.album_title.strip}, Label: #{album.album_label.strip}"
    index += 1
  end
end

# Display only the genres used by the loaded albums
def display_albums_by_genre
  # Extract the genres of the albums that have been loaded
  # map creates an array from an existing array
  # uniq removes duplicate values e.g. some albums have the same genre
  used_genres = @albums.map(&:album_genre).uniq

  puts 'Albums by genre:'
  index = 0
  while index < used_genres.length
    # $genre_names is an array in the module genre.rb
    # basically an array in an array
    puts $genre_names[used_genres[index]]
    index += 1
  end
end

# Display a list of genres
def display_all_genres
  puts 'Albums by genre:'
  index = 1
  while index < $genre_names.length
    puts "#{index}. #{$genre_names[index]}"
    index += 1
  end
end

# initiates play album menu
def play_album
  # takes user input and subtracts 1 to match array indices
  album_index = read_integer('Please enter album number: ') - 1
  # checks if integer is 0 or above
  # checks if its smaller than the length of the album array, in order for loops to work
  return unless album_index >= 0 && album_index < @albums.length

  album = @albums[album_index]
  puts "Showing album: #{album.album_title}"
  puts 'Tracklist:'
  print_tracks(album.album_tracks)
  play_track(album)
end


# play_track function
def play_track(album)
  track_index = read_integer('Please enter track number to play: ') - 1
  return unless album.album_tracks.length.positive?
  return unless track_index >= 0 && track_index < album.album_tracks.length

  track = @tracks[album.album_tracks[track_index]]
  puts "Now playing: #{track.track_name.strip} from #{album.album_title.strip}"
  puts "Duration: #{track.track_duration}"
  sleep 10
end

# print_track function
def print_track(track_index, track_number)
  track = @tracks[track_index]
  return unless track

  puts "Track #{track_number}: #{track.track_name}"
end

# print_tracks function
def print_tracks(track_indices)
  if track_indices
    index = 0
    while index < track_indices.length
      track_index = track_indices[index]
      print_track(track_index, index + 1)
      index += 1
    end
  else
    puts 'No tracks found.'
  end
end

def add_album
  album_artist = read_string('Please enter album artist: ')
  album_title = read_string('Please enter album title: ')
  album_label = read_string('Please enter album label: ')
  display_all_genres
  album_genre = read_integer('Please enter number of genre: ')

  # ensure input is within range of $genre_names array
  while album_genre < 1 || album_genre >= $genre_names.length
    puts "Invalid genre number. Please enter a number between 1 and #{$genre_names.length - 1}."
    album_genre = read_integer('Please enter genre number: ')
  end
  # number_of_tracks is not in the album class, but we need it to create the array inside array
  number_of_tracks = read_integer('Please enter number of tracks: ')

  # create an array to store track indices
  album_tracks = []

  # prompt user for track name and location
  index = 0
  while index < number_of_tracks
    track_name = read_string('Please enter track name: ')
    track_location = read_string('Please enter track location: ')
    track_duration = read_integer('Please enter track duration: ')

    # create a new track instance
    track = Track.new(track_name, track_location, track_duration)
    # feed it at the back of @tracks array
    @tracks << track

    # add index to the @album_tracks array
    album_tracks << (@tracks.length - 1)

    index += 1
  end
  # repeat the above process, create new instance with the album_tracks array
  new_album = Album.new(album_artist, album_title, album_label, album_genre, album_tracks)

  # add this new album into the @albums array
  @albums << new_album

  puts "Album added: #{new_album.album_title.strip}. Press enter to continue."
end

def main_menu
  finished = false
  until finished
    puts 'Main menu:'
    puts '1. Read in albums.'
    puts '2. Display albums.'
    puts '3. Select an album to play.'
    puts '4. Add an album.'
    puts '5. Exit the application.'
    choice = read_integer_in_range('Please enter your choice:', 1, 5)
    case choice
    when 1
      read_in_albums
    when 2
      display_albums
    when 3
      play_album
    when 4
      add_album
    when 5
      finished = true
    else
      puts 'Please select again.'
    end
  end
end

def main
  main_menu
end

main
