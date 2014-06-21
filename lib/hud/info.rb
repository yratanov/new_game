require 'hud/text'

module Hud
  class Info < Hud::Text
    def lines
      [
        'Restart: press R',
        'Next level: press N',
        'Previous level: press P',
      ]
    end

    def x
      800
    end
  end
end
