require 'minitest/autorun'
require 'minitest/pride'
require 'fileutils'

class TestFiles < MiniTest::Unit::TestCase

  FILE_NAME = "./tmp/test_file.txt"
  CONTENT = "sample content"

  def teardown
    FileUtils.rm(FILE_NAME)
  end

  def test_create
    File.open(FILE_NAME, "w") { ; }
    assert File.exists?(FILE_NAME), "The file was not created successfully"
  end

  def test_read
    File.open(FILE_NAME, "w") do |f|
      f.print CONTENT
    end
    File.open(FILE_NAME) do |f|
      assert_equal CONTENT, f.readline, "The content written should be read from the file"
    end
  end
  
  def test_read_appended_text
    File.open(FILE_NAME, "w") do |f|
      f.print CONTENT
    end
    File.open(FILE_NAME, "a") do |f|
      f.print CONTENT
    end
    File.open(FILE_NAME) do |f|
      assert_equal CONTENT*2, f.readline, "The content appended should be read from the file"
    end
  end
end
