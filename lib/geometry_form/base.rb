module GeometryForm
  class Base
    attr_accessor :x, :y, :width, :height

    def initialize(x, y, w, h)
      @x = x
      @y = y
      @width = w
      @height = h
    end

    def top
      @y
    end

    def top=(value)
      @y = value
    end

    def bottom
      @y + height
    end

    def bottom=(value)
      @y = value - height
    end

    def right
      @x + width
    end

    def right=(value)
      @x = value - width
    end

    def left
      @x
    end

    def left=(value)
      @x = value
    end

    def warp(x, y)
      @x, @y = x, y
    end

    def move_x(value)
      @x += value
    end

    def move_y(value)
      @y += value
    end
  end
end
