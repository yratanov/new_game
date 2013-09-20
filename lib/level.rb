require 'level_object/base'
require 'level_object/wall'
require 'level_object/mud_wall'
require 'level_object/slick_wall'
require 'level_object/triangle_wall'
require 'player'
require 'object_list'

class Level
  attr_accessor :object_list, :width, :height, :matrix
  attr_accessor :player, :lines

  GRAVITY = 0.5

  def initialize(lines, image_registry)
    self.lines = lines
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

  private

  def load_from_lines
    @height ||= lines.size * LevelObject::Base::HEIGHT
    lines.each_with_index do |line, line_idx|
      cells = line.split(//)
      @width ||= cells.size * LevelObject::Base::WIDTH
      cells.each_with_index do |cell, cell_idx|
        case cell
        when '-'
          @object_list << LevelObject::Wall.new(@image_registry, LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
        when 'x'
          @player = Player.new(self, @image_registry)
          @player.warp(LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
        when '|'
          @object_list << LevelObject::SlickWall.new(@image_registry, LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
        when '}'
          @object_list << LevelObject::MudWall.new(@image_registry, LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
        when '/'
          triangle = LevelObject::TriangleWall.new(@image_registry, LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
          triangle.direction = :left
          @object_list << triangle
        when '\\'
          triangle = LevelObject::TriangleWall.new(@image_registry, LevelObject::Base::WIDTH * cell_idx, LevelObject::Base::HEIGHT * line_idx)
          triangle.direction = :right
          @object_list << triangle
        end
      end
    end
  end
end
