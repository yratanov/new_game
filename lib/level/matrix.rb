require 'level_object/base'

module Level
  class Matrix

    NEAR_OBJECT_RADIUS = 5

    def initialize
      @objects = []
    end

    def add(object, i, j)
      @objects[i] ||= []
      @objects[i][j] = object
    end

    def each_object
      @objects.each do |line|
        line.compact.each do |object|
          next unless object
          yield object
        end
      end
    end

    def each_object_near(creature)
      i = (creature.geometry.x / LevelObject::Base::WIDTH).to_i
      j = (creature.geometry.y / LevelObject::Base::HEIGHT).to_i

      for y in (j-NEAR_OBJECT_RADIUS .. j+NEAR_OBJECT_RADIUS)
        for x in (i-NEAR_OBJECT_RADIUS .. i+NEAR_OBJECT_RADIUS)
          yield @objects[x][y] if @objects[x][y]
        end
      end
    end

    def delete_if(&block)
      @objects.each do |line|
        line.delete_if &block
      end
    end
  end
end
