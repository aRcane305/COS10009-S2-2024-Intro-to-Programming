# frozen_string_literal: true

require_relative 'input_functions'

class Album
  attr_accessor :album_artist, :album_title, :album_record_label, :album_genre, :album_tracks

  def initialize(album_artist, album_title, album_record_label, album_genre, album_tracks)
    @album_artist = album_artist
    @album_title = album_title
    @album_record_label = album_record_label
    @album_genre = album_genre
    @album_tracks = album_tracks
  end
end

class Track
  attr_accessor :track_name, :track_location, :track_duration

  def initialize(track_name, track_location, track_duration)
    @track_name = track_name
    @track_location = track_location
    @track_duration = track_duration
  end
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = %w[Null Pop Classic Jazz Rock]

# points the functions towards the file directory
# opens the file for reading
def read_in_albums
  # read in the album information from chosen file
  file_path = find_album_information
  album_file = File.new(file_path, 'r')
  total_albums = album_count(album_file)
  load_albums(album_file, total_albums)
end

def find_album_information
  finished = false
  until finished
    # prompts user for the file name
    album_information = read_string('Please enter the name of the file: ')
    # check if the file exists in directory
    # downcase allows for case insensitivity
    file_path = File.join(__dir__, "#{album_information.downcase}.txt")
    if File.exist?(file_path)
      # debug
      puts 'Debug: reading file'
      File.read(file_path)
      finished = true
    else
      puts "File not found: #{album_information}.txt , please try again."
    end
  end
  file_path
end

def album_count(album_file)
  album_file.gets.to_i
end

# load a single track from the album file
def load_track(album_file)
  # debug
  puts 'loading track'
  track_name = album_file.gets.chomp
  track_location = album_file.gets.chomp
  track_duration = album_file.gets.chomp
  Track.new(track_name, track_location, track_duration)
end

# loads an array of tracks from the album file
def load_tracks(album_file)
  # debug
  puts 'Debug: loading tracks'
  # using @ makes it an instance variable, so it can be used in other functions
  tracks = []
  count = album_file.gets.to_i
  # debug
  puts "Debug: count = #{count}"
  index = 0
  while index < count
    track = load_track(album_file)
    tracks[index] = track
    index += 1
  end
  # debug
  puts "Debug: #{tracks.inspect}"
  tracks
end

# load an album from the album file
def load_album(album_file)
  # debug
  puts 'Debug: loading album'
  album_artist = album_file.gets.chomp
  album_name = album_file.gets.chomp
  album_duration = album_file.gets.chomp
  album_genre = album_file.gets.chomp.to_i
  album_tracks = load_tracks(album_file)
  # stores the variables in the class
  Album.new(album_artist, album_name, album_duration, album_genre, album_tracks)
end

# load an array of albums from the album file
def load_albums(album_file, total_albums)
  # debug
  puts 'Debug: loading albums'
  albums = []
  # count = album_file.gets.to_i
  index = 0
  while index < total_albums
    album = load_album(album_file)
    albums[index] = album
    index += 1
  end
  albums
end

# display albums menu selector
def display_albums(albums)
  # debug to check albums array
  # this will happen if the user forgets to read in files and jumps to option 2
  if albums.length == 0
    puts 'No albums loaded. Please read in albums and try again.'
    return
  end

  finished = false
  until finished
    puts 'Display Albums Menu:'
    puts '1. Display All Albums'
    puts '2. Display Albums by Genre'
    puts '3. Return to Main Menu'
    choice = read_integer_in_range('Please enter your choice:', 1, 3)
    case choice
    when 1
      display_all_albums(albums)
    when 2
      display_albums_by_genre(albums)
    when 3
      finished = true
    end
  end
end

# display all albums
def display_all_albums(albums)
  puts 'All Albums:'
  index = 0
  while index < albums.length
    album = albums[index]
    # strip is needed, as items in the array are read in using gets,
    # there are \n after each gets and so ,Name would be printed in a new line
    # strip chomps down after the input
    # using gets.chomp in the loading phase is also an option
    puts "Album #{index + 1} - Artist: #{album.album_artist}, Name: #{album.album_title}, Label: #{album.album_record_label}"
    index += 1
  end
end

# Display only the genres used by the loaded albums
def display_albums_by_genre(albums)
  display_all_genres
  genre = read_integer_in_range('Please enter your choice:', 1, 4)
  index = 0
  count = 0
  album_count = albums.length
  while index < album_count
    album = albums[index]
    # Check the genre of each album, using == for comparison
    if album.album_genre == genre
      puts "Album #{index + 1} - Artist: #{album.album_artist}, Name: #{album.album_title}, Label: #{album.album_record_label}"
      count += 1
    end
    index += 1
  end
  if count > 0
    puts "#{count} Album(s) found."
  else
    puts 'No albums found.'
  end
end

def display_all_genres
  puts 'All Genres:'
  index = 1
  count = 4
  while index <= count
    puts "#{index}. #{$genre_names[index]}"
    index += 1
  end
end

# initiates play album menu
def play_album(albums)
  # takes user input and subtracts 1 to match array indices
  album_index = read_integer('Please enter album number: ') - 1
  # checks if integer is 0 or above
  # checks if its smaller than the length of the album array, in order for loops to work
  return unless album_index >= 0 && album_index < albums.length

  album = albums[album_index]
  puts "Showing album: #{album.album_title}"
  puts 'Tracklist:'
  print_tracks(album.album_tracks)
  play_track(album)
end

# print the tracks by accessing the track index
def print_tracks(tracks)
  if tracks
    index = 0
    while index < tracks.length
      print_track(tracks[index], index + 1)
      index += 1
    end
  else
    puts 'No tracks found.'
  end
end

def print_track(track, track_number)
  # returns the function (does nothing) if it's not track
  return unless track

  puts "Track #{track_number}: #{track.track_name}"
end

def play_track(album)
  track_number = read_integer('Please enter track number to play: ') - 1
  return unless album.album_tracks.length.positive?
  return unless track_number >= 1 && track_number <= album.album_tracks.length

  track = album.album_tracks[track_number]
  puts "Now playing: #{track.track_name} from #{album.album_title}"
  puts "Duration: #{track.track_duration}"
  sleep 10
end

def main_menu
  albums = []
  finished = false
  until finished
    puts 'Main Menu:'
    puts '1. Read in Albums'
    puts '2. Display Albums'
    puts '3. Select an Album to Play'
    puts '4. Add an Album'
    puts '5. Exit the Application'
    choice = read_integer_in_range('Please enter your choice:', 1, 5)
    case choice
    when 1
      albums = read_in_albums
    when 2
      display_albums(albums)
    when 3
      play_album(albums)
    when 4
      add_album
    when 5
      finished = true
    else
      puts 'Please select again'
    end
  end
end

def main
  main_menu
end

main
