require './lib/person.rb'

class Customer < Person

  attr_accessor :email

  def initialize fname, lname, email
    super fname, lname
    @email = email
  end

  def to_s
    super << "\nEmail: #{@email}"
  end

  def to_str
    super << ", #{@email}"
  end

end
