module LevelObject
  module TouchStrategy
    class Base
      attr_accessor :wall

      def initialize(wall)
        @wall = wall
        after_init
      end

      def after_init
      end

      def changing_view?
        false
      end

      def touch_right(object)
        object.left = wall.right
        object.vel_x = 0
      end

      def touch_left(object)
        object.right = wall.left
        object.vel_x = 0
      end

      def touch_top(object)
        object.bottom = wall.top
        object.on_ground = true
        object.vel_y = 0
      end

      def touch_bottom(object)
        object.top = wall.bottom
        object.vel_y = 0
      end
    end
  end
end
