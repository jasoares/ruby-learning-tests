class Point

  #attr_accessor :x, :y   # Needed when not explicitly defined
  #attr_reader :x, :y     # Needed when not explicitly defined

  def initialize x, y
    @x, @y = x, y
  end

  def x
    @x
  end

  def y
    @y
  end

  def x=(value)
    @x = value
  end

  def y=(value)
    @y = value
  end

  def +(other)
    raise TypeError, "Point-like argument expected" unless
      other.respond_to? :x and other.respond_to? :y
    Point.new(@x + other.x, @y + other.y)
  end

  def -(other)
    raise TypeError, "Point-like argument expected" unless
      other.respond_to? :-@
    self.+(-other)
  end

  def +@
    self
  end

  def -@
    Point.new(-@x, -@y)
  end

  def *(scalar)
    Point.new(@x * scalar, @y * scalar)
  end

  def coerce(other)
    [self, other]
  end

  def [](index)
    case index
    when 0, -2 then @x
    when 1, -1 then @y
    when :x, "x" then @x
    when :y, "y" then @y
    else nil
    end
  end

  def each
    yield @x
    yield @y
  end

  include Enumerable

  def ==(o)
    if o.is_a? Point
      @x == o.x && @y == o.y
    else
      false
    end
  end

  def eql?(o)
    self == o and o.instance_of? Point
  end

  def hash
    code = 17
    code = 37 * code + @x.hash
    code = 37 * code + @y.hash
    code
  end

  def to_s
    "#{@x}, #{@y}"
  end

end
