# frozen_string_literal: true

require 'gosu'

module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

WIDTH = 400
HEIGHT = 500
SHAPE_DIM = 50

# added info_font to print out coordinates of the shape
class GameWindow < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT, false)
    self.caption = 'Shape Moving'

    # initial box draw coordinates
    @shape_y = HEIGHT / 2
    @shape_x = WIDTH / 2
    @info_font = Gosu::Font.new(10)
  end

  # button presses to box direction
  def update
    # simplify the if statments
    @shape_x += 3 if button_down?(Gosu::KbRight)

    @shape_x -= 3 if button_down?(Gosu::KbLeft)

    @shape_y += 3 if button_down?(Gosu::KbDown)

    @shape_y -= 3 if button_down?(Gosu::KbUp)

    # ensure that the box stays within the game window
    @shape_x = [[@shape_x, 0].max, WIDTH - SHAPE_DIM].min
    @shape_y = [[@shape_y, 0].max, HEIGHT - SHAPE_DIM].min
  end

  # Draw (or Redraw) the window
  # This is procedure i.e the return value is 'undefined'
  def draw
    Gosu.draw_rect(@shape_x, @shape_y, SHAPE_DIM, SHAPE_DIM, Gosu::Color::RED, ZOrder::TOP, :default)
    # Draw the shape_x position
    # changed font height from 470 to relative for future codes
    @info_font.draw_text("shape_x: #{@shape_x}", 20, HEIGHT - 30, ZOrder::TOP, 1.0, 1.0, Gosu::Color::WHITE)
    # Draw the shape_y position
    # changed font height from 480 to relative for future codes
    @info_font.draw_text("shape_y: #{@shape_y}", 20, HEIGHT - 20, ZOrder::TOP, 1.0, 1.0, Gosu::Color::WHITE)
  end
end

window = GameWindow.new
window.show
