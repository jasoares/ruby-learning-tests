class SampleEnumerable

  attr_accessor :list

  def initialize list
    @list = list
  end

  def collect_with_double
    tmp = @list.map do |e|
      yield e, e*2
    end
    tmp
  end

  def map_twice
    @list.map do |e|
      f = yield e
      yield f
    end
  end

  def increment_by value
    @list = @list.map do |e|
      v = value
      if block_given?
        value = yield value, e
      end
      e + v
    end
  end

end
