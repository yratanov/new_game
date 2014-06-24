require 'player_view'
require 'level_object/base'
require 'level_object/creature/base'
require 'level_object/mixin/jumper'
require 'geometry_form/collision'

class Player < LevelObject::Creature::Base
  include LevelObject::Mixin::Jumper

  states :stand, :run_right, :run_left, :jump, :jump_left, :jump_right

  view PlayerView

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

  private

  def current_image
    @view.image(@state)
  end
end
