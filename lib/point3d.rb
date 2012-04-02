require './lib/point.rb'

class Point3D < Point

  @totalZ = 0

  class << self
    attr_accessor :totalZ
  end

  # def self.sum(*points)
  #   z = 0
  #   p2d = super points
  #   points.each { |p| z += p.z }
  #   Point3D.new(p2d.x, p2d.y, z)
  # end

  # def self.report
  #   super
  #   puts "Average Z coordinate: #{@totalZ.to_f/@@n}"
  # end

  def initialize(z)
    @z = z
  end

  def self.new(x, y, z)
    @totalZ += z
    super
  end

  # UNIT_Z = Point3D.new(0, 0, 1)

  def z
    @z
  end

  def z=(value)
    @z = value
  end

  # def +(other)
  #   raise TypeError, "Point3D-like argument expected" unless
  #     other.respond_to? :z
  #   p2d = super(other)
  #   Point3D.new(p2d.x, p2d.y, @z + other.z)
  # end

  # def -@
  #   Point3D.new(-@x, -@y, -@z)
  # end

  # def *(scalar)
  #   Point3D.new(@x * scalar, @y * scalar, @z * scalar)
  # end

  # def add!(p)
  #   @z += p.z
  #   super
  # end

  # def [](index)
  #   case index
  #   when 2, -3, :z, "z" then @z
  #   else super index
  #   end
  # end

  # def each
  #   yield @z
  #   super
  # end

  # def ==(o)
  #   if o.is_a? Point3D
  #     @z == o.z && super
  #   else
  #     false
  #   end
  # end

  # def eql?(o)
  #   self == o and o.instance_of? Point3D
  # end

  # def hash
  #   code = super
  #   code = 31 * code + @z.hash
  #   code
  # end

  # def <=>(other)
  #   return super other unless other.instance_of? Point3D
  #   @x**2 + @y**2 + @z**2 <=> other.x**2 + other.y**2 + other.z**2
  # end

  # def to_s
  #   "(#{@x}, #{@y}, #{@z})"
  # end

end