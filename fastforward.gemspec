# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fastforward/version"

Gem::Specification.new do |s|
  s.name        = "fastforward"
  s.version     = FastForward::VERSION
  s.authors     = ["Ben Marini"]
  s.email       = ["bmarini@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A ruby cli wrapper for FFmpeg}
  s.description = %q{A ruby cli wrapper for FFmpeg}

  s.rubyforge_project = "fastforward"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~> 2.8.0"
  # s.add_runtime_dependency "rest-client"
end
