class Camera
  attr_accessor :rectangle, :x, :y, :window

  def initialize(window)
    @window = window
  end

  def target(level_object)
    @target = level_object

    if @target.x + window.width/2 < window.level.width and @target.x - window.width/2 > 0
      @x = @target.x - window.width/2
    elsif @target.x - window.width/2 < 0
      @x = 0
    else
      @x = window.level.width - window.width
    end

    if @target.y + window.height/2 < window.level.height and @target.y - window.height/2 > 0
      @y = @target.y - window.height/2
    elsif @target.y - window.height/2 < 0
      @y = 0
    else
      @y = window.level.height - window.height
    end
  end
end
