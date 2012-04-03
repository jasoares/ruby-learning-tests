class Point

  include Enumerable
  include Comparable

  # number of points created, class variable
  @@n = 0
  @@totalX = 0
  @@totalY = 0

  # class instance variables
  class << self
    attr_accessor :totalX, :totalY
  end

  def self.sum(*points)
    x = y = 0
    points.each { |p| x += p.x; y += p.y }
    Point.new(x, y)
  end

  # class method mixing class variables and class instance variables
  def self.report
    puts "Number of points created: #@@n"
    puts "Average X coordinate: #{@@totalX.to_f/@@n}"
    puts "Average Y coordinate: #{@@totalY.to_f/@@n}"
  end

  # class method to reset class variables
  def self.reset
    @@n = @@totalX = @@totalY = 0
  end

  def initialize(x, y)
    @x, @y = x, y
    @@n += 1  # class variable
    @@totalX += x # class instance variable
    @@totalY += y # class instance variable
  end

  ORIGIN = Point.new(0, 0)
  UNIT_X = Point.new(1, 0)
  UNIT_Y = Point.new(0, 1)

  #attr_accessor :x, :y   # Needed when not explicitly defined like below

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

  def add!(p)
    @x += p.x
    @y += p.y
    self
  end

  def add(p)
    q = self.dup
    q.add!(p)
  end

  def [](index)
    case index
    when 0, -2, :x, "x" then @x
    when 1, -1, :y, "y" then @y
    else nil
    end
  end

  def each
    yield @x
    yield @y
  end

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
    code = 31 * code + @x.hash
    code = 31 * code + @y.hash
    code
  end

  def <=>(other)
    return nil unless other.instance_of? Point
    @x**2 + @y**2 <=> other.x**2 + other.y**2
  end

  def to_s
    "(#{@x}, #{@y})"
  end

end
