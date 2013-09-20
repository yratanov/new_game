require 'animation'

class PlayerView
  HEIGHT = 34
  WIDTH = 25

  def initialize(player, image_registry)
    @player = player
    @image_registry = image_registry
  end

  def image(state)
    images[state]
  end

  def height
    HEIGHT
  end

  def width
    WIDTH
  end

  private

  def images
    @images ||= {
        stand: @image_registry.image('player/0.png'),
        crouch: @image_registry.image('player/d.png'),
        fall: @image_registry.image('player/j.png'),
        jump: @image_registry.image('player/j.png'),
        run_right: Animation.new(run_right_images),
        run_left: Animation.new(run_left_images),
        jump_left: @image_registry.image('player/jl.png'),
        jump_right: @image_registry.image('player/jr.png'),
    }
  end

  def run_left_images
    %w(l1 l2 l3 l4 l5).map do |file|
      @image_registry.image("player/#{file}.png")
    end
  end

  def run_right_images
    %w(r1 r2 r3 r4 r5).map do |file|
      @image_registry.image("player/#{file}.png")
    end
  end
end
