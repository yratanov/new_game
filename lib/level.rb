require 'level_object/base'
require 'level_object/wall'
require 'level_object/bomb'
require 'level_object/triangle_wall'
require 'level_object/touch_strategy/base'
require 'level_object/touch_strategy/mud'
require 'level_object/touch_strategy/slick'
require 'player'
require 'object_list'

class Level
  attr_accessor :object_list, :width, :height, :matrix
  attr_accessor :player, :lines

  GRAVITY = 0.5

  class NotFound < Exception;
  end

  def initialize(filepath, image_registry)
    load_lines_form_file(filepath)
    @image_registry = image_registry
    @object_list = ObjectList.new
    load_from_lines
  end

  def reload
    @object_list = ObjectList.new
    load_from_lines
  end

  def gravity
    GRAVITY
  end

  def load_lines_form_file(filepath)
    begin
      self.lines = File.open(filepath) { |file| file.read }.split /\n/
    rescue
      raise NotFound.new("Invalid level file: #{filepath}")
    end
  end

  private

  def load_from_lines
    @height ||= lines.size * LevelObject::Base::HEIGHT
    lines.each_with_index do |line, line_idx|
      cells = line.split(//)
      @width ||= cells.size * LevelObject::Base::WIDTH
      cells.each_with_index do |cell, cell_idx|
        case cell
        when '-'
          @object_list << wall_at(cell_idx, line_idx, LevelObject::Wall)
        when 'x'
          @player = Player.new(self, @image_registry)
          @player.warp(LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
        when '|'
          wall = wall_at(cell_idx, line_idx, LevelObject::Wall)
          wall.touch_strategy = LevelObject::TouchStrategy::Slick.new(wall)
          @object_list << wall
        when '='
          wall = wall_at(cell_idx, line_idx, LevelObject::Wall)
          wall.touch_strategy = LevelObject::TouchStrategy::Slick.new(wall)
          wall.touch_strategy.direction = :horizontal
          @object_list << wall
        when '}'
          wall = wall_at(cell_idx, line_idx, LevelObject::Wall)
          wall.touch_strategy = LevelObject::TouchStrategy::Mud.new(wall)
          @object_list << wall
        when '.'
          wall = wall_at(cell_idx, line_idx, LevelObject::Wall)
          wall.touch_strategy = LevelObject::TouchStrategy::Mud.new(wall)
          wall.touch_strategy.direction = :horizontal
          @object_list << wall
        when '('
          triangle = wall_at(cell_idx, line_idx, LevelObject::TriangleWall)
          triangle.touch_strategy = LevelObject::TouchStrategy::Slick.new(triangle)
          triangle.touch_strategy.direction = :horizontal
          triangle.direction = :left
          @object_list << triangle
        when '/'
          triangle = wall_at(cell_idx, line_idx, LevelObject::TriangleWall)
          triangle.direction = :left
          @object_list << triangle
        when '\\'
          triangle = wall_at(cell_idx, line_idx, LevelObject::TriangleWall)
          triangle.direction = :right
          @object_list << triangle
        when '*'
          @object_list << wall_at(cell_idx, line_idx, LevelObject::Bomb)
        end
      end
    end
  end

  def wall_at(cell_idx, line_idx, type)
    type.new(@image_registry, LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
  end

end
