require 'level_object/touch_strategy/base'
require 'level_object/base'

module LevelObject
  class Health < LevelObject::Base
    attr_accessor :health_points

    class << self
      attr_accessor :health_points
    end

    def health_points
      @health_points = self.class.health_points
    end

    def image
      @image = @image_registry.image('health.png')
    end

    def touch_right(object)
      touch(object)
    end

    def touch_left(object)
      touch(object)
    end

    def touch_top(object)
      touch(object)
    end

    def touch_bottom(object)
      touch(object)
    end

    def touch(object)
      return if touched?
      object.heal(health_points)
      @touched = true
      mark_to_destroy
    end

    def touched?
      @touched
    end

    def touch_strategy
      @touch_strategy ||= TouchStrategy::Base.new(self)
    end

    def touch_strategy=(strategy)
      @touch_strategy = strategy
    end
  end
end
