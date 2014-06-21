require 'level_object/touch_strategy/triangle/left'
require 'level_object/touch_strategy/triangle/right'

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
        @triangle_touch_strategy ||= TouchStrategy::Triangle::Left.new(self)
      when 'right'
        @triangle_touch_strategy ||= TouchStrategy::Triangle::Right.new(self)
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
  end
end
