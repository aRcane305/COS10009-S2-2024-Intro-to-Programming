require 'gosu'

module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

# Instructions:
# Add a shape_x variable in the following (similar to the cycle one)
# that is initialised to zero then incremented by 10 in update.
# Change the draw method to draw a shape (circle or square)
# (50 pixels in width and height) with a y coordinate of 30
# and an x coordinate of shape_x.
class GameWindow < Gosu::Window

  # initialize creates a window with a width an a height
  # and a caption. It also sets up any variables to be used.
  # This is procedure i.e the return value is 'undefined'
  def initialize
    super(200, 135, false)
    self.caption = "Gosu Cycle Example"

    # Create and load an image to display
    @background_image = Gosu::Image.new("/Users/arcane/RubymineProjects/COS10009-S2-2024-Intro-to-Programming/Portfolio Tasks/8.2C M 📗 🖊 Gosu Major Cycle /media/earth.png")

    # Create and load a font for drawing text on the screen
    @font = Gosu::Font.new(20)
    @cycle = 0
    puts("0. In initialize\n")
    @shape_x = 0
  end

  # Put any work you want done in update
  # This is a procedure i.e the return value is 'undefined'
  def update
  	puts("1. In update. Sleeping for one second\n")
    @cycle += 1 # add one to the current value of cycle
    sleep(1)
    @shape_x += 10
  end

  # the following method is called when you press a mouse
  # button or key
  def button_down(id)
    puts("In Button Down " + id.to_s)
  end

  # Draw (or Redraw) the window
  # This is procedure i.e the return value is 'undefined'
  def draw
    # Draws an image with an x, y and z
    #(z determines if it sits on or under other things that are drawn)
    @background_image.draw(0, 0, z = ZOrder::BACKGROUND)
    @font.draw_text("Cycle count: #{@cycle}", 10, 10, z = ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
    puts("2. In draw\n")
    Gosu.draw_rect(@shape_x, 30, 50, 70, 0xff_333535)
  end
end

window = GameWindow.new
window.show
