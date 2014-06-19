require 'geometry_form/collision'

class Camera
  attr_accessor :rectangle, :window

  def initialize(window)
    @window = window
    self.rectangle = GeometryForm::Rectangle.
      new(0, 0, @window.width, @window.height)
  end

  def target(level_object)
    @target = level_object
    if not right_border_intersect? and not left_border_intersect?
      rectangle.left = @target.x - window.width/2
    elsif left_border_intersect?
      rectangle.left = 0
    else
      rectangle.left = window.level.width - window.width
    end

    if not top_border_intersect? and not bottom_border_intersect?
      rectangle.top = @target.y - window.height/2
    elsif top_border_intersect?
      rectangle.top = 0
    else
      rectangle.top = window.level.height - window.height
    end
  end

  def can_see?(object)
    @collision ||= GeometryForm::Collision.new
    @collision.collided?(object.geometry, rectangle)
  end

  private

  def right_border_intersect?
    @target.x + window.width/2 > window.level.width
  end

  def left_border_intersect?
    @target.x - window.width/2 < 0
  end

  def top_border_intersect?
    @target.y - window.height/2 < 0
  end

  def bottom_border_intersect?
    @target.y + window.height/2 > window.level.height
  end
end
