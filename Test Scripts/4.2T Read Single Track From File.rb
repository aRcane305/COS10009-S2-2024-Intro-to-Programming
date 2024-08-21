class Track
  attr_accessor :name, :location
  def initialize(n, l)
    # puts "hello"
    @name = n
    @location = l
  end
end

def read_track(file_name)
  File.open(file_name, "r") do |file|
    name = file.gets.chomp
    location = file.gets.chomp
    Track.new(name, location)
  end
end

def print_track(track)
  puts "Track name: #{track.name}"
  puts "Track location: #{track.location}"
end

def main()
  file_name = "track.txt"
  File.open(file_name, "r") do |file|
    track = read_track(file_name)
    print_track(track)
  end
end

# leave this line
main() if __FILE__ == $0