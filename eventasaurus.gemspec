# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "eventasaurus/version"

Gem::Specification.new do |s|
  s.name        = "eventasaurus"
  s.version     = Eventasaurus::VERSION
  s.authors     = ["Johan van den Dorpe"]
  s.email       = ["jvd@dneg.com"]
  s.homepage    = "http://dneg.com/"
  s.summary     = "Eventasaurus"
  s.description = "Eventasaurus"

  s.rubyforge_project = "eventasaurus"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "trollop"
  s.add_runtime_dependency "daemons"
  s.add_runtime_dependency "stomp"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "thor"
  s.add_runtime_dependency "xmpp4r"

end
