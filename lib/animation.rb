class Animation
  attr_accessor :images, :wait_time

  def initialize(images, wait_time = 5)
    @images = images
    @wait_time = wait_time
    reset_wait
    reset_counter
  end

  def finished?
    @counter == images.size - 1
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
    if wait_exceed?
      reset_wait
      @counter += 1
      reset_counter if @counter == images.size
    else
      wait
    end
  end

  def wait
    @wait_counter += 1
  end

  def reset_wait
    @wait_counter = 1
  end

  def reset_counter
    @counter = 0
  end

  def wait_exceed?
    @wait_counter == @wait_time
  end
end
