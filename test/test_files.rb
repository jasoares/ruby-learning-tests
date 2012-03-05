require 'test/unit'

class TestFiles < Test::Unit::TestCase

  FILE_NAME = "test_new_file.txt"
  CONTENT = "sample content"

  def test_create
    File.open(FILE_NAME, "w") do |f|
      f.print CONTENT
    end
    assert File.exists?(FILE_NAME), "The file was not created successfully"
  end

  def test_read
    File.open(FILE_NAME, "r") do |f|
      assert f.readline == CONTENT
    end
  end
  
  def test_read_appended_text
    File.open(FILE_NAME, "a+") do |f|
      f.print CONTENT
    end
    File.open(FILE_NAME, "r") do |f|
      assert f.readline == CONTENT*2
    end
  end
end