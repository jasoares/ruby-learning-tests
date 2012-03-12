# -*- encoding: utf-8 -*-
require 'rake/testtask'

TEST_FILES = FileList['test/*.rb']

task :default => :test
desc "Run all tests"
task :test => 'test:default'

namespace :test do

  task :default => 'test:digest'

  Rake::TestTask.new(:digest) do |t|
    t.test_files = TEST_FILES
  end

  desc "Run all tests separately"
  task :all do
    TEST_FILES.each do |tf|
      ruby tf
    end
  end

  TEST_FILES.each do |file|
    tn = file.gsub(/test\/|\.rb\z/, '')
    desc "Run #{tn} tests"
    Rake::TestTask.new(:"#{tn}") do |t|
      t.pattern = file
    end
  end

end
