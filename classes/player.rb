class Player < LevelObject
  attr_accessor :run_speed, :max_speed, :jump_power, :vel_x, :vel_y, :rectangle

  STATES = [:crouch, :stand, :run_right, :run_left, :jump, :jump_left, :jump_right]

  def initialize(level, image_registry)
    @level = level
    @view = PlayerView.new(self, image_registry)
    @vel_x = @vel_y = 0.0
    @rectangle = Rectangle.new(0, 0, width, height)
    stand!
    self.run_speed = 2
    self.max_speed = 6
    self.jump_power = 20
  end

  STATES.each do |state|
    define_method "#{state}?" do
      @state == state
    end

    define_method "#{state}!" do
      @state = state
    end
  end

  def warp(x, y)
    rectangle.warp(x, y)
  end

  def go_left
    @vel_x -= run_speed if @vel_x > 0 or not max_run_speed?
  end

  def go_right
    @vel_x += run_speed if @vel_x < 0 or not max_run_speed?
  end

  def stand
    @vel_x = 0
  end

  def crouch
    crouch!
  end

  def width
    @view.width
  end

  def height
    @view.height
  end

  def max_run_speed?
    @vel_x.abs == max_speed
  end

  def jump
    @vel_y -= jump_power if on_ground?
  end

  def on_ground?
    @on_ground
  end

  def no_velocity?
    @vel_x == 0 and @vel_y == 0
  end

  def move
    @vel_y += @level.gravity if not on_ground?
    @on_ground = false

    rectangle.move_y(@vel_y)
    collide!(:y)
    rectangle.move_x(@vel_x)
    collide!(:x)
    check_state!
  end

  def collide!(velocity)
    @level.object_list.find_all {|o| collided?(o) }.each do |o|
      if velocity == :x
        collide_x(o)
      else
        collide_y(o)
      end
    end
  end

  def check_state!
    if no_velocity?
      stand!
    elsif @vel_y != 0 and not on_ground?
      if @vel_x > 0
        jump_right!
      elsif @vel_x < 0
        jump_left!
      else
        jump!
      end
    elsif @vel_y == 0
      if @vel_x > 0
        run_right!
      elsif @vel_x < 0
        run_left!
      end
    end
  end

  def draw
    current_image.draw(rectangle.x, rectangle.y, 0)
  end

  private

  def current_image
    @view.image(@state)
  end

  def collide_x(object)
    if vel_x > 0
      rectangle.right = object.rectangle.left
    elsif vel_x < 0
      rectangle.left = object.rectangle.right
    end
  end

  def collide_y(object)
    if vel_y > 0
      rectangle.bottom = object.rectangle.top
      @on_ground = true
      @vel_y = 0
    elsif vel_y < 0
      rectangle.top = object.rectangle.bottom
      @vel_y = 0
    end
  end
end
