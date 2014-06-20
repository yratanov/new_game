require 'level_object/touch_strategy/base'
require 'level_object/base'

module LevelObject
  class Bomb < LevelObject::Base
    def image
      if exploded? and not animation.finished?
        @image = animation
      elsif animation.finished?
        nil
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
      touch
    end

    def touch_left(object)
      touch
    end

    def touch_top(object)
      touch
    end

    def touch_bottom(object)
      touch
    end

    def touch
      mark_to_destroy
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

    def animation
      @animation ||= Animation.new(explode_images)
    end
  end
end
