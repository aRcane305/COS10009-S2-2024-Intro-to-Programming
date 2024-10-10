# frozen_string_literal: true

require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

module ZOrder
  BACKGROUND, PLAYER, UI_BACKGROUND, UI = *0..3
end

module Genre
  POP, DANCE, HIP_HOP_RAP, CLASSIC, JAZZ, SOUL, ROCK, ALTERNATIVE_INDIE = *1..8

  GENRES = {
    1 => POP,
    2 => DANCE,
    3 => HIP_HOP_RAP,
    4 => CLASSIC,
    5 => JAZZ,
    6 => SOUL,
    7 => ROCK,
    8 => ALTERNATIVE_INDIE
  }.freeze
end

# Put your record definitions here
class Album
  attr_accessor :album_title, :album_artist, :album_record_label, :album_cover, :album_year, :album_genre, :album_tracks

  def initialize(album_title, album_artist, album_record_label, album_cover, album_year, album_genre, album_tracks)
    @album_title = album_title
    @album_artist = album_artist
    @album_record_label = album_record_label
    @album_cover = album_cover
    @album_year = album_year
    @album_genre = album_genre
    @album_tracks = album_tracks
  end
end

class Track
  attr_accessor :track_name, :track_location, :track_duration

  def initialize(track_name, track_location, track_duration)
    @track_name = track_name
    @track_location = track_location
    @track_duration = track_duration
  end
end

class ArtWork
  attr_accessor :bmp

  def initialize (file)
    @bmp = Gosu::Image.new(file)
  end
end

class MusicPlayerMain < Gosu::Window
  ALBUM_TEXT_X = 1200
  ALBUM_TEXT_Y = 40
  ALBUM_TEXT_SPACING = 50

  def initialize
    super(1600, 900, false)
    self.caption = 'Music Player'
    @album_font = Gosu::Font.new(24)
    read_in_albums
    display_all_albums

    @album_buttons = []
    setup_album_buttons
  end

  def setup_album_buttons
    index = 0
    while index < @albums.size
      album = @albums[index]
      ypos = ALBUM_TEXT_Y + (ALBUM_TEXT_SPACING * index)
      @album_buttons << { album:, top_y: ypos, bottom_y: ypos + @album_font.height }
      index += 1
    end
  end

  def area_clicked(leftX, topY, rightX, bottomY)
    # complete this code
  end

  # Takes a String title and an Integer ypos
  # You may want to use the following:
  def display_track(title, ypos)
    @track_font.draw(title, TrackLeftX, ypos, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # Takes a track index and an Album and plays the Track from the Album

  def playTrack(track, album)
    # complete the missing code
    @song = Gosu::Song.new(album.tracks[track].location)
    @song.play(false)
    # Uncomment the following and indent correctly:
    #	end
    # end
  end

  # Not used? Everything depends on mouse actions.

  def update; end

  def draw_background
    draw_quad(0, 0, TOP_COLOR, width, 0, TOP_COLOR, 0, height, BOTTOM_COLOR, width, height, BOTTOM_COLOR,
              ZOrder::BACKGROUND)
  end

  def draw_albums
    album_size = 400
    margin = 20
    start_x = margin
    start_y = margin * 2
    items_per_row = 2

    index = 0
    while index < @albums.size
      album = @albums[index]
      album_cover_path = File.join(__dir__, album.album_cover)
      album_cover = ArtWork.new(album_cover_path)

      scale_factor = album_size.to_f / [album_cover.bmp.width, album_cover.bmp.height].max
      x = start_x + ((index % items_per_row) * (album_size + margin))
      y = start_y + ((index / items_per_row) * (album_size + margin))

      album_cover.bmp.draw(x, y, ZOrder::PLAYER, scale_factor, scale_factor)
      index += 1
    end
  end

  def draw_album_text_buttons
    index = 0
    while index < @album_buttons.size
      button = @album_buttons[index]
      ypos = ALBUM_TEXT_Y + (ALBUM_TEXT_SPACING * index)
      @album_font.draw_text(button[:album].album_title, ALBUM_TEXT_X, ypos, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
      index += 1
    end
  end

  # Draws the album images and the track list for the selected album

  def draw
    draw_background
    draw_albums
    draw_album_text_buttons
  end

  def needs_cursor? = true

  # If the button area (rectangle) has been clicked on change the background color
  # also store the mouse_x and mouse_y attributes that we 'inherit' from Gosu
  # you will learn about inheritance in the OOP unit - for now just accept that
  # these are available and filled with the latest x and y locations of the mouse click.

  def button_down(id)
    case id
    when Gosu::MsLeft
      if mouse_over_album_text?(mouse_x, mouse_y)
        clicked_album = album_button_clicked(mouse_x, mouse_y)
        unless clicked_album.nil?
          # Here you would handle the action for when an album is clicked
          puts "Album clicked: #{clicked_album.album_title}"
        end
      end
    end
  end

  def mouse_over_album_text?(x, y)
    index = 0
    while index < @album_buttons.size
      button = @album_buttons[index]
      if x >= ALBUM_TEXT_X &&
         x <= ALBUM_TEXT_X + @album_font.text_width(button[:album].album_title) &&
         y >= button[:top_y] &&
         y <= button[:bottom_y]
        return true
      end

      index += 1
    end
    false
  end

  def album_button_clicked(x, y)
    index = 0
    while index < @album_buttons.size
      button = @album_buttons[index]
      if x >= ALBUM_TEXT_X &&
         x <= ALBUM_TEXT_X + @album_font.text_width(button[:album].album_title) &&
         y >= button[:top_y] &&
         y <= button[:bottom_y]
        return button[:album]
      end

      index += 1
    end
    nil
  end
end
# Show is a method that loops through update and draw

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
  album_cover = album_file.gets.chomp
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

def display_all_albums
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

MusicPlayerMain.new.show if __FILE__ == $PROGRAM_NAME
