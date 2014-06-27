require 'level_object/touch_strategy/base'

module LevelObject
  module TouchStrategy
    module Triangle
      class Left < TouchStrategy::Base
        def touch_top(object)
          object.geometry.bottom = wall.geometry.y_at(object.geometry.right)
          object.on_ground = true
          object.vel_y = 0
          object.stand!
        end

        def touch_left(object)
          object.geometry.bottom = wall.geometry.y_at(object.geometry.right)
          object.run_right!
        end

        def touch_right(object)
          object_on_left_side = object.bottom < wall.bottom and
            wall.geometry.dot_inside?(wall.left, wall.bottom)
          if object_on_left_side
            object.bottom = wall.geometry.y_at(object.left)
          else
            object.left = wall.right + 1
            object.vel_x = 0
          end
          object.run_left!
        end
      end
    end
  end
end
