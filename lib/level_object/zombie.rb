require 'level_object/creature'
require 'geometry_form/collision'

module LevelObject
  class Zombie < LevelObject::Creature
    attr_accessor :go_direction

    def current_image
      images[@state]
    end

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

    def images
      @images ||= {
        stand: @image_registry.image('zombie/s.png'),
        run_right: Animation.new(run_right_images),
        run_left: Animation.new(run_left_images),
      }
    end

    def run_left_images
      %w(l1 l2 l3).map do |file|
        @image_registry.image("zombie/#{file}.png")
      end
    end

    def run_right_images
      %w(r1 r2 r3).map do |file|
        @image_registry.image("zombie/#{file}.png")
      end
    end
  end
end
