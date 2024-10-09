require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Quarter Circle Example"
    @radius = 100   # Radius of the quarter circle
    @center_x = 200 # X coordinate of the center
    @center_y = 200 # Y coordinate of the center
    @color = Gosu::Color::WHITE # Color of the quarter circle
  end

  def draw
    draw_quarter_circle(@center_x, @center_y, @radius, 90, @color)
  end

  # Draws a quarter circle from 0 to 90 degrees
  def draw_quarter_circle(center_x, center_y, radius, angle_step, color)
    segments = 3000  # Number of triangles (higher = smoother curve)
    angle_per_segment = Math::PI / 2 / segments  # Angle step in radians

    (0..segments).each do |i|
      # Calculate the angle for this segment
      angle1 = i * angle_per_segment
      angle2 = (i + 1) * angle_per_segment

      # Calculate the coordinates for the vertices of the triangle
      x1 = center_x
      y1 = center_y

      x2 = center_x + Math.cos(angle1) * radius
      y2 = center_y - Math.sin(angle1) * radius

      x3 = center_x + Math.cos(angle2) * radius
      y3 = center_y - Math.sin(angle2) * radius

      # Draw the triangle
      Gosu.draw_triangle(
        x1, y1, color, # Center vertex
        x2, y2, color, # First edge of the quarter circle
        x3, y3, color, # Second edge of the quarter circle
        0              # Z-index (depth)
      )
    end
  end
end

window = GameWindow.new
window.show
