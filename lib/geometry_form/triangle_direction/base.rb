module GeometryForm
  module TriangleDirection
    class Base
      attr_accessor :triangle

      def initialize(triangle)
        @triangle = triangle
      end

      def y_at(x)
        calculate_constants
        if x > triangle.right
          x = triangle.right
        elsif x < triangle.left
          x = triangle.left
        end
        (x - @line_constant_2) / @line_constant_1
      end

      def x_at(y)
        calculate_constants
        if y > triangle.bottom
          y = triangle.bottom
        elsif y < triangle.top
          y = triangle.top
        end
        y * @line_constant_1 + @line_constant_2
      end
    end
  end
end
