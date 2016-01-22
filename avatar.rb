class Avatar
  attr_reader :x, :y

  def initialize(src)
    @image = Gosu::Image.new("media/avatar-#{src.to_s.rjust(3,'0')}")
    @x = rand * 640
    @y = rand * 480
  end

  def draw
    @image.draw(@x - 35.0/@image.width / 2.0, @y - 35.0/@image.width / 2.0,
             ZOrder::STARS, 35.0/@image.width, 35.0/@image.width)
  end

end
