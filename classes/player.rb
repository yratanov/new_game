class Player
  attr_accessor :run_speed, :max_speed

  def initialize(window)
    @window = window
    @x = @y = @vel_x = @vel_y = 0.0
    @score = 0
    @animation = :stand
    self.run_speed = 2
    self.max_speed = 10
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def go_left
    @animation = :stand
    @vel_x -= run_speed unless wall_touched?(:left) or max_run_speed?
  end

  def go_right
    @animation = :stand
    @vel_x += run_speed unless wall_touched?(:right) or max_run_speed?
  end

  def crouch
    @animation = :crouch
  end

  def wall_touched?(dir)
    if dir == :right
      @x >= Window::WIDTH - width
    else
      @x <= 10
    end
  end

  def width
    current_image.width + 10
  end

  def max_run_speed?
    @vel_x.abs == max_speed
  end

  def jump
    @animation = :stand
    @vel_y -= 20 if on_ground?
    @jumping = true
  end

  def on_ground?
    @y >= Window::HEIGHT - current_image.height
  end

  def move
    if on_ground?
      @vel_y = 0 unless @jumping
    else
      @vel_y += @window.gravity
    end

    @y += @vel_y
    @x += @vel_x

    @vel_x -= 1 if @vel_x > 0
    @vel_x += 1 if @vel_x < 0
    @jumping = false
  end

  def draw
    current_image.draw(@x, @y, 1, 1)
    font = Gosu::Font.new(@window, 'Courier New', 20)
    font.draw("#{@x} : #{@y}", 0, 0, 0)
    font.draw("y: #{@vel_y} px/min, x: #{@vel_x} px/min", 0, 20, 0)
  end

  def current_image
    images[@animation]
  end

  def images
    @images ||= {
        stand: Gosu::Image.new(@window, @window.root_path + '/media/images/player/0.png', false),
        crouch: Gosu::Image.new(@window, @window.root_path + '/media/images/player/d.png', false),
    }
  end
end
