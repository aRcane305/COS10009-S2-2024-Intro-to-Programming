require_relative ".//input_functions"
# put your code below
class Track
  attr_accessor :name, :location
  def initialize(n, l)
  # puts "hello"
  @name = n
  @location = l
  end
end

def read_track()
  track_name = read_string("Enter track name: ")
  track_location = read_string("Enter track location: ")
  track = Track.new(track_name, track_location)
  return track
end

def print_track(track)
  print("Track name: ")
  puts(track.name)
  print("Track location: ")
  puts(track.location)
end

def main()
  track = read_track()
  print_track(track)
end

# leave this line
main() if __FILE__ == $0