module LevelObject
  module TouchStrategy
    module Direction
      attr_accessor :direction

      DIRECTIONS = [:horizontal, :vertical]

      DIRECTIONS.each do |dir|
        define_method "#{dir}?" do
          direction == dir.to_sym
        end
      end
    end
  end
end
