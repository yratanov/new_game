require 'hud/image'

module Hud
  class Gameover < Hud::Image
    def image
      @image ||= @image_registry.image('gameover.png')
    end

    def draw
      image.draw((window.width / 2) - (image.width / 2),
                 (window.height / 2) - (image.height / 2), 0)
    end
  end
end
