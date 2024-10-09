# frozen_string_literal: true

def display_loaded_albums
  puts 'Loaded Albums:'
  index = 0
  while index < @albums.length
    album = @albums[index]
    # strip is needed, as items in the array are read in using gets,
    # there are \n after each gets and so ,Name would be printed in a new line
    # strip chomps down after the input
    # using gets.chomp in the loading phase is also an option
    puts "Album #{index + 1} - Artist: #{album.album_artist}, Name: #{album.album_title}, Label: #{album.album_record_label}, Year: #{album.album_year}, Genre: #{album.album_genre}, Tracks: #{album.album_tracks.length}"
    index += 1
  end
end