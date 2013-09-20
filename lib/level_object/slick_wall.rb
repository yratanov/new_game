module LevelObject
  class SlickWall < Wall

    VELOCITY = 0.8

    def image_path
      'slick_wall.png'
    end

    def touch_right(player)
      super
      speed_up(player)
    end

    def touch_left(player)
      super
      speed_up(player)
    end

    private

    def speed_up(player)
      player.vel_y += VELOCITY if player.vel_y > 0
      player.vel_y -= VELOCITY if player.vel_y < 0
    end
  end
end
