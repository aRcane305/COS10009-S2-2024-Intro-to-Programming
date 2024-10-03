require_relative './input_functions'

# It is suggested that you put together code from your 
# previous tasks to start this. eg:
# 8.1T Read Album with Tracks

# frozen_string_literal: true

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

# shortcut to create array from a list of words seperated by spaces
# %i[] for integers
# %w[] for mixed data
$genre_names = %w[Null Pop Classic Jazz Rock]

class Album
  # NB: you will need to add tracks to the following and the initialize()
  attr_accessor :artist, :title, :genre, :tracks

  def initialize(artist, title, genre, tracks)
    @artist = artist
    @title = title
    @genre = genre
    @tracks = tracks
  end
end

class Track
  attr_accessor :name, :location

  def initialize(name, location)
    @name = name
    @location = location
  end
end

# Reads in and returns a single track from the given file

def read_track(music_file)
  track_name = music_file.gets
  track_location = music_file.gets
  Track.new(track_name, track_location)
end

# Returns an array of tracks read from the given file

def read_tracks(music_file)
  tracks = []
  count = music_file.gets.to_i
  index = 0
  while index < count
    track = read_track(music_file)
    tracks[index] = track
    index += 1
  end
  tracks
end

# Reads in and returns a single album from the given file, with all its tracks

def read_album
  file_name = File.join(__dir__, 'albums.txt')
  music_file = File.open(file_name, 'r')
  album_artist = music_file.gets
  album_title = music_file.gets
  album_genre = music_file.gets.to_i
  tracks = read_tracks(music_file)
  album = Album.new(album_artist, album_title, album_genre, tracks)
  return album
end

# Takes an array of tracks and prints them to the terminal

def print_tracks(tracks)
  index = 0
  times = tracks.length
  while index < times
    puts tracks[index].name
    puts tracks[index].location
    index += 1
  end
end

# Takes a single album and prints it to the terminal along with all its tracks
def print_album(album)
  puts album.artist
  puts album.title
  puts("Genre is #{album.genre}")
  puts($genre_names[album.genre])
  print_tracks(album.tracks) # print out the tracks
end

# Reads in an album from a file and then print the album to the terminal

def main
  album = read_album
  print_album(album)
end

main

