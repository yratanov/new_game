require 'level_object/touch_strategy/base'
require 'level_object/base'

module LevelObject
  class Health < LevelObject::Base
    def image
      @image = @image_registry.image('health.png')
    end

    def touch_right(object)
      touch(object) if not touched?
    end

    def touch_left(object)
      touch(object) if not touched?
    end

    def touch_top(object)
      touch(object) if not touched?
    end

    def touch_bottom(object)
      touch(object) if not touched?
    end

    def touch(object)
      config = Game::Config.load(:health)
      object.get_heal(config['health_points'])
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
