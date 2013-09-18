class LevelObject
  HEIGHT = 37.0
  WIDTH = 37.0
  attr_accessor :rectangle

  def initialize(image_registry, x, y)
    @image_registry = image_registry
    @rectangle = Rectangle.new(x, y, width, height)
  end

  def draw
    @scale_x ||= WIDTH / image.width
    @scale_y ||= HEIGHT / image.height
    image.draw(rectangle.x, rectangle.y, 0, @scale_x, @scale_y)
  end

  def image
    if touched
      @image = @image_registry.image(touched_path)
    else
      @image = @image_registry.image(image_path)
    end
  end

  def width
    WIDTH
  end

  def height
    HEIGHT
  end

  def collided?(object)
    rectangle.collided?(object.rectangle)
  end
end
