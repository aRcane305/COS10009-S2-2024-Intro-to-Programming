# frozen_string_literal: true
require_relative 'z0rder'
require_relative 'genre'
require_relative 'album'
require_relative 'track'
require_relative 'load_albums'
require_relative 'display_albums'
require_relative 'artwork'
require 'rubygems'
require 'gosu'

WINDOW_WIDTH = 1600
WINDOW_HEIGHT = 900
TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

# Put your record definitions here

class MusicPlayerMain < Gosu::Window
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT, false)
    self.caption = 'Music Player'
    @music_player_font = Gosu::Font.new(26)
    # Reads in an array of albums from a file and then prints all the albums in the
    # array to the terminal
    read_in_albums
    display_loaded_albums
  end

  # Put in your code here to load albums and tracks

  # Draws the artwork on the screen for all the albums

  # Detects if a 'mouse sensitive' area has been clicked on
  # i.e either an album or a track. returns true or false

  def area_clicked(leftX, topY, rightX, bottomY)
    # complete this code
  end

  # Takes a String title and an Integer ypos
  # You may want to use the following:
  def display_track(title, ypos)
    @track_font.draw(title, TrackLeftX, ypos, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # Takes a track index and an Album and plays the Track from the Album

  def playTrack
    #
  end

  # Draw a coloured background using TOP_COLOR and BOTTOM_COLOR
  def draw_background
    draw_quad(0, 0, TOP_COLOR, width, 0, TOP_COLOR, 0, height, BOTTOM_COLOR, width, height, BOTTOM_COLOR,
              ZOrder::BACKGROUND)
  end

  def draw_albums
    # Define the size for album cover display and the space between them.
    album_size = 400
    margin = 20

    # Define starting positions for the first album cover.
    start_x = margin
    start_y = margin * 2

    # Define how many albums to display per row.
    items_per_row = 2

    # Start with the first album (index 0).
    index = 0
    while index < @albums.size
      album = @albums[index]

      # Calculate scale_factor, x, and y once per album
      scale_factor = album_size.to_f / [album.album_cover.bmp.width, album.album_cover.bmp.height].max
      x = start_x + ((index % items_per_row) * (album_size + margin))
      y = start_y + ((index / items_per_row) * (album_size + margin))

      # Draw the stored album artwork image
      album.album_cover.bmp.draw(x, y, ZOrder::PLAYER, scale_factor, scale_factor)

      index += 1
    end
  end

  def update; end

  # Draws the album images and the track list for the selected album

  def draw
    draw_background
    draw_albums
  end

  def needs_cursor? = true

  # If the button area (rectangle) has been clicked on change the background color
  # also store the mouse_x and mouse_y attributes that we 'inherit' from Gosu
  # you will learn about inheritance in the OOP unit - for now just accept that
  # these are available and filled with the latest x and y locations of the mouse click.

  def button_down(id)
    case id
    when Gosu::MsLeft

    end
  end
end

# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $PROGRAM_NAME
