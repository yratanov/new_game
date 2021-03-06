require 'level_object/base'
require 'geometry_form/collision'
require 'level_object/mixin/state'
require 'level_object/mixin/view'

module LevelObject
  module Creature
    class Base < LevelObject::Base
      include LevelObject::Mixin::State
      include LevelObject::Mixin::View

      attr_accessor :run_speed, :max_speed, :state, :on_ground,
                    :vel_x, :vel_y, :geometry, :collision, :hp, :max_hp
      class << self
        attr_accessor :run_speed, :max_speed, :jump_power, :default_hp, :max_hp
      end

      states :run_right, :run_left, :stand

      def initialize(image_registry, level, x, y)
        @level = level
        @view = self.class.view_class.new(self, image_registry)
        @image_registry = image_registry
        @vel_x = @vel_y = 0.0
        @geometry = GeometryForm::Rectangle.new(x, y, width, height)
        @collision = GeometryForm::Collision.new
        self.run_speed = self.class.run_speed
        self.max_speed = self.class.max_speed
        self.hp = self.class.default_hp
        self.max_hp = self.class.max_hp
        stand!
      end

      def width
        @view.width
      end

      def height
        @view.height
      end

      def move
        before_move

        @previous_vel_y = @vel_y
        self.state = nil
        @vel_y += @level.gravity unless on_ground?
        @on_ground = false

        geometry.move_y(@vel_y)
        collide!(:y)
        geometry.move_x(@vel_x)
        collide!(:x)

        check_state!
      end

      def before_move
      end

      def on_ground?
        @on_ground
      end

      def no_velocity?
        @vel_x == 0 and @vel_y == 0
      end

      def stand
        @vel_x = 0
      end

      def collide!(velocity)
        @level.collide(self) do |o|
          if velocity == :x
            collide_x(o)
          else
            collide_y(o)
          end
        end
      end

      def check_state!
        return if state != nil
        if @vel_x > 0
          run_right!
        else
          run_left!
        end
      end

      def delta_vel_y
        @previous_vel_y - @vel_y
      end

      def draw
        current_image.draw(geometry.x, geometry.y, 0)
      end

      def current_image
        @view.image(@state)
      end

      def max_run_speed?
        @vel_x.abs > max_speed
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

      def go_left
        @vel_x -= run_speed if @vel_x > 0 or not max_run_speed?
      end

      def go_right
        @vel_x += run_speed if @vel_x < 0 or not max_run_speed?
      end

      def damage(points)
        if points and @hp > 0
          @hp -= points
        end
      end

      def heal(points)
        if points and ((@hp + points.to_i) <= @max_hp)
          @hp += points
        end
      end

      def dead?
        (@hp <= 0)
      end
    end
  end
end
