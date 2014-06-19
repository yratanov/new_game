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
      if @touch_strategy and @touch_strategy != triangle_touch_strategy
        @touch_strategy.base_strategy = triangle_touch_strategy
      else
        @touch_strategy = triangle_touch_strategy
      end
      @touch_strategy
    end

    def triangle_touch_strategy
      case geometry.direction.to_s
      when 'left'
        @triangle_touch_strategy ||= TouchLeft.new(self)
      when 'right'
        @triangle_touch_strategy ||= TouchRight.new(self)
      end
    end

    def image_path
      if touch_strategy.changing_view?
        touch_strategy.
          image_path("triangle_#{geometry.direction.to_s}_wall.png")
      else
        "triangle_#{geometry.direction.to_s}_wall.png"
      end
    end

    class TouchLeft < TouchStrategy::Base
      def touch_top(object)
        object.geometry.bottom = wall.geometry.y_at(object.geometry.right)
        object.on_ground = true
        object.vel_y = 0
        object.vel_x -= 1
        object.stand!
      end

      def touch_left(object)
        object.geometry.right = wall.geometry.x_at(object.geometry.bottom)
        object.vel_y = - object.vel_x
        object.run_right!
      end

      def touch_right(object)
        object.geometry.right = wall.geometry.x_at(object.geometry.bottom)
        object.vel_y = - object.vel_x
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
