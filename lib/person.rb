class Person

  attr_accessor :fname, :lname

  def initialize fname, lname
    @fname, @lname = fname, lname
  end

  def initialize_copy orig
    @fname, @lname = orig.fname, "#{orig.lname}'s clone"
  end

  def taint
    @fname.taint
    @lname.taint
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
    # Accepts to compare descendants and is symmetric a.eql?(b) == b.eql?(a)
    o.equal?(self) ? true : (o.is_a?(self.class) || self.is_a?(o.class) ? self == o : false)
  end

  alias :to_a :to_ary
end
