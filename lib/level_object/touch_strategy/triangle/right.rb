require 'level_object/touch_strategy/base'

module LevelObject
  module TouchStrategy
    module Triangle
      class Right < TouchStrategy::Base
        def touch_top(object)
          object.bottom = wall.geometry.y_at(object.left)
          object.on_ground = true
          object.vel_y = 0
          object.stand!
        end

        def touch_bottom(object)
          unless object.top < wall.geometry.y_at(object.left)
            super
          end
        end

        def touch_right(object)
          object.bottom = wall.geometry.y_at(object.geometry.left) - 2
          object.run_left!
        end

        def touch_left(object)
          object_on_left_side = object.bottom < wall.bottom and
            wall.geometry.dot_inside?(wall.left, wall.bottom)
          if object_on_left_side
            object.bottom = wall.geometry.y_at(object.left)
          else
            object.right = wall.left - 1
            object.vel_x = 0
          end
          object.run_right!
        end
      end
    end
  end
end
