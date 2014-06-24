require 'rubygems'
require 'bundler/setup'
require 'gosu'

ROOT_PATH = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(File.join(ROOT_PATH, 'lib'))

require 'camera'
require 'level/base'
require 'config'
require 'image_registry'
require 'hud/debug'
require 'hud/info'


class Window < Gosu::Window
  attr_reader :level
  attr_accessor :show_debug, :camera

  def initialize(width, height)
    @width = width
    @height = height
    super(width, height, false)
    self.caption = 'Jump, jump!'

    configure_player
    configure_debug
    @camera = Camera.new(self)
    @font = Gosu::Font.new(self, 'Courier New', 18)
    @image_registry = ImageRegistry.new(self, '/media/images')
  end

  def update
    return if @error
    if left_pressed?
      player.go_left
    elsif right_pressed?
      player.go_right
    end

    if up_pressed?
      player.jump
    end

    if not right_pressed? and not left_pressed? and not up_pressed?
      player.stand
    end

    player.move
    camera.target(player)
    level.clear_destroyed
  end

  def reload
    @level.reload
    @camera.target(player)
  end

  def right_pressed?
    button_down? Gosu::KbRight or button_down? Gosu::GpRight
  end

  def left_pressed?
    button_down? Gosu::KbLeft or button_down? Gosu::GpLeft
  end

  def up_pressed?
    button_down? Gosu::KbUp or button_down? Gosu::GpButton0
  end

  def draw
    if @error
      draw_error!
    else
      translate(-camera.rectangle.left, -camera.rectangle.top) do
        player.draw
        level.each_object do |o|
          o.draw if camera.can_see?(o)
        end
      end
      draw_debug! if show_debug
    end
    draw_info!
  end

  def draw_debug!
    @debug ||= Hud::Debug.new(self, @font)
    @debug.draw
  end

  def draw_error!
    @font.draw(@error, 350, 350, 0)
  end

  def draw_info!
    @info ||= Hud::Info.new(self, @font)
    @info.draw
  end

  def load_level(number)
    @current_level = number
    path = "levels/#{@current_level}"
    @error = nil
    begin
      @level = Level::Base.new(path, @image_registry)
      @camera.target(player)
    rescue Level::NotFound => e
      @error = e.message
    end
  end

  def player
    level.player
  end

  def object_list
    level.object_list
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbR
      reload
    elsif id == Gosu::KbN
      next_level
    elsif id == Gosu::KbP
      previous_level
    end
  end

  def previous_level
    load_level(@current_level - 1)
  end

  def next_level
    load_level(@current_level + 1)
  end

  private

  def configure_player
    config = Game::Config.load(:player)
    Player.run_speed = config['run_speed']
    Player.max_speed = config['max_speed']
    Player.jump_power = config['jump_power']
  end

  def configure_debug
    config = Game::Config.load(:debug)
    self.show_debug = config['show_all']
  end
end


window = Window.new(1024, 768)
window.load_level(1)
window.show
