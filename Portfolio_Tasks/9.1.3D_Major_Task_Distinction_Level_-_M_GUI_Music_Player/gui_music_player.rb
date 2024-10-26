# frozen_string_literal: true

# import the necessary  libraries
require 'rubygems'
require 'gosu'

# set global constants for window dimensions and text offset
WINDOW_WIDTH = 1500
WINDOW_HEIGHT = 1050
TRACK_TEXT_X_OFFSET = 950
TRACK_TEXT_Y_OFFSET = 50
ALBUM_SIZE = 350
ALBUM_SPACING = 25
# window background global constants
TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

# class definition for Album and attributes
class Album
  attr_accessor :album_title, :album_artist, :album_record_label, :album_cover, :album_year, :album_genre, :album_tracks

  def initialize(album_title, album_artist, album_record_label, album_cover, album_year, album_genre, album_tracks)
    # instance variables
    @album_title = album_title
    @album_artist = album_artist
    @album_record_label = album_record_label
    @album_cover = album_cover
    @album_year = album_year
    @album_genre = album_genre
    @album_tracks = album_tracks
  end
end

# class for album artwork
class ArtWork
  attr_accessor :bmp

  def initialize(file)
    @bmp = Gosu::Image.new(file)
  end
end

# module with Genre enumerations and corresponding names
module Genre
  # integer assignment for genres
  POP, DANCE, HIP_HOP_RAP, CLASSIC, JAZZ, SOUL, ROCK, ALTERNATIVE_INDIE = *1..8
  # array with the string representations of each genre
  GENRE_NAMES = ['Null', 'Pop', 'Dance', 'Hip-Hop Rap', 'Classic', 'Jazz', 'Soul', 'Rock', 'Alternative Indie'].freeze
end

# class definition for Track and its attributes
class Track
  attr_accessor :track_name, :track_location, :track_duration

  def initialize(track_name, track_location, track_duration)
    # instance variables
    @track_name = track_name
    @track_location = track_location
    @track_duration = track_duration
  end
end

# module for z-order layers for Gosu
module ZOrder
  BACKGROUND, PLAYER, UI_BACKGROUND, UI = *0..3
end

# code for music player window
class MusicPlayerMain < Gosu::Window
  # runs these during the render period
  def initialize
    # window size, window caption and fullscreen arguments
    super(WINDOW_WIDTH, WINDOW_HEIGHT, false)
    self.caption = 'Saadify'
    # font setup
    @primary_font = Gosu::Font.new(23, name: 'Aileron-Bold.ttf')
    @secondary_font = Gosu::Font.new(30, name: 'SF-Pro-Display-Regular.ttf')
    # initialize instance variables
    @current_album = nil
    @albums = read_in_albums
    print_albums_to_console
  end

  # read album count from file
  def album_count(album_file)
    album_file.gets.to_i
  end

  # read in albums information from file
  def read_in_albums
    album_file = File.open('albums.txt', 'r')
    total_albums = album_count(album_file)
    read_albums_from_file(album_file, total_albums)
  end

  # load single track from file
  def load_track(album_file)
    # debug
    # puts 'Debug: loading track'
    track_name = album_file.gets.chomp
    track_location = album_file.gets.chomp
    track_duration = album_file.gets.chomp
    Track.new(track_name, track_location, track_duration)
  end

  # iterate to load multiple tracks from file
  def load_tracks(album_file)
    # debug
    # puts 'Debug: loading tracks'
    tracks = []
    count = album_file.gets.to_i
    # debug
    # puts "Debug: count = #{count}"
    index = 0
    while index < count
      track = load_track(album_file)
      tracks[index] = track
      index += 1
    end
    # debug
    # puts "Debug: #{tracks.inspect}"
    tracks
  end

  # read in album from file
  def load_album(album_file)
    # debug
    # puts 'Debug: loading album'
    album_title = album_file.gets.chomp
    album_artist = album_file.gets.chomp
    album_record_label = album_file.gets.chomp
    album_cover_path = album_file.gets.chomp
    album_cover = ArtWork.new(album_cover_path)
    album_year = album_file.gets.chomp.to_i
    # checks genre
    genre = album_file.gets.chomp.to_i
    is_valid_genre = genre >= 1 && genre < Genre::GENRE_NAMES.length
    if is_valid_genre
      album_genre = Genre::GENRE_NAMES[genre]
    else
      error_message = "Invalid genre number: #{genre}"
      raise(error_message)
    end
    album_tracks = load_tracks(album_file)
    Album.new(album_title, album_artist, album_record_label, album_cover, album_year, album_genre, album_tracks)
  end

  # reads all albums from file
  def read_albums_from_file(album_file, total_albums)
    # debug
    # puts 'Debug: loading albums'
    @albums = []
    index = 0
    while index < total_albums
      album = load_album(album_file)
      @albums[index] = album
      index += 1
    end
    # debug
    # puts "Debug: #{@albums.inspect}"
    @albums
  end

  # print loaded albums to console for debugging
  def print_albums_to_console
    puts "Loaded #{@albums.length} Albums:"
    index = 0
    while index < @albums.length
      album = @albums[index]
      puts "Album #{index + 1} - Artist: #{album.album_artist}, Name: #{album.album_title}, Label: #{album.album_record_label}, Year: #{album.album_year}, Genre: #{album.album_genre}, Tracks: #{album.album_tracks.length}"
      index += 1
    end
  end

  # method to check for clicks within a rectangle
  def area_clicked(leftX, topY, rightX, bottomY)
    horizontal_boundary = (mouse_x >= leftX) && (mouse_x <= rightX)
    vertical_boundary = (mouse_y >= topY) && (mouse_y <= bottomY)

    x_coord = horizontal_boundary
    y_coord = vertical_boundary

    x_coord && y_coord
  end

  # display tracks for selected album onto window
  def display_tracks(tracks)
    @tracks = tracks
    index = 0
    while index < @tracks.length
      track_name = @tracks[index].track_name
      y_coord = TRACK_TEXT_Y_OFFSET + (index * 40)
      @primary_font.draw_text(track_name, TRACK_TEXT_X_OFFSET, y_coord, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
      index += 1
    end
  end

  # plays selected track
  def playTrack(track_index)
    if @tracks && @tracks[track_index]
      track = @tracks[track_index]
      @song = Gosu::Song.new(track.track_location)
      @song.play(false)

      if @current_album
        @now_playing_message = "Now playing: #{track.track_name}" +
          "\n#{@current_album.album_artist} - #{@current_album.album_title}"
      else
        @now_playing_message = "Now playing: #{track.track_name}"
      end
    end
  end

  def draw_background
    draw_quad(0, 0, TOP_COLOR, width, 0, TOP_COLOR, 0, height, BOTTOM_COLOR, width, height, BOTTOM_COLOR,
              ZOrder::BACKGROUND)
  end

  # draw the album covers from the paths stored in albums array
  def draw_albums
    start_x_coord = 150
    start_y_coord = 50
    album_spacing = ALBUM_SPACING
    album_cover_size = ALBUM_SIZE
    columns = 2
    index = 0

    while index < @albums.length
      album = @albums[index]
      col = index % columns
      row = index / columns

      x_coord = start_x_coord + (col * (album_cover_size + album_spacing))
      y_coord = start_y_coord + (row * (album_cover_size + album_spacing))

      album.album_cover.bmp.draw(x_coord, y_coord, ZOrder::PLAYER, 1, 1)

      index += 1
    end

    def draw_debug
      @secondary_font.draw_text("Mouse X: #{mouse_x.round}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
      @secondary_font.draw_text("Mouse Y: #{mouse_y.round}", 10, 30, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
    end
  end

  # gosu function to loop functions
  def update; end

  # main gosu drawing function
  def draw
    draw_background
    draw_albums
    draw_debug
    display_tracks(@tracks) if @tracks
    return unless @now_playing_message

    @secondary_font.draw_text(@now_playing_message, 500, 900, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # mouse cursor should be visible
  def needs_cursor? = true

  # detect and handle mouse click events
  def button_down(id)
    case id
    when Gosu::MsLeft
      index = 0
      while index < @albums.length
        album = @albums[index]
        spacing = ALBUM_SPACING
        width = ALBUM_SIZE
        height = ALBUM_SIZE

        x_coord = 150 + ((index % 2) * (width + spacing))
        y_coord = 150 + ((index / 2) * (height + spacing))

        if area_clicked(x_coord, y_coord, x_coord + width, y_coord + height)
          @tracks = album.album_tracks
          @current_album = album
          break
        end

        index += 1
      end

      if @tracks
        track_index = 0
        @now_playing_message = ''

        while track_index < @tracks.length
          track = @tracks[track_index]
          track_x_coord = TRACK_TEXT_X_OFFSET
          track_y_coord = TRACK_TEXT_Y_OFFSET + (track_index * 40)
          track_height = 30

          if (mouse_x >= track_x_coord) &&
            (mouse_x <= track_x_coord + @primary_font.text_width(track.track_name)) &&
            (mouse_y >= track_y_coord) &&
            (mouse_y <= track_y_coord + track_height)

            playTrack(track_index)
            break
          end

          track_index += 1
        end
      end
    end
  end
end

MusicPlayerMain.new.show if __FILE__ == $PROGRAM_NAME
