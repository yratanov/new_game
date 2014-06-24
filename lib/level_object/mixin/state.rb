module LevelObject
  module Mixin
    module State
      attr_accessor :state

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def states(*states)
          states.each do |state|
            define_method "#{state}?" do
              @state == state
            end

            define_method "#{state}!" do
              @state = state
            end
          end
        end
      end
    end
  end
end
