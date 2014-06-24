require 'animation'

module LevelObject
  module Creature
    class ZombieView
      def initialize(zombie, image_registry)
        @zombie = zombie
        @image_registry = image_registry
      end

      def image(state)
        images[state]
      end

      def height
        LevelObject::Base::HEIGHT
      end

      def width
        LevelObject::Base::WIDTH
      end

      private

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
end
