class Person

  attr_accessor :fname, :lname

  def initialize fname, lname
    @fname, @lname = fname, lname
  end

  def to_ary
    [@fname, @lname]
  end

  def to_s
    "Name: #{@fname} #{@lname}"
  end

  def to_str
    "#{@fname} #{@lname}"
  end

  def == o
    o.respond_to?(:fname) && o.respond_to?(:lname) ?
      @fname == o.fname &&
      @lname == o.lname :
      false
  end

  def eql? o
    o.equal?(self) ? true : (self.class == o.class ? self == o : false)
  end

  alias :to_a :to_ary
end