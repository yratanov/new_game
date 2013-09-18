class Camera
  attr_accessor :rectangle, :x, :y, :window

  def initialize(window)
    @window = window
  end

  def target(level_object)
    @target = level_object

    if not right_border_intersect? and not left_border_intersect?
      @x = @target.x - window.width/2
    elsif left_border_intersect?
      @x = 0
    else
      @x = window.level.width - window.width
    end

    if not top_border_intersect? and not bottom_border_intersect?
      @y = @target.y - window.height/2
    elsif top_border_intersect?
      @y = 0
    else
      @y = window.level.height - window.height
    end
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
