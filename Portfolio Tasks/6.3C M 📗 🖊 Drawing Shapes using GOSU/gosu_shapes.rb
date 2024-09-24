require 'rubygems'
require 'gosu'
require_relative './circle' # require by itself doesn't work on Rubymine because I have multiple folders and files.

# The screen has layers: Background, Monitor, Ruby Background, Ruby Logo, Top
module ZOrder
  BACKGROUND, MONITOR, CASE, RUBYBACKGROUND, RUBYLOGO, TOP = *0..5
end

class DemoWindow < Gosu::Window
  def initialize
    super(1280, 720, false) # true for fullscreen
  end

  def draw
    # see www.rubydoc.info/github/gosu/gosu/Gosu/Color for colours
    # background sky box gradient
    draw_quad(0, 0, 0xff_97ebff, 1280, 0, 0xff_97ebff, 0, 720, 0xff_ffffff, 1280, 720, 0xff_ffffff, ZOrder::BACKGROUND)
    # monitor frame
    Gosu.draw_rect(120, 103, 700, 394, 0xff_333535, ZOrder::MONITOR)
    # monitor grey screen background gradient
    draw_quad(130, 113, 0xff_b7c6ca, 810, 113, 0xff_767a7b, 130, 487, 0xff_929798, 810, 487, 0xff_b7c6ca, ZOrder::MONITOR)
    # monitor support stand
    Gosu.draw_rect(380, 527, 180, 45, 0xff_232525, ZOrder::MONITOR)
    draw_triangle(380, 616, 0xff_232525, 380, 527, 0xff_232525, 440, 527, 0xff_232525, ZOrder::MONITOR)
    draw_triangle(380, 616, 0xff_232525, 380, 527, 0xff_232525, 320, 616, 0xff_232525, ZOrder::MONITOR)
    draw_triangle(560 ,616, 0xff_232525, 560, 527, 0xff_232525, 500, 527, 0xff_232525, ZOrder::MONITOR)
    draw_triangle(560 ,616, 0xff_232525, 560, 527, 0xff_232525, 620, 616, 0xff_232525, ZOrder::MONITOR)
    # monitor base vertical support
    Gosu.draw_rect(440, 497, 60, 70, 0xff_242727, ZOrder::MONITOR)
    # computer case
    Gosu.draw_rect(855, 103, 285, 490, 0xff_111010, ZOrder::CASE)
    # case bottom frame
    Gosu.draw_rect(855, 590, 285, 11, 0xff_272424, ZOrder::CASE)
    # case left leg
    draw_quad(855, 601, 0xff_272424, 930, 601, 0xff_272424, 855, 616, 0xff_272424, 923, 616, 0xff_272424, ZOrder::CASE)
    # case right leg
    draw_quad(1065, 601, 0xff_272424, 1140, 601, 0xff_272424, 1072, 616, 0xff_272424, 1140, 616, 0xff_272424, ZOrder::CASE)
    # case led gradient panel
    draw_quad(1060, 105, Gosu::Color::RED, 1065, 105, Gosu::Color::YELLOW, 1060, 588, Gosu::Color::GREEN, 1065, 588, Gosu::Color::BLUE, ZOrder::TOP)
    # case window
    Gosu.draw_rect(857, 105, 201, 483, 0xff_2b2929, ZOrder::TOP)
    # case button outline
    Gosu.draw_rect(1104, 263, 36, 14, 0xff_2b2929, ZOrder::TOP)
    # case button
    Gosu.draw_rect(1106, 265, 34, 10, 0xff_111010, ZOrder::TOP)
    # case button led
    Gosu.draw_rect(1114, 269 ,20 , 2, Gosu::Color::WHITE, ZOrder::TOP)
    # ruby top right background triangle
    draw_triangle(810, 113, 0xff_8511fa, 280, 113, 0xff_8511fa, 810, 300, 0xff_8511fa, ZOrder::RUBYBACKGROUND)
    # ruby bottom left background triangle
    draw_triangle(130, 300, 0xff_ff5733, 130, 487, 0xff_ff5733, 660, 487, 0xff_ff5733, ZOrder::RUBYBACKGROUND)
    # ruby logo black square
    Gosu.draw_rect(365, 200, 200, 200, Gosu::Color::BLACK, ZOrder::RUBYLOGO)
    # ruby logo white bar
    Gosu.draw_rect(395, 360, 100, 20, Gosu::Color::WHITE, ZOrder::RUBYLOGO)

    # ruby logo white circles
    img2 = Gosu::Image.new(Circle.new(50))
    img2.draw(385, 220, ZOrder::RUBYLOGO, 0.6, 0.6, Gosu::Color::WHITE)
    img2.draw(485, 220, ZOrder::RUBYLOGO, 0.6, 0.6, Gosu::Color::WHITE)


  end
end

DemoWindow.new.show
