require 'level_object/touch_strategy/base'

module LevelObject
  class Bomb < LevelObject::Base

    def image
      if exploded?
        @images = Animation.new(explode_images)
      else
        @image = @image_registry.image('bomb/bomb.png')
      end
    end

    def explode_images
      %w(explosion_1 explosion_2 explosion_3 explosion_4 empty).map do |file|
        @image_registry.image("bomb/#{file}.png")
      end
    end

    def touch_right(object)
      explode(object)
    end

    def touch_left(object)
      self.touch_right(object)
    end

    def touch_top(object)
      self.touch_right(object)
    end

    def touch_bottom(object)
      self.touch_right(object)
    end

    def explode(object)
      @exploded = true
    end

    def exploded?
      @exploded
    end

    def touch_strategy
      @touch_strategy ||= TouchStrategy::Base.new(self)
    end

    def touch_strategy=(strategy)
      @touch_strategy = strategy
    end
  end
end