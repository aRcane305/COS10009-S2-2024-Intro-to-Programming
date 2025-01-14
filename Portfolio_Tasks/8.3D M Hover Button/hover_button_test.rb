# frozen_string_literal: true

require 'rubygems'
require 'gosu'

# Instructions:  This code also needs to be fixed and finished!
# As in the earlier button tasks the "Click Me" text is not appearing
# on the button, also both the mouse_x and mouse_ co-ordinate should
# be shown, regardless of whether the mouse has been clicked or not.
# The button should be highlighted when the mouse moves over it
# (i.e it should have a black border around the outside)
# finally, a user has noticed that in this version also sometimes the
# button action occurs when you click outside the button area and vice-versa.

# FOR THE CREDIT VERSION:
# display a colored border that 'highlights' the button when the mouse moves over it

# determines whether a graphical widget is placed over others or not
module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

# Global constants
WIN_WIDTH = 640
WIN_HEIGHT = 400

class DemoWindow < Gosu::Window
  # set up variables and attributes
  def initialize
    super(WIN_WIDTH, WIN_HEIGHT, false)
    @background = Gosu::Color::WHITE
    @button_font = Gosu::Font.new(20)
    @info_font = Gosu::Font.new(10)
    @locs = [60, 60]
  end

  # Draw the background, the button with 'click me' text and text
  # showing the mouse coordinates
  def draw
    # Draw background color
    Gosu.draw_rect(0, 0, WIN_WIDTH, WIN_HEIGHT, @background, ZOrder::BACKGROUND, :default)
    # Draw the rectangle that provides the background.
    # rectangle only appears when hover, code checks for mouse. cant put this in def mouse_over_button as the drawing happens here
    if mouse_over_button(mouse_x, mouse_y)
      # Draw a grey background for the button when the mouse is over it
      # the rectangle is shifted up 2 units, left 2 units, and extended 4 units each side in order to form the perimeter
      Gosu.draw_rect(48, 48, 104, 54, Gosu::Color::BLACK, ZOrder::MIDDLE, :default)
    end
    # Draw the button
    Gosu.draw_rect(50, 50, 100, 50, Gosu::Color::GREEN, ZOrder::TOP, :default)
    # Draw the button text
    # changed to TOP as it was not showing earlier, MIDDLE meant that it was below the button
    @button_font.draw_text('Click me', 60, 60, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
    # Draw the mouse_x position
    @info_font.draw_text("mouse_x: #{mouse_x}", 20, 370, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
    # Draw the mouse_y position
    @info_font.draw_text("mouse_y: #{mouse_y}", 20, 380, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # this is called by Gosu to see if it should show the cursor (or mouse)
  def needs_cursor? = true

  # This sttill needs to be fixed!

  def mouse_over_button(mouse_x, mouse_y)
    # changed to mouse_y and mouse_y
    # function is true between 50 and 150 for x
    # function is true between 50 and 150 for y
    # then function is only true between the two
    # shorter and neater than an if else statement
    ((mouse_x > 50) && (mouse_x < 150)) && ((mouse_y > 50) && (mouse_y < 100))
  end

  # If the button area (rectangle) has been clicked on change the background color
  # also store the mouse_x and mouse_y attributes that we 'inherit' from Gosu
  # you will learn about inheritance in the OOP unit - for now just accept that
  # these are available and filled with the latest x and y locations of the mouse click.
  def button_down(id)
    case id
    when Gosu::MsLeft
      # neatens up and prevents repetition by bringing background out
      @background = if mouse_over_button(mouse_x, mouse_y)
                      Gosu::Color::YELLOW
                    else
                      Gosu::Color::WHITE
                    end
    end
  end
end

# Lets get started!
DemoWindow.new.show
