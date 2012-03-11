# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby-learning-tests/version"

Gem::Specification.new do |s|
  s.name        = "ruby-learning-tests"
  s.version     = Ruby::Learning::Tests::VERSION
  s.authors     = ["João Soares"]
  s.email       = ["jsoaresgeral@gmail.com"]
  s.homepage    = "http://github.com/jasoares/ruby-learning-tests"
  s.summary     = %q{Ruby tests written to learn ruby and their most specific details.}
  s.description = %q{Ruby tests written to learn ruby and their most specific details, differences between versions and other curiosities. Includes version conditional code currently between version 1.8.x and 1.9.x}

  s.rubyforge_project = "ruby-learning-tests"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
