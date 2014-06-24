module LevelObject
  module Mixin
    module View
      attr_reader :view

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        attr_accessor :view_class

        def view(view_class)
          @view_class = view_class
        end
      end
    end
  end
end
