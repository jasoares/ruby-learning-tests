# -*- encoding: utf-8 -*-
require 'rake/testtask'

task :default => :test
task :test => 'test:default'

namespace :test do

  task :default => 'test:all'

  Rake::TestTask.new(:all) do |t|
    t.test_files = FileList['test_*.rb']
  end

  FileList['test_*.rb'].each do |file|
    name = file.gsub(/test_|\.rb\z/, '')
    desc "Running #{name} tests"
    Rake::TestTask.new(:"#{name}") do |t|
      t.pattern = file
    end
  end

end