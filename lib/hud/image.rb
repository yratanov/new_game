module Hud
  class Image
    attr_accessor :window

    def initialize(window, image_registry)
      @window = window
      @image_registry = image_registry
    end

    def image
    end

    def draw
    end

    def player
      window.player
    end

    def level
      window.level
    end
  end
end
