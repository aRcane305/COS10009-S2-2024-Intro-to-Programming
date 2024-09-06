require 'rubygems'
require 'gosu'
require_relative './circle'

# The screen has layers: Background, middle, top
module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

class DemoWindow < Gosu::Window
  def initialize
    super(640, 400, false)
  end

  def draw
    # see www.rubydoc.info/github/gosu/gosu/Gosu/Color for colours
    draw_quad(0, 0, 0xff_97ebff, 640, 0, 0xff_97ebff, 0, 400, 0xff_ffffff, 640, 400, 0xff_ffffff, ZOrder::BACKGROUND)
    draw_quad(40, 40, 0xff_333535, 600, 40, 0xff_333535, 40, 360, 0xff_333535, 600, 360, 0xff_333535, ZOrder::MIDDLE)
    draw_quad(50, 50, 0xff_b7c6ca, 590, 50, 0xff_767a7b, 50, 350, 0xff_929798, 590, 350, 0xff_767a7b, ZOrder::MIDDLE)
    draw_triangle(590, 50, 0xff_8511fa, 280, 50, 0xff_8511fa, 590, 250, 0xff_8511fa, ZOrder::MIDDLE, mode=:default)
    #draw_line(200, 200, Gosu::Color::BLACK, 350, 350, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
    # draw_rect works a bit differently:
    Gosu.draw_rect(220, 100, 200, 200, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
    Gosu.draw_rect(300, 360, 40, 40, 0xff_232525, ZOrder::TOP, mode=:default)
    Gosu.draw_rect(250, 260, 100, 20, Gosu::Color::WHITE, ZOrder::TOP, mode=:default)

    # Circle parameter - Radius
    img2 = Gosu::Image.new(Circle.new(50))
    # Image draw parameters - x, y, z, horizontal scale (use for ovals), vertical scale (use for ovals), colour
    # Colour - use Gosu::Image::{Colour name} or .rgb({red},{green},{blue}) or .rgba({alpha}{red},{green},{blue},)
    # Note - alpha is used for transparency.
    # drawn as an elipse (0.5 width:)
    img2.draw(240, 120, ZOrder::TOP, 0.6, 0.6, Gosu::Color::WHITE)
    img2.draw(340, 120, ZOrder::TOP, 0.6, 0.6, Gosu::Color::WHITE)
    # drawn as a red circle:
    #img2.draw(300, 50, ZOrder::TOP, 1.0, 1.0, 0xff_ff0000)
    # drawn as a red circle with transparency:
    # img2.draw(300, 250, ZOrder::TOP, 1.0, 1.0, 0x64_ff0000)

  end
end

DemoWindow.new.show
