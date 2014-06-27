require 'level/file_parser'
require 'player'
require 'object_list'

module Level

  class NotFound < Exception;
  end

  class Base
    attr_accessor :object_list, :width, :height, :matrix
    attr_accessor :player, :lines, :creatures

    GRAVITY = 0.5

    def initialize(filepath, image_registry)
      @image_registry = image_registry
      @filepath = filepath
      load_form_file(@filepath)
    end

    def reload
      load_form_file(@filepath)
    end

    def collide(creature)
      @matrix.each_object_near(creature) do |o|
        if creature.collision.collided?(creature.geometry, o.geometry)
          yield o
        end
      end
    end

    def each_object
      @matrix.each_object do |o|
        yield o
      end
    end

    def gravity
      GRAVITY
    end

    def load_form_file(filepath)
      parser = Level::FileParser.new(@image_registry, self)
      @matrix = parser.parse(filepath)
      self.width = parser.level_width
      self.player = parser.player
      self.height = parser.level_height
    end

    def clear_destroyed
      @matrix.delete_if do |level_object|
        level_object and level_object.marked_to_destroy?
      end
    end
  end
end
