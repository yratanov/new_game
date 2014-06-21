require 'geometry_form/triangle_direction/base'

module GeometryForm
  module TriangleDirection
    class Right < TriangleDirection::Base
      def calculate_constants
        return if @line_constant_1 and @line_constant_2

        @line_constant_1 = (triangle.left - triangle.right)/
          (triangle.top - triangle.bottom)

        line_constant_2_numerator = triangle.right * triangle.top -
          triangle.left * triangle.bottom
        line_constant_2_denominator = triangle.top - triangle.bottom

        @line_constant_2 = line_constant_2_numerator /
          line_constant_2_denominator
      end

      def dot_inside?(x, y)
        calculate_constants
        x >= triangle.left and y <= triangle.bottom and
          x <= @line_constant_1 * y + @line_constant_2
      end

      def to_s
        'right'
      end
    end
  end
end
