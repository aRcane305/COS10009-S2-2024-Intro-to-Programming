# frozen_string_literal: true

require_relative 'input_functions'

class Track
  attr_accessor :name, :location

  def initialize(n, l)
    @name = n
    @location = l
  end
end

# Reads in and returns a single track from the given file
def read_track(music_file)
  track_name = music_file.gets.chomp # chomp ensures only one line is returned
  track_location = music_file.gets.chomp
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

# Takes an array of tracks and prints them to the terminal
def print_tracks(track)
  index = 0
  times = track.length
  while index < times
    puts track[index].name
    puts track[index].location
    index += 1
  end
end

# Takes a single track and prints it to the terminal
def print_track(track)
  puts("Track title is: #{track.name}")
  puts("Track file location is: #{track.location}")
end

# search for track by name.
# Returns the index of the track or -1 if not found
def search_for_track_name(tracks, search_name)
  index = 0
  while index < tracks.length
    return index if tracks[index].name == search_name

    index += 1
  end
  -1
end

# Reads in an Album from a file and then prints all the album
# to the terminal

def main
  file_name = File.join(__dir__, 'album.txt')
  music_file = File.new(file_name, 'r')
  tracks = read_tracks(music_file)
  print_tracks(tracks)
  music_file.close

  search_name = read_string('Enter the track name you wish to find: ')
  index = search_for_track_name(tracks, search_name)
  if index > -1
    puts "Found #{tracks[index].name} at #{index}"
  else
    puts 'Entry not Found'
  end
end

main
