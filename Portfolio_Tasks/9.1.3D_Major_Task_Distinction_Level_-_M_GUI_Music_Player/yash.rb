require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Artwork
	attr_accessor :image

	def initialize (file)
		@image = Gosu::Image.new(file)
	end
end

class Album
	attr_accessor :artwork, :artist, :title, :genre, :tracks

	def initialize (artwork, artist, title, genre, tracks)
		@artwork = artwork
        @artist = artist
        @title = title 
		@genre = genre
        @tracks = tracks
	end
end

class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end

class MusicPlayerMain < Gosu::Window

	def initialize
	    super 1200, 800
	    self.caption = "Music Player"
		@albums = load_albums
		print_albums(@albums)
		@track_font = Gosu::Font.new(20)
	end

	# Reads in an array of albums from a file and then prints all the albums in the
	# array to the terminal

	def read_track(music_file)
		track_name = music_file.gets.chomp
		track_location = music_file.gets.chomp
		track = Track.new(track_name, track_location)
	end
	  
	# Returns an array of tracks read from the given file
	  
	def read_tracks(music_file)
		  
		count = music_file.gets.to_i()
		tracks = Array.new()
	  
		# Put a while loop here which increments an index to read the tracks
		index = 0
		while (index < count)
	    	track = read_track(music_file)
	    	tracks << track
	    	index += 1 # Increment index by one
		end
		
		return tracks
  	end
	  
	# Takes an array of tracks and prints them to the terminal
	def print_track(track)
		puts track.name
		puts track.location
	end
	  
	def print_tracks(tracks)
		# print all the tracks use: tracks[x] to access each track.
		index = 0
		times = tracks.length
		puts "Number of Tracks: " + tracks.length.to_s
		while (index < times)
	  		puts "Track " + (index + 1).to_s + ":"
	  		track = tracks[index]
	  		print_track(track)
	  		index += 1
		end
	end
	  
	# Reads in and returns a single album from the given file, with all its tracks
	def read_album(music_file)
		album_artwork_file = music_file.gets().chomp
		album_artist = music_file.gets().chomp
		album_title = music_file.gets().chomp
		album_genre = music_file.gets().to_i
		tracks = read_tracks(music_file)
		artwork = Artwork.new(album_artwork_file)
	  	album = Album.new(artwork, album_artist, album_title, album_genre, tracks)
	  	return album
 	end
	  
	def read_albums(music_file)
		times = music_file.gets().to_i()
		albums = Array.new()
	  
		# Put a while loop here which increments an index to read the tracks
		index = 0
		while (index < times)
	  		album = read_album(music_file)
	  		albums << album
		  	index += 1 # Increment index by one
		end
		
		return albums
	end
	  
	# Takes a single album and prints it to the terminal along with all its tracks
	def print_album(album)
		puts album.artwork.to_s
		puts album.artist 
		puts album.title
		puts($genre_names[album.genre.to_i])
		print_tracks(album.tracks)
	end
	  
	def print_albums(albums)
		# print all the albums use: albums[x] to access each track.
		index = 0
		number = albums.length
		puts "Number of Albums: " + albums.length.to_s
		while (index < number)
			puts "Album " + (index + 1).to_s + ":"
			album = albums[index]
			print_album(album)
			index += 1
		end
	end

  	def load_albums()
		music_file = File.new("gui_albums.txt", "r")
		albums = read_albums(music_file)
		music_file.close
		return albums
  	end

  	# Draws the artwork on the screen for all the albums
  	def draw_albums (albums)
		spacing = 15
		fixed_width = 375
		fixed_height = 375

		index = 0 
		while index < albums.length 
			album = albums[index]
			x = 15 + (index % 2) * (fixed_width + spacing)
			y = 15 + (index / 2) * (fixed_height + spacing)
			album.artwork.image.draw(x, y, ZOrder::PLAYER, fixed_width.to_f / album.artwork.image.width, fixed_height.to_f / album.artwork.image.height)
			index += 1
		end
  	end


  	def area_clicked(leftX, topY, rightX, bottomY)
		in_x_range = (mouse_x >= leftX) && (mouse_x <= rightX)
		in_y_range = (mouse_y >= topY) && (mouse_y <= bottomY)
		return in_x_range && in_y_range
  	end


  	# Takes a String title and an Integer ypos
  	# You may want to use the following:
  	def display_tracks(tracks)
		@selected_tracks = tracks
		index = 0 
		while index < @selected_tracks.length
			track_name = @selected_tracks[index].name
			ypos = 25 + index * 40
			@track_font.draw_text(track_name, 800, ypos, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
			index += 1
		end
  	end


  	# Takes a track index and an Album and plays the Track from the Album

  	def playTrack(track_index)
		if @selected_tracks && @selected_tracks[track_index]
  			track = @selected_tracks[track_index]
			@song = Gosu::Song.new(track.location)
  			@song.play(false)
			@now_playing_message = track.name + " is now playing"
		end
		return ""
  	end

	# Draw a coloured background using TOP_COLOR and BOTTOM_COLOR
	def draw_background
		draw_quad(0, 0, TOP_COLOR, 1200, 0, TOP_COLOR, 0, 800, BOTTOM_COLOR, 1200, 800, BOTTOM_COLOR, ZOrder::BACKGROUND)
	end

 	# Draws the album images and the track list for the selected album
	def draw
		draw_background
		draw_albums(@albums)
		if @selected_tracks
			display_tracks(@selected_tracks)
		end
		if @now_playing_message 
			@track_font.draw_text(@now_playing_message, 800, 700, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
		end
	end

 	def needs_cursor?; true; end

	# If the button area (rectangle) has been clicked on change the background color
	# also store the mouse_x and mouse_y attributes that we 'inherit' from Gosu
	# you will learn about inheritance in the OOP unit - for now just accept that
	# these are available and filled with the latest x and y locations of the mouse click.

	def button_down(id)
		case id
	    when Gosu::MsLeft
			index = 0
			while index < @albums.length
				album = @albums[index]
				spacing = 15
				fixed_width = 375
				fixed_height = 375
				x = 15 + (index % 2) * (fixed_width+ spacing)
				y = 15 + (index / 2) * (fixed_height + spacing)
				
				if area_clicked(x, y, x + fixed_width, y + fixed_height)
					@selected_tracks = album.tracks
					break
				end
				index += 1
			end
			if @selected_tracks
				track_index = 0
				now_playing_message = ""
				while track_index < @selected_tracks.length 
					track = @selected_tracks[track_index]
					track_x = 800
					track_y = 25 + track_index * 40
					track_height = 30 
					if (mouse_x >= track_x) && (mouse_x <= track_x + @track_font.text_width(track.name)) && mouse_y >= track_y && mouse_y <= track_y + track_height
						playTrack(track_index) 
					   	break
					end
					track_index += 1
				end
			else 
				draw("")
			end
	    end
	end

end

# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0