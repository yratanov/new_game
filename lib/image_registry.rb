class ImageRegistry
  attr_accessor :images_path

  def initialize(window, images_path)
    @images = {}
    @window = window
    @images_path = images_path
  end

  def image(path)
    if @images[path]
      @images[path]
    else
      image_path =  File.join(ROOT_PATH, File.join(images_path, path))
      @images[path] = Gosu::Image::new(@window, image_path, false)
    end
  end
end
