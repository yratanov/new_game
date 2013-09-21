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
        object.geometry.left = wall.geometry.right
      end

      def touch_left(object)
        object.geometry.right = wall.geometry.left
      end

      def touch_top(object)
        object.geometry.bottom = wall.geometry.top
        object.on_ground = true
        object.vel_y = 0
      end

      def touch_bottom(object)
        object.geometry.top = wall.geometry.bottom
        object.vel_y = 0
      end
    end
  end
end
