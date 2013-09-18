require 'tins'

class String
  include Tins::StringUnderscore
end

class Object

  # it's a class method, not an instance one
  class << self

    # preserves the original method
    alias_method :old_const_missing, :const_missing
    private :old_const_missing

    # redefine the method which is called on a missing const
    def const_missing(const)

      # guess a filename (use your favorite algorithm)
      filename = File.join('./classes', const.to_s.underscore)
      begin
        # try to require it
        require filename

        # if it did, returns that missing const
        const_get(const)

      rescue LoadError => e
        if e.message.include? filename

          # that constant doesn't really exist; use the old method
          old_const_missing(const)

        else

          # other reason
          raise

        end
      end
    end
  end
end
