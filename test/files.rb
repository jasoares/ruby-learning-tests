require 'test/unit'

class TestFiles < Test::Unit::TestCase

  FILE_NAME = "./tmp/test_file.txt"
  CONTENT = "sample content"

  def test_create
    File.open(FILE_NAME, "w") { ; }
    assert File.exists?(FILE_NAME), "The file was not created successfully"
    FileUtils.rm(FILE_NAME)
  end

  def test_read
    File.open(FILE_NAME, "w") do |f|
      f.print CONTENT
    end
    File.open(FILE_NAME) do |f|
      assert_equal CONTENT, f.readline, "The content written should be read from the file"
    end
    FileUtils.rm(FILE_NAME)
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
    FileUtils.rm(FILE_NAME)
  end
end
