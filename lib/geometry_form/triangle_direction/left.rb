require 'geometry_form/triangle_direction/base'

module GeometryForm
  module TriangleDirection
    class Left < TriangleDirection::Base
      def calculate_constants
        return if @line_constant_1 and @line_constant_2

        @line_constant_1 = (triangle.left - triangle.right)/
          (triangle.bottom - triangle.top)

        line_constant_2_numerator = triangle.right * triangle.bottom -
          triangle.left * triangle.top
        line_constant_2_denominator = triangle.bottom - triangle.top

        @line_constant_2 = line_constant_2_numerator /
          line_constant_2_denominator
      end

      def dot_inside?(x, y)
        calculate_constants
        x <= triangle.right and y <= triangle.bottom and
          x >= @line_constant_1 * y + @line_constant_2
      end

      def to_s
        'left'
      end
    end
  end
end
