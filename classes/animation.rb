class Animation
  attr_accessor :images, :wait_time

  def initialize(images, wait_time = 5)
    @images = images
    @wait_time = wait_time
    @wait_counter = 0
    @counter = 0
  end

  def draw(*args)
    current_image.draw(*args)
    tick
  end

  def height
    current_image.height
  end

  def width
    current_image.width
  end

  def current_image
    images[@counter]
  end

  private

  def tick
    if @counter == images.size - 1
      @counter = 0
      @wait_counter += 1
    elsif wait_exceed?
      reset_wait
      @counter += 1
    else
      wait
    end
  end

  def wait
    @wait_counter += 1
  end

  def reset_wait
    @wait_counter = 0
  end

  def wait_exceed?
    @wait_counter == @wait_time
  end
end
