module Hud
  class Text
    attr_accessor :window, :font

    def initialize(window, font)
      @font = font
      @window = window
    end

    def draw
      lines.size.times do |i|
        @font.draw(*line_font_params(i))
      end
    end

    def line_font_params(line_number)
      [lines[line_number], x, 60 + line_number * 20, 0]
    end

    def player
      window.player
    end

    def camera
      window.camera
    end

    def level
      window.level
    end
  end
end
