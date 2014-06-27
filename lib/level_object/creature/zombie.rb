require 'level_object/creature/base'
require 'level_object/creature/zombie_view'
require 'geometry_form/collision'

module LevelObject
  module Creature
    class Zombie < LevelObject::Creature::Base
      attr_accessor :go_direction

      states :run_right, :run_left, :stand
      view Creature::ZombieView

      def apply_movements
        if go_direction == :right and vel_x == 0
          self.go_direction = :left
        else
          self.go_direction = :right
        end

        if go_direction == :left
          go_left
        else
          go_right
        end
      end
    end
  end
end
