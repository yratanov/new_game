module LevelObject
  module Mixin
    module Jumper
      attr_accessor :jump_power

      def jump_power
        @jump_power ||= self.class.jump_power
      end

      def jump
        @vel_y -= jump_power if on_ground?
      end
    end
  end
end
