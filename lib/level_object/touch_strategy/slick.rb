require 'level_object/touch_strategy/base'

module LevelObject
  module TouchStrategy
    class Slick < TouchStrategy::Base
      include Direction
      attr_accessor :base_strategy

      VELOCITY = 0.6
      MAX_SPEED = 8

      def after_init
        self.direction = :vertical
      end

      def base_strategy
        @base_strategy ||= TouchStrategy::Base.new(wall)
      end

      def changing_view?
        true
      end

      def image_path(wall_image_path)
        "slick_#{direction}_#{wall_image_path}"
      end

      def touch_top(object)
        speed_up object
        base_strategy.touch_top(object)
      end

      def touch_bottom(object)
        speed_up object
        base_strategy.touch_bottom(object)
      end

      def touch_right(object)
        speed_up object
        base_strategy.touch_right(object)
      end

      def touch_left(object)
        speed_up object
        base_strategy.touch_left(object)
      end

      private

      def speed_up(object)
        if vertical?
          speed_up_vertical object
        else
          speed_up_horizontal object
        end
      end

      def speed_up_vertical(player)
        player.vel_y += VELOCITY if player.vel_y > 0
        player.vel_y -= VELOCITY if player.vel_y < 0
      end

      def speed_up_horizontal(player)
        if player.vel_x > 0 and not max_speed_reached?(player)
          player.vel_x += VELOCITY
        end
        if player.vel_x < 0 and not max_speed_reached?(player)
          player.vel_x -= VELOCITY
        end
      end

      def max_speed_reached?(player)
        player.vel_x.abs > MAX_SPEED
      end
    end
  end
end
