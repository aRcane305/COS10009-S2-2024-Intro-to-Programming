# frozen_string_literal: true

# points the functions towards the file directory
# opens the file for reading
def read_in_albums
  # read in the album information from chosen file
  file_path = File.join(__dir__, 'albums.txt')
  album_file = File.new(file_path, 'r')
  load_albums(album_file)
end

# load a single track from the album file
def load_track(album_file)
  # debug
  # puts 'Debug: loading track'
  track_name = album_file.gets.chomp
  # debug
  # puts "Debug: found track name: #{track_name}"
  track_location = album_file.gets.chomp
  # debug
  # puts "Debug: found track location: #{track_location}"
  track_duration = album_file.gets.chomp
  # debug
  # puts "Debug: found track duration: #{track_duration}"
  Track.new(track_name, track_location, track_duration)
end

# loads an array of tracks from the album file
def load_tracks(album_file)
  # debug
  # puts 'Debug: loading tracks'
  # using @ makes it an instance variable, so it can be used in other functions
  @tracks = []
  count = album_file.gets.to_i
  # debug
  # puts "Debug: #{count} tracks found"
  index = 0
  while index < count
    track = load_track(album_file)
    @tracks[index] = track
    index += 1
  end
  # debug
  # puts "Debug: #{@tracks.inspect}"
  @tracks
end

# load an album from the album file
def load_album(album_file)
  # debug
  # puts 'Debug: loading album'
  album_title = album_file.gets.chomp
  # debug
  # puts "Debug: found album title: #{album_title}"
  album_artist = album_file.gets.chomp
  # debug
  # puts "Debug: found artist: #{album_artist}"
  album_record_label = album_file.gets.chomp
  # debug
  # puts "Debug: found album record label: #{album_record_label}"
  album_cover_path = album_file.gets.chomp
  album_cover = ArtWork.new(File.join(__dir__, album_cover_path))
  # debug
  # puts "Debug: found album cover: #{album_cover}"
  album_year = album_file.gets.chomp.to_i
  # debug
  # puts "Debug: found album year: #{album_year}"
  genre = album_file.gets.chomp.to_i
  # || basically evaluates the right side if the left side returns nil
  # because the array is empty,
  # raise literally raises an exception
  # means the album.txt file has wrong strings
  album_genre = Genre::GENRES[genre] || raise("Invalid genre number: #{genre}")
  # debug
  # puts "Debug: found album genre: #{album_genre}"
  album_tracks = load_tracks(album_file)
  # stores the variables in the class
  Album.new(album_title, album_artist, album_record_label, album_cover, album_year, album_genre, album_tracks)
end

# load an array of albums from the album file
def load_albums(album_file)
  # debug
  # puts 'Debug: loading albums'
  @albums = []
  count = album_file.gets.to_i
  index = 0
  while index < count
    album = load_album(album_file)
    @albums[index] = album
    index += 1
  end
  # debug
  # puts "Debug: #{@albums.inspect}"
end