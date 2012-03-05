# -*- encoding: utf-8 -*-
require 'rake/testtask'

TEST_FILES = FileList['test/test_*.rb']

task :default => :test
task :test => 'test:default'

namespace :test do

  task :default => 'test:all'

  Rake::TestTask.new(:all) do |t|
    t.test_files = TEST_FILES
  end

  TEST_FILES.each do |file|
    tn = file.gsub(/test\/test_|\.rb\z/, '')
    desc "Running #{tn} tests"
    Rake::TestTask.new(:"#{tn}") do |t|
      t.pattern = file
    end
  end

end