require 'level_object/base'
require 'level_object/wall'
require 'level_object/bomb'
require 'level_object/creature/zombie'
require 'level_object/triangle_wall'
require 'level_object/touch_strategy/base'
require 'level_object/touch_strategy/mud'
require 'level_object/touch_strategy/slick'
require 'level/matrix'
require 'player'

module Level
  class FileParser
    attr_reader :level_height, :level_width, :player

    OBJECT_TYPES = {
      '-' => LevelObject::Wall,
      'x' => Player,
      'Z' => LevelObject::Creature::Zombie,
      '|' => [
        LevelObject::Wall, strategy: LevelObject::TouchStrategy::Slick
      ],
      '=' => [
        LevelObject::Wall,
        strategy: LevelObject::TouchStrategy::Slick,
        direction: :horizontal
      ],
      '}' => [
        LevelObject::Wall,
        strategy: LevelObject::TouchStrategy::Mud
      ],
      '.' => [
        LevelObject::Wall,
        strategy: LevelObject::TouchStrategy::Mud,
        direction: :horizontal
      ],
      '(' => [
        LevelObject::TriangleWall,
        strategy: LevelObject::TouchStrategy::Slick,
        direction: :horizontal,
        wall_direction: :left
      ],
      '/' => [
        LevelObject::TriangleWall,
        wall_direction: :left
      ],
      '\\' => [
        LevelObject::TriangleWall,
        wall_direction: :right
      ],
      '*' => [
        LevelObject::Bomb
      ]
    }

    def initialize(image_registry, level)
      @image_registry = image_registry
      @level = level
    end

    def parse(filepath)
      begin
        lines = File.open(filepath) { |file| file.read }.split /\n/
        load_lines(lines)
      rescue
        raise NotFound.new("Invalid level file: #{filepath}")
      end
    end

    def load_lines(lines)
      matrix = Level::Matrix.new
      @level_height ||= lines.size * LevelObject::Base::HEIGHT

      lines.each_with_index do |line, line_idx|
        cells = line.split(//)
        @level_width ||= cells.size * LevelObject::Base::WIDTH
        cells.each_with_index do |cell, cell_idx|
          next unless OBJECT_TYPES.key?(cell)
          object_options = [*OBJECT_TYPES[cell]]
          if object_options.last.kind_of? Hash
            extra_options = object_options.pop
          else
            extra_options = {}
          end
          object_class = object_options.first
          object = object_at(cell_idx, line_idx, object_class, extra_options)
          matrix.add object, cell_idx, line_idx
          if object.kind_of? Player
            @player = object
          end
        end
      end

      matrix
    end


    def object_at(cell_idx, line_idx, type, extra_options)
      object = type.new(@image_registry, @level, LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
      if extra_options.key?(:strategy)
        object.touch_strategy = extra_options[:strategy].new(object)
      end
      if extra_options.key?(:direction)
        object.touch_strategy.direction = extra_options[:direction]
      end
      if extra_options.key?(:wall_direction)
        object.direction = extra_options[:wall_direction]
      end
      object
    end
  end
end
