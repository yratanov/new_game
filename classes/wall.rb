class Wall
  WALL_HEIGHT = 25.0
  WALL_WIDTH = 25.0

  def initialize(image_registry, x, y)
    @image = image_registry.image('/media/images/wall.png')
    @x = x
    @y = y
  end

  def draw
    scale_x = WALL_WIDTH / @image.width
    scale_y = WALL_HEIGHT / @image.height
    @image.draw(@x, @y, 0, scale_x, scale_y)
  end
end
