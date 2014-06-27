require 'hud/text'

module Hud
  class Debug < Hud::Text
    class << self
      attr_accessor :show
    end

    def lines
      if self.class.show
        [
          "fps:#{Gosu.fps}",
          "x:#{player.geometry.x}, y:#{player.geometry.y}",
          "vel_x:#{player.vel_x}, vel_y:#{player.vel_y}",
          "camera x:#{camera.rectangle.left}, y:#{camera.rectangle.top}",
          "level w:#{level.width}, h:#{level.height}"
        ]
      else
        []
      end
    end

    def x
      50
    end
  end
end
