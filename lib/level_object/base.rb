require 'geometry_form/rectangle'

module LevelObject
  class Base
    HEIGHT = 37.0
    WIDTH = 37.0
    attr_accessor :geometry

    def initialize(image_registry, x, y)
      @image_registry = image_registry
      @geometry = geometry_form.new(x, y, width, height)
      setup
    end

    def setup
    end

    def geometry_form
      GeometryForm::Rectangle
    end

    def draw
      return unless image
      @scale_x ||= WIDTH / image.width
      @scale_y ||= HEIGHT / image.height
      image.draw(geometry.x, geometry.y, 0, @scale_x, @scale_y)
    end

    def image
      @image = @image_registry.image(image_path)
    end

    def x
      geometry.x
    end

    def y
      geometry.y
    end

    def width
      WIDTH
    end

    def height
      HEIGHT
    end

    def touch_right(object)
    end

    def touch_left(object)
    end

    def touch_top(object)
    end

    def touch_bottom(object)
    end

    def mark_to_destroy
      @marked_to_destroy = true
    end

    def collided?(object)
      geometry.collided?(object.geometry)
    end

    def marked_to_destroy?
      @marked_to_destroy
    end
  end
end
