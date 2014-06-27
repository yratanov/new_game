require 'level_object/creature/base'
require 'level_object/creature/zombie_view'
require 'geometry_form/collision'

module LevelObject
  module Creature
    class Zombie < LevelObject::Creature::Base
      attr_accessor :go_direction

      states :run_right, :run_left, :stand
      view Creature::ZombieView

      def before_move
        self.go_direction ||= [:right, :left].sample

        if vel_x == 0
          stopped!
        end

        if go_direction == :right and stopped?
          unstopped!
          self.go_direction = :left
        elsif go_direction == :left and stopped?
          unstopped!
          self.go_direction = :right
        end

        if go_direction == :left
          go_left
        else
          go_right
        end
      end

      def stopped?
        @stopped == 2
      end

      def stopped!
        @stopped ||= 0
        @stopped += 1
      end

      def unstopped!
        @stopped = 0
      end
    end
  end
end
