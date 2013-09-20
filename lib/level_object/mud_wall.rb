module LevelObject
  class MudWall < Wall

    VELOCITY = 0.6

    def image_path
      'mud_wall.png'
    end

    def touch_right(player)
      super
      slow_down player
    end

    def touch_left(player)
      super
      slow_down player
    end

    private

    def slow_down(player)
      player.vel_y -= VELOCITY if player.vel_y > 0
      player.vel_y += VELOCITY if player.vel_y < 0
    end
  end
end
