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
      draw_x = window.width / 2 - player.max_hp.to_i * images[:full].width / 2
      player.hp.times do
        images[:full].draw(draw_x, 100, 0)
        draw_x += images[:full].width
      end
      (player.max_hp - player.hp).times do
        images[:empty].draw(draw_x, 100, 0)
        draw_x +=  images[:empty].width
      end
    end
  end
end
