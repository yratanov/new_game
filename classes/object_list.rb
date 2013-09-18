class ObjectList
  attr_accessor :objects

  def initialize
    self.objects = []
  end

  def <<(object)
    objects << object
  end

  def draw
    objects.each do |o|
      o.draw
    end
  end
end
