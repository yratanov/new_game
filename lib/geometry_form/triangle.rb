require 'geometry_form/base'

module GeometryForm
  class Triangle < GeometryForm::Base
    attr_accessor :direction
    DIRECTIONS = [:right, :left, :top, :bottom]

    def initialize(x, y, w, h, direction = :left)
      super(x, y, w, h)
      self.direction = direction
    end

    def direction=(direction)
      case direction
      when :left
        @direction = Left.new(self)
      when :right
        @direction = Right.new(self)
      end
    end

    def y_at(x)
      @direction.y_at(x)
    end

    def x_at(y)
      @direction.x_at(y)
    end

    def dot_inside?(x, y)
      @direction.dot_inside?(x, y)
    end

    DIRECTIONS.each do |dir|
      define_method "#{dir}?" do
        @direction == dir.to_sym
      end
    end

    # Top triangle line
    class Direction
      attr_accessor :triangle

      def initialize(triangle)
        @triangle = triangle
      end

      def y_at(x)
        calculate_constants
        (x - @line_constant_2)/ @line_constant_1
      end

      def x_at(y)
        calculate_constants
        y * @line_constant_1 + @line_constant_2
      end
    end

    class Right < Direction
      def calculate_constants
        @line_constant_1 ||= (triangle.left - triangle.right)/(triangle.top - triangle.bottom)
        @line_constant_2 ||= triangle.right - triangle.bottom * (triangle.left - triangle.right)/(triangle.top - triangle.bottom)
      end

      def dot_inside?(x, y)
        calculate_constants
        x >= triangle.left and y <= triangle.bottom and x <= @line_constant_1 * y + @line_constant_2
      end

      def to_s
        'right'
      end
    end

    class Left < Direction
      def calculate_constants
        @line_constant_1 ||= (triangle.left - triangle.right)/(triangle.bottom - triangle.top)
        @line_constant_2 ||= triangle.right - triangle.top * (triangle.left - triangle.right)/(triangle.bottom - triangle.top)
      end

      def dot_inside?(x, y)
        calculate_constants
        x <= triangle.right and y <= triangle.bottom and x >= @line_constant_1 * y + @line_constant_2
      end

      def to_s
        'left'
      end
    end
  end
end
