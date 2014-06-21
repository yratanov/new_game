require 'geometry_form/base'
require 'geometry_form/triangle_direction/left'
require 'geometry_form/triangle_direction/right'

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
        @direction = TriangleDirection::Left.new(self)
      when :right
        @direction = TriangleDirection::Right.new(self)
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
  end
end
