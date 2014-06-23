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
      player.hp.times do |i|
        images[:full].draw((window.width / 2.5) + i * images[:full].width, 100, 0)
      end
    end
  end
end
