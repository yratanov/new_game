require 'level_object/touch_strategy/base'

module LevelObject
  class Wall < LevelObject::Base
    def image_path
      if touch_strategy.changing_view?
        touch_strategy.image_path('wall.png')
      else
        'wall.png'
      end
    end

    def touch_right(object)
      touch_strategy.touch_right(object)
    end

    def touch_left(object)
      touch_strategy.touch_left(object)
    end

    def touch_top(object)
      touch_strategy.touch_top(object)
    end

    def touch_bottom(object)
      touch_strategy.touch_bottom(object)
    end

    def touch_strategy
      @touch_strategy ||= TouchStrategy::Base.new(self)
    end

    def touch_strategy=(strategy)
      @touch_strategy = strategy
    end
  end
end
