require 'player_view'
require 'geometry_form/collision'

class Player < LevelObject::Base
  attr_accessor :run_speed, :max_speed, :jump_power, :vel_x, :vel_y, :geometry, :on_ground, :state

  STATES = [:crouch, :stand, :run_right, :run_left, :jump, :jump_left, :jump_right]

  def initialize(level, image_registry)
    @level = level
    @view = PlayerView.new(self, image_registry)
    @vel_x = @vel_y = 0.0
    @geometry = GeometryForm::Rectangle.new(0, 0, width, height)
    @collision = GeometryForm::Collision.new
    self.run_speed = 2
    self.max_speed = 4
    self.jump_power = 10
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
    geometry.warp(x, y)
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
    @vel_x.abs > max_speed
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
    @previous_vel_y = @vel_y
    self.state = nil
    @vel_y += @level.gravity if not on_ground?
    @on_ground = false

    geometry.move_y(@vel_y)
    collide!(:y)
    geometry.move_x(@vel_x)
    collide!(:x)

    check_state!
  end

  def collide!(velocity)
    @level.object_list.find_all {|o| @collision.collided?(self.geometry, o.geometry) }.each do |o|
      if velocity == :x
        collide_x(o)
      else
        collide_y(o)
      end
    end
  end

  def check_state!
    return if state != nil
    if no_velocity? and not delta_vel_y < 0
      stand!
    elsif (@vel_y != 0 and not on_ground?) or delta_vel_y < 0 # jumping, or in the highest point while jumping(vel_y = 0)
      if @vel_x > 0
        jump_right!
      elsif @vel_x < 0
        jump_left!
      else
        jump!
      end
    elsif @vel_y == 0 and delta_vel_y >= 0
      if @vel_x > 0
        run_right!
      elsif @vel_x < 0
        run_left!
      end
    end
  end

  def delta_vel_y
    @previous_vel_y - @vel_y
  end

  def draw
    current_image.draw(geometry.x, geometry.y, 0)
  end

  private

  def current_image
    @view.image(@state)
  end

  def collide_x(object)
    if vel_x > 0
      object.touch_left(self)
    elsif vel_x < 0
      object.touch_right(self)
    end
  end

  def collide_y(object)
    if vel_y > 0
      object.touch_top(self)
    elsif vel_y < 0
      object.touch_bottom(self)
    end
  end
end
