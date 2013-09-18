class Level
  attr_accessor :object_list
  attr_accessor :player

  GRAVITY = 1

  def initialize(lines, image_registry)
    @object_list = ObjectList.new
    lines.each_with_index do |line, line_idx|
      line.split(//).each_with_index do |cell, cell_idx|
        if cell == '-'
          @object_list << Wall.new(image_registry, LevelObject::WIDTH * cell_idx, LevelObject::HEIGHT * line_idx)
        elsif cell == 'x'
          @player = Player.new(self, image_registry)
          @player.warp(LevelObject::WIDTH * cell_idx, LevelObject::HEIGHT * line_idx)
        end
      end
    end
  end

  def gravity
    GRAVITY
  end
end
