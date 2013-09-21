require 'level_object/touch_strategy/base'
require 'level_object/touch_strategy/direction'

module LevelObject
  module TouchStrategy
    class Mud < TouchStrategy::Base
      include Direction

      VELOCITY = 0.6

      def after_init
        self.direction = :vertical
      end

      def base_strategy
        @base_strategy ||= TouchStrategy::Base.new(wall)
      end

      def touch_top(object)
        slow_down_horizontal object if horizontal?
        base_strategy.touch_top(object)
      end

      def touch_bottom(object)
        slow_down_horizontal object if horizontal?
        base_strategy.touch_bottom(object)
      end

      def touch_right(object)
        slow_down_vertical object if vertical?
        base_strategy.touch_right(object)
      end

      def touch_left(object)
        slow_down_vertical object if vertical?
        base_strategy.touch_left(object)
      end

      def changing_view?
        true
      end

      def image_path(wall_image_path)
        "mud_#{direction}_#{wall_image_path}"
      end

      private

      def slow_down_vertical(player)
        player.vel_y -= VELOCITY if player.vel_y > 0
        player.vel_y += VELOCITY if player.vel_y < 0
      end

      def slow_down_horizontal(player)
        player.vel_x -= VELOCITY if player.vel_x > 0
        player.vel_x += VELOCITY if player.vel_x < 0
      end
    end
  end
end
