# frozen_string_literal: true

class Track
  attr_accessor :name, :location
  def initialize (n, l)
    @name = n
    @location = l
  end
end

# reads in a single track from the given file.
def read_track(music_file)
  track_name = music_file.gets()
  track_location = music_file.gets()
  Track.new(track_name, track_location)
end

# Returns an array of tracks read from the given file
def read_tracks(music_file)
  tracks = Array.new()
  count = music_file.gets.to_i()
  index = 0
  while index < count
    track = read_track(music_file)
    tracks << track
    index += 1
  end
  return tracks
end

# Takes an array of tracks and prints them to the terminal
def print_tracks(track)
  index = 0
  times = track.length()
  while (index < times)
    puts track[index].name
    puts track[index].location
    index += 1
  end
end

# Takes a single track and prints it to the terminal
def print_track(track)
  puts(track.name)
  puts(track.location)
end

# Open the file and read in the tracks then print them
def main()
  file_name = File.join(__dir__, "input.txt")
  music_file = File.new(file_name, "r")
  tracks = read_tracks(music_file)
  print_tracks(tracks)
  music_file.close()
end

main()

