require 'geometry_form/triangle'
require 'geometry_form/rectangle'

module GeometryForm
  class Collision
    def collided?(geometry_form_1, geometry_form_2)
      if two_rectangles?(geometry_form_1, geometry_form_2)
        @collided = collide_rectangles(geometry_form_1, geometry_form_2)
      elsif geometry_form_1.kind_of?(Rectangle) and geometry_form_2.kind_of?(Triangle)
        @collided = collide_triangle_and_rectangle(geometry_form_1, geometry_form_2)
      elsif geometry_form_1.kind_of?(Triangle) and geometry_form_2.kind_of?(Rectangle)
        @collided = collide_triangle_and_rectangle(geometry_form_2, geometry_form_1)
      else
        raise "Cannot collide #{geometry_form_1.class} and #{geometry_form_2.class}"
      end
    end

    private

    def collide_triangle_and_rectangle(rectangle, triangle)
      rectangle_in_triangle = [[rectangle.left, rectangle.top], [rectangle.left, rectangle.bottom],
                               [rectangle.right, rectangle.top], [rectangle.right, rectangle.bottom]].any? do |dot|
        x = dot.first
        y = dot.last
        triangle.dot_inside?(x, y)
      end

      return true if rectangle_in_triangle

      [[triangle.left, triangle.bottom],
       [triangle.right, triangle.top], [triangle.right, triangle.bottom]].any? do |dot|
        x = dot.first
        y = dot.last
        x < rectangle.right and y < rectangle.bottom and y > rectangle.top and x > rectangle.left
      end
    end

    def collide_rectangles(rectangle_1, rectangle_2)
      rectangle_1.left < rectangle_2.right and rectangle_1.right > rectangle_2.left and rectangle_1.top < rectangle_2.bottom and rectangle_1.bottom > rectangle_2.top
    end

    def two_rectangles?(geometry_form_1, geometry_form_2)
      geometry_form_1.kind_of?(Rectangle) and geometry_form_2.kind_of?(Rectangle)
    end

    def rectangle_and_triangle(geometry_form_1, geometry_form_2)
      (geometry_form_1.kind_of?(Rectangle) and geometry_form_2.kind_of?(Triangle)) or (geometry_form_1.kind_of?(Triangle) and geometry_form_2.kind_of?(Rectangle))
    end
  end
end
