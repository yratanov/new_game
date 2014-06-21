require 'hud/text'

module Hud
  class Debug < Hud::Text
    def lines
      [
        "fps:#{Gosu.fps}",
        "x:#{player.geometry.x}, y:#{player.geometry.y}",
        "vel_x:#{player.vel_x}, vel_y:#{player.vel_y}",
        "camera x:#{camera.rectangle.left}, y:#{camera.rectangle.top}",
        "level w:#{level.width}, h:#{level.height}"
      ]
    end

    def x
      50
    end
  end
end
