require 'hud/image'

module Hud
  class Health < Hud::Image
    def images
      @images ||= {
          full: @image_registry.image('/player/health.png'),
          empty: @image_registry.image('/player/health_empty.png')
      }
    end

    def draw
      width = window.width
      player.hp.times do |i|
        images[:full].draw((width / 2) + i * 50, 100, 0)
      end
    end
  end
end
