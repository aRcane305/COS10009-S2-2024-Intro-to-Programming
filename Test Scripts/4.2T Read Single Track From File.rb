class Track
  attr_accessor :name, :location
  def initialize(n, l)
    # puts "hello"
    @name = n
    @location = l
  end
end

def read_track(file_name)
  a_file = File.open(file_name, "r")
  name = a_file.gets.chomp
  location = a_file.gets.chomp
  Track.new(name, location)
end


def print_track(track)
  puts "Track name: #{track.name}"
  puts "Track location: #{track.location}"
end

def main()
  file_name = "track.txt"
  a_file = File.open(file_name, "r")
  track = read_track(file_name)
  print_track(track)
end
# leave this line
main() if __FILE__ == $0