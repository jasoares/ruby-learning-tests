class Person

  attr_accessor :fname, :lname

  def initialize fname, lname
    @fname, @lname = fname, lname
  end

  def to_s
    "Name: #{@fname} #{@lname}"
  end

  def to_str
    "#{@fname} #{@lname}"
  end

  def to_ary
    [@fname, @lname]
  end

  alias :to_a :to_ary
end