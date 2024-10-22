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

# load a single track from the album file
def load_track(album_file)
  # debug
  puts 'Debug: loading track'
  track_name = album_file.gets
  track_location = album_file.gets
  track_duration = album_file.gets
  Track.new(track_name, track_location, track_duration)
end

# loads an array of tracks from the album file
def load_tracks(album_file)
  # debug
  puts 'Debug: loading tracks'
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
  puts 'Debug: loading album'
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
  puts 'Debug: loading albums'
  @albums = []
  count = album_file.gets.to_i
  index = 0
  while index < count
    album = load_album(album_file)
    @albums[index] = album
    index += 1
  end
  @albums
end

# display albums menu selector
def display_albums
  # debug to check albums array
  # this will happen if the user forgets to read in files and jumps to option 2
  if @albums.nil? || @albums.empty?
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
  puts 'All Albums:'
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

  puts 'Albums by Genre:'
  index = 0
  while index < used_genres.length
    # $genre_names is an array in the module genre.rb
    # basically an array in an array
    puts $genre_names[used_genres[index]]
    index += 1
  end
end

def display_all_genres
  puts 'Display All Genres:'
  index = 1
  while index < $genre_names.length
    puts $genre_names[index]
    index += 1
  end
end

# initiates play album menu
def play_album
  # takes user input and subtracts 1 to match array indices
  display_all_albums
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
  track_number = read_integer('Please enter track number to play: ')
  return unless album.album_tracks.length.positive?
  return unless track_number >= 1 && track_number <= album.album_tracks.length

  track = album.album_tracks[track_number - 1]
  puts "Now playing: #{track.track_name.strip} from #{album.album_title.strip}"
  puts "Duration: #{track.track_duration}"
  sleep 10
end

def add_album
  # debug
  puts 'adding album'
  album_artist = read_string('Please enter your album artist: ')
  album_title = read_string('Please enter your album title: ')
  album_label = read_string('Please enter your album label: ')
  display_all_genres
  album_genre = read_integer('Please enter the number of your album genre: ')

  album_track_count = read_integer('Please enter the number of tracks: ')

  @tracks = []
  index = 0
  while index < album_track_count
    track_name = read_string('Please enter your track name: ')
    track_location = read_string('Please enter your track location: ')
    track_duration = read_string('Please enter your track duration: ')

    @tracks[index] = Track.new(track_name, track_location, track_duration)
    index += 1
  end

  @albums << Album.new(album_artist, album_title, album_label, album_genre, @tracks)

  # usually an array will output the last stored variable, however with the arg album_title, we need to use last or it will output errors
  puts "Album added, '#{@albums.last.album_title}'. Press enter to continue."
  gets
end

def main_menu
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
      puts 'Please select again'
    end
  end
end

def main
  main_menu
end

main
