class Wall < LevelObject
  attr_accessor :touched

  def image_path
    'wall.png'
  end

  def touched_path
    'wall_touched.png'
  end
end
