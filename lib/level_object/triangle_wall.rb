module LevelObject
  class TriangleWall < Wall
    def geometry_form
      GeometryForm::Triangle
    end

    def setup
      geometry.direction = :left
    end

    def direction=(direction)
      geometry.direction = direction
    end

    def touch_strategy
      return @touch_strategy if @touch_strategy
      case geometry.direction.to_s
      when 'left'
        @touch_strategy = TouchLeft.new(self)
      when 'right'
        @touch_strategy = TouchRight.new(self)
      end
    end

    def image_path
      "triangle_#{geometry.direction.to_s}_wall.png"
    end

    class TouchLeft < TouchStrategy::Base
      def touch_top(object)
        object.geometry.bottom = wall.geometry.y_at(object.geometry.right)
        object.on_ground = true
        object.vel_y = 0
        object.stand!
      end

      def touch_left(object)
        object.vel_y = object.vel_x
        object.run_right!
      end

      def touch_right(object)
        object.vel_y = object.vel_x
        object.vel_x = - object.vel_x * Math.sqrt(2)/2
        object.run_left!
      end
    end

    class TouchRight < TouchStrategy::Base
      def touch_top(object)
        object.geometry.bottom = wall.geometry.y_at(object.geometry.left)
        object.on_ground = true
        object.vel_y = 0
        object.stand!
      end

      def touch_right(object)
        object.vel_y = -object.vel_x
        object.run_left!
      end

      def touch_left(object)
        object.run_right!
      end
    end

  end
end
