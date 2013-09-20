class ObjectList
  attr_accessor :objects
  include Enumerable

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

  def each(&block)
    objects.each(&block)
  end
end
